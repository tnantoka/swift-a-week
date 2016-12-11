//
//  HandwritingView.swift
//  Swift-AI-iOS
//
//  Created by Collin Hundley on 12/3/15.
//

import UIKit

class HandwritingCanvasView: UIView {
    
    let canvas = UIImageView()
    let snapshotBox = UIView()
    
    let brushWidth: CGFloat = 20
    
    // Drawing state variables
    fileprivate var lastDrawPoint = CGPoint.zero
    fileprivate var boundingBox: CGRect?
    fileprivate var swiped = false
    fileprivate var drawing = false
    fileprivate var timer = Timer()

    var network: FFNN!

    var onOutput: ((String, String) -> Void)!
    var onScan: ((UIImage) -> Void)!
    var onError: ((Void) -> Void)!
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        let url = Bundle.main.url(forResource: "handwriting-ffnn", withExtension: nil)!
        network = FFNN.fromFile(url)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        // Add Subviews
        addSubviews(canvas, snapshotBox)

        // Style Subviews
        canvas.backgroundColor = .clear
        
        snapshotBox.backgroundColor = UIColor.clear
        snapshotBox.layer.borderColor = UIColor.green.cgColor
        snapshotBox.layer.borderWidth = 2
        snapshotBox.layer.cornerRadius = 6
        snapshotBox.alpha = 0
    }
    
    override func updateConstraints() {
        
        // Configure Subviews
        configureSubviews()
        
        canvas.fillSuperview()
        
        super.updateConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        swiped = false
        guard canvas.frame.contains(touch.location(in: self)) else {
            super.touchesBegan(touches, with: event)
            return
        }
        timer.invalidate()
        let location = touch.location(in: canvas)
        if boundingBox == nil {
            boundingBox = CGRect(x: location.x - brushWidth / 2,
                                      y: location.y - brushWidth / 2,
                                      width: brushWidth,
                                      height: brushWidth)
        }
        lastDrawPoint = location
        drawing = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        guard canvas.frame.contains(touch.location(in: self)) else {
            super.touchesMoved(touches, with: event)
            swiped = false
            return
        }
        let currentPoint = touch.location(in: canvas)
        if swiped {
            drawLine(fromPoint: lastDrawPoint, toPoint: currentPoint)
        } else {
            drawLine(fromPoint: currentPoint, toPoint: currentPoint)
            swiped = true
        }
        if currentPoint.x < boundingBox!.minX {
            updateRect(&boundingBox!, minX: currentPoint.x - brushWidth - 20, maxX: nil, minY: nil, maxY: nil)
        } else if currentPoint.x > boundingBox!.maxX {
            updateRect(&boundingBox!, minX: nil, maxX: currentPoint.x + brushWidth + 20, minY: nil, maxY: nil)
        }
        if currentPoint.y < boundingBox!.minY {
            updateRect(&boundingBox!, minX: nil, maxX: nil, minY: currentPoint.y - brushWidth - 20, maxY: nil)
        } else if currentPoint.y > boundingBox!.maxY {
            updateRect(&boundingBox!, minX: nil, maxX: nil, minY: nil, maxY: currentPoint.y + brushWidth + 20)
        }
        lastDrawPoint = currentPoint
        timer.invalidate()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        if canvas.frame.contains(touch.location(in: self)) {
            if !swiped {
                // Draw dot
                drawLine(fromPoint: lastDrawPoint, toPoint: lastDrawPoint)
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(timerExpired), userInfo: nil, repeats: false)
        drawing = false
        super.touchesEnded(touches, with: event)
    }
    
    func timerExpired(_ sender: Timer) {
        classifyImage()
        boundingBox = nil
    }
}

extension HandwritingCanvasView {
    
    fileprivate func classifyImage() {
        // Extract and resize image from drawing canvas
        guard let imageArray = scanImage() else {
            clearCanvas()
            return
        }
        do {
            let output = try network.update(inputs: imageArray)
            if let (label, confidence) = outputToLabel(output) {
                onOutput("\(label)", "\((confidence * 100).toString(decimalPlaces: 2))%")
            } else {
                onError()
            }
        } catch {
            print(error)
        }
        
        // Clear the canvas
        clearCanvas()
    }
    
    fileprivate func outputToLabel(_ output: [Float]) -> (label: Int, confidence: Double)? {
        guard let max = output.max() else {
            return nil
        }
        return (output.index(of: max)!, Double(max / 1.0))
    }
    
    fileprivate func scanImage() -> [Float]? {
        var pixelsArray = [Float]()
        guard let image = canvas.image else {
            return nil
        }
        // Extract drawing from canvas and remove surrounding whitespace
        let croppedImage = cropImage(image, toRect: boundingBox!)
        // Scale character to max 20px in either dimension
        let scaledImage = scaleImageToSize(croppedImage, maxLength: 20)
        // Center character in 28x28 white box
        let character = addBorderToImage(scaledImage)
        
        onScan(character)
        
        let pixelData = (character.cgImage)?.dataProvider?.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let bytesPerRow = (character.cgImage)?.bytesPerRow
        let bytesPerPixel = (((character.cgImage)?.bitsPerPixel)! / 8)
        var position = 0
        for _ in 0..<Int(character.size.height) {
            for _ in 0..<Int(character.size.width) {
                let alpha = Float(data[position + 3])
                pixelsArray.append(alpha / 255)
                position += bytesPerPixel
            }
            if position % bytesPerRow! != 0 {
                position += (bytesPerRow! - (position % bytesPerRow!))
            }
        }
        return pixelsArray
    }
    
    fileprivate func cropImage(_ image: UIImage, toRect: CGRect) -> UIImage {
        let imageRef = image.cgImage!.cropping(to: toRect)
        let newImage = UIImage(cgImage: imageRef!)
        return newImage
    }
    
    fileprivate func scaleImageToSize(_ image: UIImage, maxLength: CGFloat) -> UIImage {
        let size = CGSize(width: min(20 * image.size.width / image.size.height, 20), height: min(20 * image.size.height / image.size.width, 20))
        let newRect = CGRect(x: 0, y: 0, width: size.width, height: size.height).integral
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        let context = UIGraphicsGetCurrentContext()
        context!.interpolationQuality = CGInterpolationQuality.none
        image.draw(in: newRect)
        let newImageRef = (context?.makeImage()!)! as CGImage
        let newImage = UIImage(cgImage: newImageRef, scale: 1.0, orientation: UIImageOrientation.up)
        UIGraphicsEndImageContext()
        return newImage
    }
    
    fileprivate func addBorderToImage(_ image: UIImage) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 28, height: 28))
        let white = UIImage(named: "white")!
        white.draw(at: CGPoint.zero)
        image.draw(at: CGPoint(x: (28 - image.size.width) / 2, y: (28 - image.size.height) / 2))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    fileprivate func clearCanvas() {
        // Show snapshot box
        if let box = boundingBox {
            snapshotBox.frame = box
            snapshotBox.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                self.snapshotBox.alpha = 1
                self.snapshotBox.transform = CGAffineTransform(scaleX: 1.06, y: 1.06)
            }, completion: nil)
            UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                self.snapshotBox.transform = CGAffineTransform.identity
            }, completion: nil)
        }
        
        UIView.animate(withDuration: 1.0, delay: 0.4, options: [.curveEaseIn], animations: { () -> Void in
            self.canvas.alpha = 0
            self.snapshotBox.alpha = 0
        }) { (Bool) -> Void in
            self.canvas.image = nil
            self.canvas.alpha = 1
        }
    }
    
    fileprivate func drawLine(fromPoint: CGPoint, toPoint: CGPoint) {
        // Begin context
        var frame = canvas.frame
        frame.size.width = round(frame.width)
        frame.size.height = round(frame.height)
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()
        // Store current image (lines drawn) in context
        canvas.image?.draw(in: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        // Append new line to image
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brushWidth)
        context?.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        context?.setBlendMode(CGBlendMode.normal)
        context?.strokePath()
        // Store modified image back to imageView
        canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        // End context
        UIGraphicsEndImageContext()
    }
    
    fileprivate func updateRect(_ rect: inout CGRect, minX: CGFloat?, maxX: CGFloat?, minY: CGFloat?, maxY: CGFloat?) {
        rect = CGRect(x: minX ?? rect.minX,
                      y: minY ?? rect.minY,
                      width: (maxX ?? rect.maxX) - (minX ?? rect.minX),
                      height: (maxY ?? rect.maxY) - (minY ?? rect.minY))
    }
    
}

extension Double {
    /// Returns the receiver's string representation, truncated to the given number of decimal places.
    /// - parameter decimalPlaces: The maximum number of allowed decimal places
    public func toString(decimalPlaces: Int) -> String {
        let power = pow(10.0, Double(decimalPlaces))
        return "\( Darwin.round(power * self) / power)"
    }
}



