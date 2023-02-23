import Foundation

public enum HttpError: Error {
    case wrongRequest
    case parsingError
    case unauthorized
    case noResults
    case serverError(code: Int)
    case unknown
}
