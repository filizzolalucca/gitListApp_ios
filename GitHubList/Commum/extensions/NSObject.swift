//
//  NSObject.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 17/06/21.
//
import Foundation

//Qual a ideia por tras desse NSObject ?
//
extension NSObject {
  static var className: String {
    return String(describing: self)
  }
  
  func propertyNames() -> [String] {
    let mirror = Mirror(reflecting: self)
    return mirror.children.compactMap { $0.label }
  }
  
  func propertyValues() -> [String] {
    let mirror = Mirror(reflecting: self)
    let array = mirror.children.compactMap { $0.value }
    if let arrayString = array as? [String] {
      return arrayString
    } else {
      return []
    }
  }
  
}
