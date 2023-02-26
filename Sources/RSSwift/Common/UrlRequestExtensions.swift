import Foundation

extension URLRequest {

  public init(
    url: URL,
    headers: [String: String],
    method: String? = nil,
    body: [String: Any?]? = nil
  ) {
    self.init(url: url)

    for kvp in headers {
      addValue(
        kvp.value,
        forHTTPHeaderField: kvp.key
      )
    }

    if let postBody = body {
      httpBody = try? JSONSerialization.data(withJSONObject: postBody, options: .prettyPrinted)
      httpMethod = "POST"
      addValue("application/json", forHTTPHeaderField: "Content-Type")
      addValue("application/json", forHTTPHeaderField: "Accept")
    }

    if let method = method {
      httpMethod = method
    }
  }

  public func post() async -> HttpError? {
    do {
      let (_, response) = try await URLSession.shared.data(for: self, delegate: nil)
      guard let response = response as? HTTPURLResponse else {
        return .noResults
      }
      switch response.statusCode {
      case 200...299:
        return .none
      case 401:
        return .unauthorized
      default:
        return .serverError(code: response.statusCode)
      }
    }
    catch {
      return .unknown
    }
  }

  public func get<T: Decodable>(resultType: T.Type) async -> Result<T, HttpError> {
    do {
      let (data, response) = try await URLSession.shared.data(for: self, delegate: nil)
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
