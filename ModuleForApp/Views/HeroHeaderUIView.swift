//
//  HeroHeaderUIView.swift
//  ModuleForApp
//
//  Created by 王杰 on 2022/8/24.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    
    private let modelButtonOne: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let modelButtonTwo: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.addTarget(self, action:  #selector(onTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func onTap() {
        print("onTap")
    }
    
    private let modelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(modelImageView)
        addGradient()
        addSubview(modelButtonTwo)
        addSubview(modelButtonOne)
        applyConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        modelImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}


//MARK: - 方法
extension HeroHeaderUIView {
    
    /// 渐变
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    /// headview - buttons 的 constraints
    private func applyConstraints() {
        
        let playButtonConstraints = [
            modelButtonTwo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (UIScreen.main.bounds.width - 240 - 40)/2),
            modelButtonTwo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            modelButtonTwo.widthAnchor.constraint(equalToConstant: 120)
        ]
        let downloadButtonConstraints = [
            modelButtonOne.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(UIScreen.main.bounds.width - 240 - 40)/2),
            modelButtonOne.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            modelButtonOne.widthAnchor.constraint(equalToConstant: 120)
        ]
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    /// headview的image（异步+缓存）
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        modelImageView.sd_setImage(with: url, completed: nil)
    }
}
