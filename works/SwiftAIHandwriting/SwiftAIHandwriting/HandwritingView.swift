//
//  HandwritingView.swift
//  SwiftAIHandwriting
//
//  Created by Tatsuya Tobioka on 12/6/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit

class HandwritingView: UIView {
    
    let canvasContainer = UIView()
    let canvas1 = HandwritingCanvasView()
    let canvas2 = HandwritingCanvasView()
    let outputContainer = UIView()
    let outputLabel = UILabel()
    let confidenceLabel = UILabel()
    let imageView = UIImageView()
    
    let brushWidth: CGFloat = 20
    
    // Drawing state variables
    fileprivate var lastDrawPoint = CGPoint.zero
    fileprivate var boundingBox: CGRect?
    fileprivate var swiped = false
    fileprivate var drawing = false
    fileprivate var timer = Timer()
    
    var network: FFNN!
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        let url = Bundle.main.url(forResource: "handwriting-ffnn", withExtension: nil)!
        self.network = FFNN.fromFile(url)

        [canvas1, canvas2].forEach { canvas in
            canvas.onOutput = { output, confidence in
                self.updateOutputLabels(output, confidence: confidence)
            }
            canvas.onScan = { character in
                self.imageView.image = character
            }
            canvas.onError = {
                self.outputLabel.text = "Error"
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        // Add Subviews
        addSubviews(canvasContainer, outputContainer, imageView)
        canvasContainer.addSubviews(canvas1, canvas2)
        outputContainer.addSubviews(outputLabel, confidenceLabel)
        
        // Style View
        backgroundColor = UIColor.lightGray
        
        // Style Subviews
        canvasContainer.layer.cornerRadius = 3
        canvasContainer.layer.shadowColor = UIColor.gray.cgColor
        canvasContainer.layer.shadowOpacity = 0.4
        canvasContainer.layer.shadowOffset = CGSize(width: 1, height: 3)
        
        canvas1.backgroundColor = .white
        canvas2.backgroundColor = .white
        
        outputContainer.backgroundColor = .white
        outputContainer.layer.cornerRadius = 4
        outputContainer.layer.shadowColor = UIColor.gray.cgColor
        outputContainer.layer.shadowOpacity = 0.3
        outputContainer.layer.shadowOffset = CGSize(width: 1, height: 3)
        
        outputLabel.textColor = .black
        outputLabel.textAlignment = .center
        outputLabel.font = UIFont.systemFont(ofSize: 100.0)
        
        confidenceLabel.textColor = .black
        confidenceLabel.textAlignment = .right
        confidenceLabel.font = UIFont.systemFont(ofSize: 15.0)
        
        imageView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = 4
        imageView.layer.shadowColor = UIColor.gray.cgColor
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.shadowOffset = CGSize(width: 1, height: 3)
        imageView.contentMode = .scaleAspectFit
    }
    
    override func updateConstraints() {
        
        // Configure Subviews
        configureSubviews()
        
        // Add Constraints
        canvasContainer.addConstraints(
            Constraint.llrr.of(self, offset: 10),
            Constraint.tt.of(self, offset: 20),
            Constraint.hw.of(self, offset: -20))
        
        canvas1.addConstraints(
            Constraint.ll.of(canvasContainer),
            Constraint.rcx.of(canvasContainer, offset: -1),
            Constraint.tt.of(canvasContainer),
            Constraint.bb.of(canvasContainer))
        
        canvas2.addConstraints(
            Constraint.lcx.of(canvasContainer, offset: 1),
            Constraint.rr.of(canvasContainer),
            Constraint.tt.of(canvasContainer),
            Constraint.bb.of(canvasContainer))

        imageView.addConstraints(
            Constraint.ll.of(self, offset: 10),
            Constraint.rcx.of(self, offset: -7),
            Constraint.tb.of(canvasContainer, offset: 15),
            Constraint.bb.of(self, offset: -15))
        
        outputContainer.addConstraints(
            Constraint.lcx.of(self, offset: 7),
            Constraint.rr.of(self, offset: -10),
            Constraint.tb.of(canvasContainer, offset: 15),
            Constraint.bb.of(self, offset: -15))
        
        outputLabel.centerInSuperview()
        
        confidenceLabel.addConstraints(
            Constraint.rr.of(outputContainer),
            Constraint.bb.of(outputContainer))
        
        super.updateConstraints()
    }
    
    fileprivate func updateOutputLabels(_ output: String, confidence: String) {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            self.outputLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.outputLabel.text = output
            self.confidenceLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.confidenceLabel.text = confidence
        }, completion: nil)
        UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            self.outputLabel.transform = CGAffineTransform.identity
            self.confidenceLabel.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
