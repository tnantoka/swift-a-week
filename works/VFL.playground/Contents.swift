//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

class View: UIView {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRectZero)
        imageView.backgroundColor = UIColor.grayColor()
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["imageView": imageView]
        
        let vertical = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-[imageView]",
            options: [],
            metrics: nil,
            views: views
        )
        let horizontal = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[imageView]-|",
            options: [],
            metrics: nil,
            views: views
        )
        let height = NSLayoutConstraint(
            item: imageView,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: imageView,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0.0)
        
        NSLayoutConstraint.activateConstraints(vertical + horizontal + [height])
        
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRectZero)
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.lightGrayColor()
        label.numberOfLines = 0
        
        let views = [
            "imageView": self.imageView,
            "label": label
        ]
        
        let vertical = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[imageView]-[label]",
            options: [],
            metrics: nil,
            views: views
        )
        let horizontal = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[label]-|",
            options: [],
            metrics: nil,
            views: views
        )
        let spacing = NSLayoutConstraint(
            item: label,
            attribute: .Bottom,
            relatedBy: .LessThanOrEqual,
            toItem: self,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: -8.0)

        NSLayoutConstraint.activateConstraints(vertical + horizontal + [spacing])
        
        return label
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



let view = View(frame: CGRectMake(0, 0, 200, 300))
view.label.text = "line 1"

let view2 = View(frame: CGRectOffset(view.frame, CGRectGetMaxX(view.frame), 0))
view2.label.text = "line 1\nline 2\nline 3\nline 4\nline 5"

let container = UIView(frame: CGRectMake(0, 0, CGRectGetMaxX(view2.frame), CGRectGetHeight(view.bounds)))
container.addSubview(view)
container.addSubview(view2)

XCPlaygroundPage.currentPage.liveView = container
