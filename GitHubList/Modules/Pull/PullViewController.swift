//
//  PullViewController.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 15/06/21.
//

import UIKit




class PullViewController: UIViewController {
    
    //MARK: - Outlets
    
    
    @IBOutlet weak var tablePull: UITableView!
    //MARK: - Class Proprietes
    

    private var viewModel:PullViewModel?
    var repoName:String?
    var userName:String?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let provider = PullProvider()
        self.viewModel = PullViewModel(provider: provider)
        self.tablePull.delegate = self
        self.tablePull.dataSource = self
        self.tablePull.registerCell(PullTableViewCell.className)
        self.viewModel?.delagate = self
        self.viewModel?.fechData(userName: userName ?? " ", repoName: repoName ?? " ")
        

        
    }
    
    
    
    
    

    
}

//MARK: - Extensios

extension PullViewController:PullViewModelDelegate{
    func successResponse() {
        DispatchQueue.main.async {
            self.tablePull.reloadData()
            //          DispatchQueue.main.asyncAfter(deadline: .now() + DELAY_LOADING) {
            //            //self.showLoading(false)
            //          }
        }
    }
    
    func errorResponse() {
        print("deu ruim marreco")
    }
}

extension PullViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfPRs ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: PullTableViewCell.self, for: indexPath)
        cell.passData(viewModel?.pullList[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //aumenta o tamanho das cell
        return UITableView.automaticDimension
    }
    
    
}
