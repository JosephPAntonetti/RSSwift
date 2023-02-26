import Foundation

public class Request<T> where T: Decodable {

  public static func get(
    baseURL: String,
    route: String,
    headers: [String: String],
    queryItems: [URLQueryItem] = []
  ) async
    -> T?
  {
    return await Request.execute(
      baseURL: baseURL,
      route: route,
      queryItems: queryItems,
      headers: headers,
      body: nil
    )
  }

  public static func post(
    baseURL: String,
    route: String,
    headers: [String: String],
    queryItems: [URLQueryItem] = [],
    body: [String: Any]? = nil
  ) async {
    let url = buildURL(baseURL: baseURL, route: route, queryItems: queryItems)
    let request = buildRequest(url: url, method: "POST", headers: headers, body: body)
    _ = await sendRequest(request: request)
  }

  private static func execute(
    baseURL: String,
    route: String,
    queryItems: [URLQueryItem] = [],
    headers: [String: String]? = nil,
    body: [String: Any]? = nil
  ) async -> T? {
    let url = buildURL(baseURL: baseURL, route: route, queryItems: queryItems)
    let request = buildRequest(url: url, headers: headers, body: body)
    let result = await sendRequest(request: request)
    switch result {
    case .success(let value):
      return value
    case .failure:
      return .none
    }
  }

  private static func buildURL(
    baseURL: String,
    route: String,
    queryItems: [URLQueryItem] = []
  ) -> URL {
    var url = URL(string: "\(baseURL)/\(route)")!
    url.append(queryItems: queryItems)
    return url
  }

  private static func buildRequest(
    url: URL,
    method: String? = nil,
    headers: [String: String]? = nil,
    body: [String: Any]? = nil
  ) -> URLRequest {
    var request = URLRequest(url: url)
    if let headers = headers {
      for kvp in headers {
        request.addValue(
          kvp.value,
          forHTTPHeaderField: kvp.key
        )
      }
    }
    if let body = body {
      request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
      request.httpMethod = "POST"
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      request.addValue("application/json", forHTTPHeaderField: "Accept")
    }

    if let method = method {
      request.httpMethod = method
    }

    return request
  }

  private static func sendRequest(
    request: URLRequest
  ) async
    -> Result<T, HttpError>
  {
    do {
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
    }
    catch {
      return .failure(.unknown)
    }
  }
}
