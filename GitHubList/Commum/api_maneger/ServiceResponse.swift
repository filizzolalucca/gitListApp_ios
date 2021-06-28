//
//  SuccessResponswe.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 16/06/21.
//

import Foundation
public enum ServiceResponse<T> {
    case success(T)
    case failure(NSError)

    var error: NSError? {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }

    var content: T? {
        switch self {
        case .success(let content):
            return content
        default:
            return nil
        }
    }

    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
}
