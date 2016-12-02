//
//  HandwritingView.swift
//  Swift-AI-iOS
//
//  Created by Collin Hundley on 12/3/15.
//

import UIKit

class HandwritingView: UIView {
    
    let canvasContainer = UIView()
    let canvas = UIImageView()
    let snapshotBox = UIView()
    let outputContainer = UIView()
    let outputLabel = UILabel()
    let confidenceLabel = UILabel()
    let imageView = UIImageView()
    
    convenience init() {
        self.init(frame: CGRect.zero)
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
        self.addSubviews(self.canvasContainer, self.outputContainer, self.imageView)
        self.canvasContainer.addSubviews(self.canvas, self.snapshotBox)
        self.outputContainer.addSubviews(self.outputLabel, self.confidenceLabel)
        
        // Style View
        self.backgroundColor = UIColor.lightGray
        
        // Style Subviews
        self.canvasContainer.backgroundColor = .white
        self.canvasContainer.layer.cornerRadius = 3
        self.canvasContainer.layer.shadowColor = UIColor.gray.cgColor
        self.canvasContainer.layer.shadowOpacity = 0.4
        self.canvasContainer.layer.shadowOffset = CGSize(width: 1, height: 3)
        
        self.canvas.backgroundColor = .clear
        
        self.snapshotBox.backgroundColor = UIColor.clear
        self.snapshotBox.layer.borderColor = UIColor.green.cgColor
        self.snapshotBox.layer.borderWidth = 2
        self.snapshotBox.layer.cornerRadius = 6
        self.snapshotBox.alpha = 0
        
        self.outputContainer.backgroundColor = .white
        self.outputContainer.layer.cornerRadius = 4
        self.outputContainer.layer.shadowColor = UIColor.gray.cgColor
        self.outputContainer.layer.shadowOpacity = 0.3
        self.outputContainer.layer.shadowOffset = CGSize(width: 1, height: 3)
        
        self.outputLabel.textColor = .black
        self.outputLabel.textAlignment = .center
        self.outputLabel.font = UIFont.systemFont(ofSize: 100.0)
        
        self.confidenceLabel.textColor = .black
        self.confidenceLabel.textAlignment = .right
        self.confidenceLabel.font = UIFont.systemFont(ofSize: 15.0)
        
        self.imageView.backgroundColor = UIColor.white
        self.imageView.layer.cornerRadius = 4
        self.imageView.layer.shadowColor = UIColor.gray.cgColor
        self.imageView.layer.shadowOpacity = 0.3
        self.imageView.layer.shadowOffset = CGSize(width: 1, height: 3)
        self.imageView.contentMode = .scaleAspectFit
    }
    
    override func updateConstraints() {
        
        // Configure Subviews
        self.configureSubviews()
        
        // Add Constraints
        canvasContainer.addConstraints(
            Constraint.llrr.of(self, offset: 10),
            Constraint.tt.of(self, offset: 15),
            Constraint.hw.of(self, offset: -20))
        
//        self.canvasContainer.constrainUsing(constraints: [
//            Constraint.ll : (of: self, offset: 10),
//            Constraint.rr : (of: self, offset: -10),
//            Constraint.tt : (of: self, offset: 15),
//            Constraint.hw : (of: self, offset: -20)])
        
        self.canvas.fillSuperview()
        
        imageView.addConstraints(
            Constraint.ll.of(self, offset: 10),
            Constraint.rcx.of(self, offset: -7),
            Constraint.tb.of(canvasContainer, offset: 15),
            Constraint.bb.of(self, offset: -15))
        
//        self.imageView.constrainUsing(constraints: [
//            Constraint.ll : (of: self, offset: 10),
//            Constraint.rcx : (of: self, offset: -7),
//            Constraint.tb : (of: self.canvasContainer, offset: 15),
//            Constraint.bt : (of: self.buttonContainer, offset: -15)])
        
        outputContainer.addConstraints(
            Constraint.lcx.of(self, offset: 7),
            Constraint.rr.of(self, offset: -10),
            Constraint.tb.of(canvasContainer, offset: 15),
            Constraint.bb.of(self, offset: -15))
        
//        self.outputContainer.constrainUsing(constraints: [
//            Constraint.lcx : (of: self, offset: 7),
//            Constraint.rr : (of: self, offset: -10),
//            Constraint.tb : (of: self.canvasContainer, offset: 15),
//            Constraint.bt : (of: self.buttonContainer, offset: -15)])
        
        self.outputLabel.centerInSuperview()
        
        confidenceLabel.addConstraints(
            Constraint.rr.of(outputContainer),
            Constraint.bb.of(outputContainer))
        
//        self.confidenceLabel.constrainUsing(constraints: [
//            Constraint.rr : (of: self.outputContainer, offset: 0),
//            Constraint.bb : (of: self.outputContainer, offset: 0)])

        super.updateConstraints()
    }
    
    // Note: Shadow paths defined here where views have frames
    override func layoutSubviews() {
        super.layoutSubviews()
        self.canvasContainer.layer.shadowPath = UIBezierPath(roundedRect: self.canvasContainer.bounds, cornerRadius: self.canvasContainer.layer.cornerRadius).cgPath
        self.outputContainer.layer.shadowPath = UIBezierPath(roundedRect: self.outputContainer.bounds, cornerRadius: self.outputContainer.layer.cornerRadius).cgPath
        self.imageView.layer.shadowPath = UIBezierPath(roundedRect: self.imageView.bounds, cornerRadius: self.imageView.layer.cornerRadius).cgPath
    }
}
