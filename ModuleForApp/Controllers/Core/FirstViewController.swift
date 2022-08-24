//
//  FirstViewController.swift
//  ModuleForApp
//
//  Created by 王杰 on 2022/8/24.
//

import Foundation
import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class FirstViewController: UIViewController  {
    /// 决定了 numberOfSections 和 titleForHeaderInSection
    let sectionTitles: [String] = ["Trending Movies", "Trending Tv", "Popular", "Upcoming Movies", "Top rated"]
    var headerView: HeroHeaderUIView?
    
    lazy var modelTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(SpecialTableViewCell.self, forCellReuseIdentifier: SpecialTableViewCell.identifier)
        tableview.dataSource = self
        tableview.delegate = self
        return tableview
    }()
    
    // 创建 UITableView
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "avc"
        navigationItem.title = "Home"
        view.backgroundColor = .systemBackground
        view.addSubview(modelTableView)
        configureNavbar()
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        modelTableView.tableHeaderView = headerView
        configureHeroHeaderView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        modelTableView.frame = view.bounds
    }
}
//MARK: - 自定义方法
extension FirstViewController {
    /// 添加ButtonItems
    public func configureNavbar() {
        var image = UIImage(named: "xxx")
        image = image?.withRenderingMode(.alwaysOriginal)
         // leftButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
         // rightButton
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    /// 调用api
    public func configureHeroHeaderView() {
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                let selectedTitle = titles.randomElement()
                let titleViewModel = TitleViewModel(titleName: selectedTitle?.original_title ?? "", posterURL: selectedTitle?.poster_path ?? "")
                self?.headerView?.configure(with: titleViewModel)
            case .failure(let erorr):
                print(erorr.localizedDescription)
            }
        }
    }
}

//MARK: - UITableViewDelegate + UITableViewDataSource
extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SpecialTableViewCell.identifier, for: indexPath) as? SpecialTableViewCell else {
            return UITableViewCell()
        }
        // 能够传递点击事件
//        cell.delegate = self
//
//        // 🌸未搞懂，等待解决
//        switch indexPath.section {
//        case Sections.TrendingMovies.rawValue:
//            APICaller.shared.getTrendingMovies { result in
//                switch result {
//                case .success(let titles):
//                    cell.configure(with: titles)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        case Sections.TrendingTv.rawValue:
//            APICaller.shared.getTrendingTvs { result in
//                switch result {
//                case .success(let titles):
//                    cell.configure(with: titles)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        case Sections.Popular.rawValue:
//            APICaller.shared.getPopular { result in
//                switch result {
//                case .success(let titles):
//                    cell.configure(with: titles)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        case Sections.Upcoming.rawValue:
//            APICaller.shared.getUpcomingMovies { result in
//                switch result {
//                case .success(let titles):
//                    cell.configure(with: titles)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//
//        case Sections.TopRated.rawValue:
//            APICaller.shared.getTopRated { result in
//                switch result {
//                case .success(let titles):
//                    cell.configure(with: titles)
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        default:
//            return UITableViewCell()
//        }
        
        return cell
    }
    
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // Section 的页眉高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        // capitalizeFirstLetter() 首字母大写
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
// 改变顶部透明度
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let defaultOffset = view.safeAreaInsets.top
//        let offset = scrollView.contentOffset.y + defaultOffset
//        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
//    }
}

extension FirstViewController: SpecialTableViewCellDelegate {

    /// 点击事件 didSelectItemAt
    func specialTableViewCellDidTapCell(viewModel: TitlePreviewViewModel) {
//        DispatchQueue.main.async { [weak self] in
//            let vc = TitlePreviewViewController()
//            vc.configure(with: viewModel)
//            self?.navigationController?.pushViewController(vc, animated: true)
//        }
    }
}
