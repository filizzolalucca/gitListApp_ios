//
//  PullTableViewCell.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 18/06/21.
//

import UIKit

class PullTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var descricao_pr: UILabel!
    
    @IBOutlet weak var user_image: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //TODO: Evento de clique
    }
    
    func passData(_ data:PullModel?){
        self.title.text = data?.title
        self.descricao_pr.text = data?.body
        self.userName.text = data?.user?.username
        self.user_image.cacheImageSDWebImage(from: data?.user?.imageurl, contentMode: .scaleAspectFill, completion: nil)
    }

   
    
}
