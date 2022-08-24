//
//  SecondTableViewCell.swift
//  ModuleForApp
//
//  Created by 王杰 on 2022/8/24.
//

import UIKit

class SecondTableViewCell: UITableViewCell {


    static let identifier = "SecondTableViewCell"
    
    private let modelButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let modelLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let modelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        // 相辅相成
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(modelImageView)
        contentView.addSubview(modelLabel)
        contentView.addSubview(modelButton)
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}

//MARK: - 自定义方法
extension SecondTableViewCell {
    // 改
    private func applyConstraints() {
        let titlesPosterUIImageViewConstraints = [
            modelImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            modelImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            modelImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            modelImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLabelConstraints = [
            modelLabel.leadingAnchor.constraint(equalTo: modelImageView.trailingAnchor, constant: 20),
            modelLabel.trailingAnchor.constraint(equalTo: modelButton.leadingAnchor, constant: -10),
            modelLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        let playTitleButtonConstraints = [
            modelButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            modelButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            modelButton.widthAnchor.constraint(equalToConstant: 35)
        ]
        
        NSLayoutConstraint.activate(titlesPosterUIImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(playTitleButtonConstraints)
    }
    
    // 注册cell后传入数据
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        modelImageView.sd_setImage(with: url, completed: nil)
        modelLabel.text = model.titleName
    }
}
