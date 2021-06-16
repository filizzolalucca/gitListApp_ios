//
//  HomeTableViewCell.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 15/06/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descricao_repo: UILabel!
    @IBOutlet weak var num_forks: UILabel!
    @IBOutlet weak var num_stars: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var username: UILabel!
    
    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
