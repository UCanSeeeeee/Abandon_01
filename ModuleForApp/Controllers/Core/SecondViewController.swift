//
//  SecondViewController.swift
//  ModuleForApp
//
//  Created by 王杰 on 2022/8/24.
//

import UIKit

class SecondViewController: UIViewController {
    
    private var titles: [Title] = [Title]()
    
    lazy var modelTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(SecondTableViewCell.self, forCellReuseIdentifier: SecondTableViewCell.identifier)
        tableview.delegate = self
        tableview.dataSource = self
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(modelTableView)
        fetchUpcoming()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        modelTableView.frame = view.bounds
    }
}


//MARK: - 自定义方法
extension SecondViewController {
    ///调用api
    private func fetchUpcoming() {
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                // 问题所在
                DispatchQueue.main.async {
                    self?.modelTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


//MARK: - UITableViewDelegate + UITableViewDataSource
extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondTableViewCell.identifier, for: indexPath) as? SecondTableViewCell else {
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        let titleViewModel = TitleViewModel(titleName: (title.original_title ?? title.original_name) ?? "Unknown title name", posterURL: title.poster_path ?? "")
        cell.configure(with: titleViewModel)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.section)
//        let title = titles[indexPath.row]
//        let titleName = title.original_title ?? ""
//        APICaller.shared.getMovie(with: titleName) { [weak self] result in
//            switch result {
//            case .success(let videoElement):
//                DispatchQueue.main.async {
//                    let vc = PartTwoViewController()
//                    let viewModel = TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? "")
//                    vc.configure(with: viewModel)
//                    self?.navigationController?.pushViewController(vc, animated: true)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
 
    

    
}
