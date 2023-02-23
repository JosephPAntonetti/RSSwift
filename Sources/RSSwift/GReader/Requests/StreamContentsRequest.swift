import Foundation

public class StreamContentsRequest: Request<GoogleReader.Models.StreamContents> {

  public struct Parameters {
    public var count: Int = 20
    public var order: Order = .newest
    public var startTime: Int? = nil
    public var includeTarget: String? = nil
    public var excludeTarget: String? = nil
    public var continuation: String? = nil

    public enum Order {
      case newest
      case oldest
    }

    public init(
      count: Int = 20,
      order: Order = .newest,
      startTime: Int? = nil,
      includeTarget: String? = nil,
      excludeTarget: String? = nil,
      continuation: String? = nil
    ) {
      self.count = count
      self.order = order
      self.startTime = startTime
      self.includeTarget = includeTarget
      self.excludeTarget = excludeTarget
      self.continuation = continuation
    }
  }

  public init(baseURL: String, id: String, parameters: Parameters = Parameters()) {
    let route =
      "stream/contents/\(id.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")"

    let queryItems = [
      URLQueryItem(name: "n", value: String(parameters.count)),
      URLQueryItem(name: "r", value: parameters.order == .newest ? nil : "o"),
      URLQueryItem(name: "ot", value: parameters.startTime?.description),
      URLQueryItem(name: "xt", value: parameters.excludeTarget),
      URLQueryItem(name: "it", value: parameters.includeTarget),
      URLQueryItem(name: "continuation", value: parameters.continuation),
    ]

    super.init(baseURL: baseURL, route: route, queryItems: queryItems)
  }
}
