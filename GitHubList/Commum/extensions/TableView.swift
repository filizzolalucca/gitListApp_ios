//
//  TableView.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 17/06/21.
//

import Foundation
import UIKit

extension UITableView {


  func registerCell(_ identifier: String) {
    self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
  }
  
  func dequeueReusableCell<T: UITableViewCell>(ofType type: T.Type, for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T else {
      fatalError("Couldn't find UITableViewCell of class \(type.className)")
    }
    return cell
  }
 
}



