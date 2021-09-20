//
//  HomeViewController.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 15/06/21.
//

import UIKit
import Resolver

class HomeViewController: UIViewController {
    
    //MARK: -Outlets
    
    
    @IBOutlet weak var table: UITableView!
    //MARK: - Class proprietes
    var viewModel:HomeViewModel = Resolver.resolve()
    
    
    
    
    //MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        self.table.registerCell(HomeTableViewCell.className)
        //quando eu declaro algo como meu delagate, eu aviso que vou fazer algo quando o metodo disparar na view Model
        self.viewModel.delagate = self
        self.viewModel.fechData()
        
        
    }
    
    
    
    
    
    
}
//MARK: - Extensions


extension HomeViewController : HomeViewModelDelegate{
    func successReponse() {
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    func errorResponse() {
        print("falha na tentativa de requisição")
    }
    
    
    
}

extension HomeViewController : HomeTableViewDelegate{
    func didClickedRepo(repoName: String, username: String) {
        
        let pullVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PullViewController") as! PullViewController
        pullVC.repoName=repoName
        pullVC.userName=username
    
        self.navigationController?.pushViewController(pullVC, animated: true)
        
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRepositorios ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: HomeTableViewCell.self, for: indexPath)
        cell.passData(viewModel.repoList[indexPath.row])
        cell.delegate =  self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //aumenta o tamanho das cell
        return UITableView.automaticDimension
    }
    
}
