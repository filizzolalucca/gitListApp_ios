//
//  HomeViewController.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 15/06/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: -Outlets
    
    
    @IBOutlet weak var table: UITableView!
    //MARK: - Class proprietes
    private var viewModel:HomeViewModel?
    
    
    
    
    //MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let provider = HomeProvider()
        self.viewModel = HomeViewModel(provider: provider)
        self.table.delegate = self
        self.table.dataSource = self
        self.table.registerCell(HomeTableViewCell.className)
        //quando eu declaro algo como meu delgate, eu aviso que vou fazer algo quando o metodo disparar na view Model
        self.viewModel?.delagate = self
        self.viewModel?.fechData()
        
        
    }
    
    
    
    
    
    
}
//MARK: - Extensions


extension HomeViewController : HomeViewModelDelegate{
    func successReponse() {
        DispatchQueue.main.async {
            self.table.reloadData()
            //          DispatchQueue.main.asyncAfter(deadline: .now() + DELAY_LOADING) {
            //            //self.showLoading(false)
            //          }
        }
    }
    
    func errorResponse() {
        print("deu ruim marreco")
    }
    
    
    
}

extension HomeViewController : HomeTableViewDelegate{
    func didClickedRepo(repoName: String, username: String) {
        
        //voces fazem algo mais compicado, mas como eu tenho que passar parametro imagino que essa forma nao sirva de muita coisa
        let pullVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PullViewController") as! PullViewController
        pullVC.repoName=repoName
        pullVC.userName=username
    
        
        self.present(pullVC, animated: true, completion: nil)
        
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRepositorios ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: HomeTableViewCell.self, for: indexPath)
        cell.passData(viewModel?.repoList[indexPath.row])
        cell.delegate =  self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //aumenta o tamanho das cell
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("batata")
        }
    
    
}
