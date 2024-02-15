//
//  underlinetext.swift
//  Gene
//
//  Created by manoj on 14/02/24.
//

import UIKit

class underlineText : UITextField {
    
    private var defaultLineHeight: CGFloat = 1.0
    private var underlineLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    private func commonInit() {
            // Add underline layer
            underlineLayer.backgroundColor = UIColor.black.cgColor
            layer.addSublayer(underlineLayer)
        }
    override func layoutSubviews() {
            super.layoutSubviews()
            // Layout underline layer
          //  let lineHeight: CGFloat = 1.0
            underlineLayer.frame = CGRect(x: 0, y: bounds.height - defaultLineHeight, width: bounds.width, height: defaultLineHeight)
        }

}
