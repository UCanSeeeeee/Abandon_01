//
//  PartTwoViewController.swift
//  ModuleForApp
//
//  Created by 王杰 on 2022/8/24.
//

import UIKit
import WebKit

class PartTwoViewController: UIViewController {
    
    private let modelLabelOne: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Harry potter"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let modelLabelTwo: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
//        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.text = "This is the best movie ever to watch as a kid!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let modelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(modelLabelOne)
        view.addSubview(modelLabelTwo)
        view.addSubview(modelButton)
        configureConstraints()
    }
    
    func configureConstraints() {
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let titleLabelConstraints = [
            modelLabelOne.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            modelLabelOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ]
        
        let overviewLabelConstraints = [
            modelLabelTwo.topAnchor.constraint(equalTo: modelLabelOne.bottomAnchor, constant: 15),
            modelLabelTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            modelLabelTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let downloadButtonConstraints = [
            modelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modelButton.topAnchor.constraint(equalTo: modelLabelTwo.bottomAnchor, constant: 25),
            modelButton.widthAnchor.constraint(equalToConstant: 140),
            modelButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
        
    }
    
    /// 从点击事件中接收 TitlePreviewViewModel
    public func configure(with model: TitlePreviewViewModel) {
        modelLabelOne.text = model.title
        modelLabelTwo.text = model.titleOverview
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        webView.load(URLRequest(url: url))
    }

}
