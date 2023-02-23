import Foundation


public class Request<T> where T : Decodable {
    
    let baseURL : String
    let route : String
    let queryItems : [URLQueryItem]
    
    init(baseURL: String, route: String, queryItems: [URLQueryItem] = []) {
        self.baseURL = baseURL
        self.route = route
        self.queryItems = queryItems
    }
    
    public func get() async -> Optional<T> {
        var url = URL(string: "\(baseURL)/\(route)")
        url?.append(queryItems: self.queryItems)
        let result = await sendRequest(url: url!)
        switch (result) {
        case .success(let value):
            return value
        case .failure:
            return .none
        }
    }
    
    private func sendRequest(url: URL) async -> Result<T, HttpError> {
        do {
            let request = URLRequest(url: url)
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
