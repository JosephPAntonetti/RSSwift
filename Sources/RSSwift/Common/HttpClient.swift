import Foundation


public class HttpClient {
    
    private let baseURL : String
    private let makeRequest : (URL) -> URLRequest
    
    init(baseURL: String, authorizationFunction: @escaping (URL) -> URLRequest) {
        self.baseURL = baseURL
        self.makeRequest = authorizationFunction
    }
    
    public func get<T : Decodable>(type: T.Type, route: String, queryItems: [URLQueryItem] = []) async -> Optional<T> {
        var url = URL(string: "\(baseURL)/\(route)")
        url?.append(queryItems: queryItems)
        let result = await sendRequest(url: url!, type: T.self)
        switch (result) {
        case .success(let value):
            return value
        case .failure:
            return .none
        }
    }
    
    private func sendRequest<T : Decodable>(url: URL, type: T.Type) async -> Result<T, HttpError> {
        do {
            let request = makeRequest(url)
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResults)
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                    return .failure(.parsingError)
                }
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.serverError(code: response.statusCode))
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
