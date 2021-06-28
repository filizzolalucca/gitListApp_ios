//
//  HomeTableViewCell.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 15/06/21.
//

import UIKit


protocol HomeTableViewDelegate:AnyObject {
    func didClickedRepo(repoName:String,username:String)
}
class HomeTableViewCell: UITableViewCell {
    
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descricao_repo: UILabel!
    @IBOutlet weak var num_forks: UILabel!
    @IBOutlet weak var num_stars: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var username: UILabel!
    
    weak var delegate:HomeTableViewDelegate?
    
    //MARK: - Propietes
    override var reuseIdentifier: String {
      return HomeTableViewCell.className
    }
    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didClickedRepo2))
        self.descricao_repo.addGestureRecognizer(tapGesture)
    }

    
    @objc
    private func didClickedRepo2(){
        self.delegate?.didClickedRepo(repoName: self.name.text!, username:self.username.text!)
    }
    
    func passData(_ data:Item?){
        self.name.text = data?.name
        self.descricao_repo.text = data?.description
        self.num_forks.text = String(data?.numForks ?? 0)
        self.num_stars.text = String(data?.starNumber ?? 0)
        self.username.text = data?.owner?.login ?? "-"
        self.imageUser.cacheImageSDWebImage(from: data?.owner?.imageURL, contentMode: .scaleAspectFill, completion: nil)
        
    }
    
}
