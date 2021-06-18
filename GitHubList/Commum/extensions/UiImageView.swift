//
//  UiImageView.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 18/06/21.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView{
    func cacheImageSDWebImage(from link: String?, contentMode: UIView.ContentMode, renderingMode: Bool = false, placeholder: UIImage? = UIImage(named: "person"), completion: (() -> (Void))? ) {
      
      guard let link_ = link, let url = URL(string: link_) else { return }
      self.contentMode = .center
//      self.backgroundColor = .colorBlack_222222
      
      self.sd_setImage(with: url, placeholderImage: placeholder) { (image, _, _, _) in
        DispatchQueue.main.async {
          self.contentMode = contentMode
          
          guard let image = image else {
            self.image = placeholder ?? UIImage()
            return
          }
                
          if renderingMode {
            self.image = image.withRenderingMode(.alwaysTemplate)
          } else {
            self.image = image
          }
        }
    
        completion?()
      }
    }
    
}





