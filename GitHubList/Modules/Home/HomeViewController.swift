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
    
    
    //MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    //MARK: - Extensions
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
