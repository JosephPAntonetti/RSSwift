import Foundation

struct GReaderRequestParameters {

  public struct GetStreamContentsParameters {
    public var count: Int = 20
    public var order: Order = .newest
    public var startTime: Int? = nil
    public var includeTarget: String? = nil
    public var excludeTarget: String? = nil
    public var continuation: String? = nil
    public var stream: String? = nil

    public enum Order {
      case newest
      case oldest
    }

    var queryItems: [URLQueryItem] {
      return [
        URLQueryItem(name: "n", value: String(count)),
        URLQueryItem(name: "r", value: order == .newest ? nil : "o"),
        URLQueryItem(name: "ot", value: startTime?.description),
        URLQueryItem(
          name: "xt",
          value: excludeTarget?.urlEncode()
        ),
        URLQueryItem(
          name: "it",
          value: includeTarget?.urlEncode()
        ),
        URLQueryItem(name: "continuation", value: continuation),
        URLQueryItem(name: "stream", value: stream?.urlEncode()),
      ]
    }

    public init(
      count: Int = 20,
      order: Order = .newest,
      startTime: Int? = nil,
      includeTarget: String? = nil,
      excludeTarget: String? = nil,
      continuation: String? = nil,
      stream: String? = nil
    ) {
      self.count = count
      self.order = order
      self.startTime = startTime
      self.includeTarget = includeTarget
      self.excludeTarget = excludeTarget
      self.continuation = continuation
      self.stream = stream
    }
  }
}
