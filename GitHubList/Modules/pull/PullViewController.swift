//
//  PullViewController.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 15/06/21.
//

import UIKit
import Resolver



class PullViewController: UIViewController {
    
    //MARK: - Outlets
    
    
    @IBOutlet weak var tablePull: UITableView!
    //MARK: - Class Proprietes
    

    private var viewModel:PullViewModel = Resolver.resolve()
    var repoName:String?
    var userName:String?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tablePull.delegate = self
        self.tablePull.dataSource = self
        self.tablePull.registerCell(PullTableViewCell.className)
        self.viewModel.delagate = self
        self.viewModel.fechData(userName: userName ?? " ", repoName: repoName ?? " ")
        

        
    }
    
    
    
    
    

    
}

//MARK: - Extensios

extension PullViewController:PullViewModelDelegate{
    func successResponse() {
        DispatchQueue.main.async {
            self.tablePull.reloadData()
        }
    }
    
    func errorResponse() {
        print("falha na tentativa de requisição")
    }
}

extension PullViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPRs ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: PullTableViewCell.self, for: indexPath)
        cell.passData(viewModel.pullList[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //aumenta o tamanho das cell
        return UITableView.automaticDimension
    }
    
    
}
