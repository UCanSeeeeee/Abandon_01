//
//  CollectionViewCell.swift
//  ModuleForApp
//
//  Created by 王杰 on 2022/8/24.
//

import UIKit
import SDWebImage

class SpecialCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = "SpecialCollectionViewCell"
    
    private let modelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(modelImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        modelImageView.frame = contentView.bounds
    }
    
    
    public func configure(with model: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {
            return
        }
        modelImageView.sd_setImage(with: url, completed: nil)
    }
    
}
