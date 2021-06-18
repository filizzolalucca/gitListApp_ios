//
//  ServiceError.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 16/06/21.
//

import Foundation
public enum ServiceError: Error {
  static let parsing = NSError(domain: "parsingError", code: 0, userInfo: nil)
  static let failure = NSError(domain: "failureError", code: 10, userInfo: nil)
  static let wrongJson = NSError(domain: "wrongJsonError", code: 20, userInfo: nil)
  static let invalidToken = NSError(domain: "invalidToken", code: 30, userInfo: nil)
  static let noConnection = NSError(domain: "noConnection", code: 40, userInfo: nil)
  static let invalidData = NSError(domain: "invalidData", code: 50, userInfo: nil)
  static let emptyData = NSError(domain: "emptyData", code: 60, userInfo: nil)
  static let invalidUser = NSError(domain: "invalidUser", code: 70, userInfo: nil)
  static let timeout = NSError(domain: "timeout", code: 80, userInfo: nil)
}
