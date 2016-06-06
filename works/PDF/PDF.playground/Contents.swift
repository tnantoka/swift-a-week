//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import CoreGraphics

class PDFView: UIView {
    var page: CGPDFPage?
    
    override func drawRect(rect: CGRect) {
        guard let page = page else { return }
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextTranslateCTM(context, 0, rect.size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        
        let box = CGPDFPageGetBoxRect(page, .MediaBox)
        
        let xScale = rect.size.width / box.size.width
        let yScale = rect.size.height / box.size.height
        let scale = min(xScale, yScale)
        
        let tx = (rect.size.width - box.size.width * scale) / 2
        let ty = (rect.size.height - box.size.height * scale) / 2
        CGContextTranslateCTM(context, tx, ty)

        CGContextScaleCTM(context, scale, scale)
        
        CGContextDrawPDFPage(context, page)
    }
}

let url = NSURL(string: "http://www.swiftaweek.com/works/PDF/example.pdf")
let doc = CGPDFDocumentCreateWithURL(url)

let pages = CGPDFDocumentGetNumberOfPages(doc)
print(pages)

let number = 1
let page = CGPDFDocumentGetPage(doc, number)

let view = PDFView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
view.backgroundColor = UIColor.lightGrayColor()
view.page = page

XCPlaygroundPage.currentPage.liveView = view
