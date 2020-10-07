//
//  Error.swift
//  ChuckNorrisFacts
//
//  Created by Lucas César  Nogueira Fonseca on 24/10/19.
//  Copyright © 2019 Lucas César  Nogueira Fonseca. All rights reserved.
//

import Foundation
enum CustomError: Error, Equatable {
    case generic
    case notConnectedToInternet
    case networkConnectionLost
    case timeOut
    case noData
    case returned(Error)
    case statusCode(String)

    init(error: Error) {
        switch URLError.Code(rawValue: (error as NSError).code) {
        case .notConnectedToInternet:
            self = .notConnectedToInternet
        case .networkConnectionLost:
            self = .networkConnectionLost
        case .timedOut:
            self = .timeOut
        default:
            self = .returned(error)
        }
    }
    
    public var title: String {
        switch self {
        case .generic,.returned(_), .statusCode(_):
            return "Something went wrong"
        case .notConnectedToInternet:
            return "No connection"
        case .networkConnectionLost:
            return "Network connection lost"
        case .timeOut:
            return "Timeout"
        case .noData:
            return "No data"
        }
    }

    static func == (lhs: CustomError, rhs: CustomError) -> Bool {
        return lhs.errorDescription == rhs.errorDescription
    }
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .generic:
            return "An unexpected error occurred, please try again later."
        case .notConnectedToInternet:
            return "There is no internet connection, check your network connection and try again."
        case .networkConnectionLost:
            return "The network connection was lost, check your network connection and try again."
        case .timeOut:
            return "Looks like the server is taking to long to respond, please try again later."
        case .noData:
            return "Not results found."
        case .statusCode(let error):
            return error
        case .returned(let error):
            return error.localizedDescription
        }
    }
}

struct APIError: LocalizedError, Codable, Hashable {
    var status: Int
    var errorDescription: String

    enum CodingKeys: String, CodingKey {
        case errorDescription = "message"
        case status
    }

    var error: Error {
         return NSError(domain: "", code: status, userInfo: [ NSLocalizedDescriptionKey: errorDescription]) as Error
    }
}
