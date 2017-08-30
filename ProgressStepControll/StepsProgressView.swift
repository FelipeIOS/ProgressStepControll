//
//  StepsProgressView.swift
//  PocProgressBarSteps
//
//  Created by Matheus Alves Mendonça on 30/08/17.
//  Copyright © 2017 Matheus Alves Mendonça. All rights reserved.
//

import UIKit

class StepsProgressView: UIProgressView {
    
    open var progressViewImageWidth: CGFloat = 20 {
        didSet {
            self.awakeFromNib()
        }
    }
    
    open var progressViewImageHeight: CGFloat = 20 {
        didSet {
            self.awakeFromNib()
        }
    }
    
    open var checkImage: UIImage = UIImage() {
        didSet {
            self.awakeFromNib()
        }
    }
    
    open var uncheckImage: UIImage = UIImage() {
        didSet {
            self.awakeFromNib()
        }
    }
    
    open var steps: [String] = [] {
        didSet {
            self.awakeFromNib()
        }
    }
    
    open var percentage: CGFloat = 0.0 {
        didSet {
            DispatchQueue.main.async {
                self.setProgress()
            }
        }
    }
    
    open var percentageFont: UIFont = UIFont(name: "Arial", size: 11)! {
        didSet {
            self.awakeFromNib()
        }
    }
    
    open var stepsFont: UIFont = UIFont(name: "Arial", size: 10)! {
        didSet {
            self.awakeFromNib()
        }
    }
    
    open var percentageViewWidth: CGFloat = 100.0 {
        didSet {
            self.awakeFromNib()
        }
    }
    
    open var percentageViewHeight: CGFloat = 30.0 {
        didSet {
            self.awakeFromNib()
        }
    }
    
    open var percentageViewBottomSpace: CGFloat = 50.0 {
        didSet {
            self.awakeFromNib()
        }
    }
    
    open var stepLabelFont: UIFont = UIFont(name: "Arial", size: 10)! {
        didSet {
            self.awakeFromNib()
        }
    }
    
    open var stepLabelFontColor: UIColor = .black {
        didSet {
            self.awakeFromNib()
        }
    }
    
    var stepsImageViews: [UIImageView] = []
    var stepsLabels: [UILabel] = []
    var percentageView: UIView = UIView()
    var percentageLabel: UILabel = UILabel()
    var triangleView: TriangleView = TriangleView()
    var untilWidthToCheck: CGFloat = 0
    var actualPercentage: CGFloat = 0
    var onePercentInPixels: CGFloat = 0
    
    override func awakeFromNib() {
        DispatchQueue.main.async {
            self.addSteps()
        }
    }
    
    private func setProgress() {
        self.setProgress(Float(self.percentage / CGFloat(100)), animated: true)
        self.reloadAnimated()
    }
    
    private func addSteps() {
        
        self.stepsImageViews.removeAll()
        self.stepsLabels.removeAll()
        
        self.removeViews()
        
        for text in self.steps {
            let label: UILabel = UILabel()
            label.text = text
            label.textColor = self.stepLabelFontColor
            label.font = self.stepLabelFont
            self.stepsLabels.append(label)
        }
        
        let barWidth = self.frame.size.width
        let space = Int(barWidth) / (steps.count - 1)
        self.onePercentInPixels = barWidth / 100
        self.actualPercentage = CGFloat(self.progress * 100)
        
        self.untilWidthToCheck = CGFloat(actualPercentage) * CGFloat(onePercentInPixels)
        
        var step = 1
        while step <= steps.count {
            let imageView: UIImageView = UIImageView()
            imageView.backgroundColor = UIColor.white
            
            if let last: UIImageView = self.stepsImageViews.last {
                imageView.frame = CGRect(x: last.layer.frame.origin.x + CGFloat(space), y: self.bounds.origin.y - (self.progressViewImageHeight/2), width: self.progressViewImageWidth, height: self.progressViewImageHeight)
            } else {
                imageView.frame = CGRect(x: self.bounds.origin.x - 10, y: self.bounds.origin.y - (self.progressViewImageHeight/2), width: self.progressViewImageWidth, height: self.progressViewImageHeight)
            }
            
            if imageView.frame.origin.x <= untilWidthToCheck {
                imageView.image = self.checkImage
                if actualPercentage == 0 {
                    imageView.image = self.uncheckImage
                }
            } else {
                imageView.image = self.uncheckImage
            }
            
            self.addSubview(imageView)
            stepsImageViews.append(imageView)
            
            let label: UILabel = self.stepsLabels[step - 1]
            label.textAlignment = .center
            label.frame = CGRect(x: imageView.frame.origin.x - 55, y: imageView.frame.origin.y + 20, width: 130, height: imageView.frame.size.height)
            
            self.addSubview(label)
            
            step += 1
        }
        
        self.percentageView.removeFromSuperview()
        self.percentageView.backgroundColor = .black
        self.percentageView.frame = CGRect(x: untilWidthToCheck - self.percentageViewWidth/2 - 20, y: self.bounds.origin.y - self.percentageViewBottomSpace, width: self.percentageViewWidth, height: self.percentageViewHeight)
        self.percentageView.layer.cornerRadius = 5.0
        
        self.triangleView.removeFromSuperview()
        self.triangleView.backgroundColor = .clear
        self.triangleView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        self.triangleView.frame = CGRect(x: untilWidthToCheck - 4, y: self.bounds.origin.y - 20, width: 8, height: 5)
        self.addSubview(self.triangleView)
        
        
        self.percentageLabel.removeFromSuperview()
        self.percentageLabel.textColor = .white
        self.percentageLabel.textAlignment = .center
        self.percentageLabel.font = self.percentageFont
        self.percentageLabel.text = "\(Int(self.progress * Float(100)))% Concluído"
        self.percentageLabel.frame = self.percentageView.bounds
        self.percentageView.addSubview(self.percentageLabel)
        
        self.addSubview(self.percentageView)
    }
    
    func reloadAnimated() {
        self.actualPercentage = CGFloat(self.progress * 100)
        self.untilWidthToCheck = CGFloat(actualPercentage) * CGFloat(onePercentInPixels)
        
        UIView.animate(withDuration: 0.25, animations: {
            for imageView in self.stepsImageViews {
                if imageView.frame.origin.x <= self.untilWidthToCheck {
                    imageView.image = self.checkImage
                    if self.actualPercentage == 0 {
                        imageView.image = self.uncheckImage
                    }
                } else {
                    imageView.image = self.uncheckImage
                }
            }
            self.percentageView.frame = CGRect(x: self.untilWidthToCheck - self.percentageViewWidth/2 - 20, y: self.bounds.origin.y - self.percentageViewBottomSpace, width: self.percentageViewWidth, height: self.percentageViewHeight)
            self.triangleView.frame = CGRect(x: self.untilWidthToCheck - 4, y: self.bounds.origin.y - 20, width: 8, height: 5)
            self.percentageLabel.text = "\(Int(self.progress * Float(100)))% Concluído"
        })
    }
    
    func removeViews() {
        for view in self.stepsLabels {
            view.removeFromSuperview()
        }
        
        for view in self.stepsImageViews {
            view.removeFromSuperview()
        }
    }
    
    
}

class TriangleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
        context.closePath()
        
        context.setFillColor(UIColor.black.cgColor)
        context.fillPath()
    }
}
