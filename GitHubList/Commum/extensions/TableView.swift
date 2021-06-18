//
//  TableView.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 17/06/21.
//

import Foundation
import UIKit

extension UITableView {

//    Como voce fez para instanciar a cell na table view, porque tipo eu aprendi desse jeito
//    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath) as! VideoTableViewCell
//
//    //configurando a cell com o data
//
//
//
//    cell.setCell(self.videos[indexPath.row])
//
//
//
//    //retornando a cell
//    return cell
    
    
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

//extension UICollectionView {
//  func registerCellCollectionView(_ identifier: String) {
//    self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
//  }
//  
//  func dequeueReusableCell<T: UICollectionViewCell>(ofType type: T.Type, for indexPath: IndexPath) -> T {
//    guard let cell = dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as? T else {
//      fatalError("Couldn't find UITableViewCell of class \(type.className)")
//    }
//    return cell
//  }
//}

