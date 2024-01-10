//
//  MainViewController.swift
//  Netflix Clone
//
//  Created by Abdulla Ahmad on 10/26/23.
//

import UIKit


enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTvs = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    private var randomTrendingMoview: Title?
    private var headerView: HeroHeadeUIView?
    
    let sectionTitles: [String] = ["Trending Movies", "Trending Tvs", "Popular", "Upcoming Movies", "Top Movies"]
    
    private let homeFeedTable: UITableView = {
        
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar()
        
        headerView = HeroHeadeUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTable.tableHeaderView = headerView
        configureHeroHeaderView()
        
    }
    
    private func configureHeroHeaderView() {
        APICaller.shared.getTreandingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                let selectedTitle = titles.randomElement()
                
                self?.randomTrendingMoview = selectedTitle
                self?.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.original_name ?? selectedTitle?.original_title ?? "", posterUrl: selectedTitle?.poster_path ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureNavBar(){
        var image = UIImage(named: "netflix")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else{
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            
            APICaller.shared.getTreandingMovies { result in
                switch result  {
                case .success(let movies):
                    cell.configure(with: movies)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TrendingTvs.rawValue:
            
            APICaller.shared.getTreandingTvs { result in
                switch result  {
                case .success(let tvs):
                    cell.configure(with: tvs)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.Popular.rawValue:
            
            APICaller.shared.getPopularMovies { result in
                switch result  {
                case .success(let movies):
                    cell.configure(with: movies)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
        case Sections.Upcoming.rawValue:
            
            APICaller.shared.getUpcomingMovies { result in
                switch result  {
                case .success(let movies):
                    cell.configure(with: movies)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
        case Sections.TopRated.rawValue:
            
            APICaller.shared.getTopRatedMovies { result in
                switch result  {
                case .success(let movies):
                    cell.configure(with: movies)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: Int(header.bounds.origin.x) + 20, y: Int(header.bounds.origin.y), width: 100, height: Int(header.bounds.height))
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func CollectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
