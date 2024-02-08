//
//  CustomImageCell.swift
//  Gene
//
//  Created by manoj on 02/02/24.
//

import UIKit


class CustomImageCell : UITableViewCell {
    
    
    static let reuseIdentifier = "CustomImageCell"
    
    let customImageView : UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(customImageView)
        
        NSLayoutConstraint.activate([
        
            customImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            customImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            customImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            customImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
            
        
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:)has not been implemented")
    }
    
    func configure(with image : UIImage?) {
        
        customImageView.image = image
    }
}
