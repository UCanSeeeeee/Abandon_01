//
//  CollectionViewTableViewCell.swift
//  ModuleForApp
//
//  Created by 王杰 on 2022/8/24.
//

import UIKit


protocol SpecialTableViewCellDelegate: AnyObject {
//    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel)
    func specialTableViewCellDidTapCell(viewModel: TitlePreviewViewModel)
}

class SpecialTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionViewTableViewCell"
    weak var delegate: SpecialTableViewCellDelegate?
    private var titles: [Title] = [Title]()
    
    lazy var modelCollectionView: UICollectionView = {
        /// 将items组织成网格，并横向滚动
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        // 注册
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SpecialCollectionViewCell.self, forCellWithReuseIdentifier: SpecialCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(modelCollectionView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        modelCollectionView.frame = contentView.bounds
    }
}

//MARK: - 自定义方法
extension SpecialTableViewCell {
    
    /// 等待HomeViewController注册cell时传入titles，并重新加载所有数据
    public func configure(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
                self?.modelCollectionView.reloadData()
        }
    }
}
    
    /// 在UIMenu中点击后触发，download Action
//    public func downloadTitleAt(indexPath: IndexPath) {
//        DataPersistenceManager.shared.downloadTitleWith(model: titles[indexPath.row]) { result in
//            switch result {
//            case .success():
//                // 问题所在
//                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }


//MARK: - UICollectionViewDelegate + UICollectionViewDataSource
extension SpecialTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecialCollectionViewCell.identifier, for: indexPath)
        return cell
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//        // 传入海报数据，设置cell的image
//        guard let model = titles[indexPath.row].poster_path else {
//            return UICollectionViewCell()
//        }
//        cell.configure(with: model)
////        可在此进行Cell复用机制测试
////        print(indexPath.row)
////        print(cell.description)
//        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    // 点击跳转事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
//        let title = titles[indexPath.row]
//
//        guard let titleName = title.original_title ?? title.original_name else {
//            return
//        }
//        APICaller.shared.getMovie(with: titleName + " trailer") { [weak self] result in
//            switch result {
//            case .success(let videoElement):
//                let title = self?.titles[indexPath.row]
//                guard let titleOverview = title?.overview else {
//                    return
//                }
//                let viewModel = TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: titleOverview)
//                self?.delegate?.collectionViewTableViewCellDidTapCell(viewModel: viewModel)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    // 长按功能
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) { _ in
                let downloadAction = UIAction(title: "print",image: UIImage(systemName: "arrow.down.to.line"), state: .off) { _ in
//                    self?.downloadTitleAt(indexPath: indexPath)
                    print(1)
                }
                return UIMenu(title: "", options: .displayInline, children: [downloadAction])
            }
        return config
    }
}
