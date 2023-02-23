import Foundation

public class GReaderSource: Source {

  private let baseURL: String

  private let httpClient: HttpClient

  public init(baseURL: String, additionalHeaders: [String: String]) {
    self.baseURL = baseURL
    self.httpClient = HttpClient(
      baseURL: baseURL,
      authorizationFunction: {
        url in
        var request = URLRequest(url: url)
        for kvp in additionalHeaders {
          request.addValue(kvp.value, forHTTPHeaderField: kvp.key)
        }
        return request
      }
    )
  }

  public func getItemIds(forStream: String) async -> [String] {
    let parameters = GoogleReader.Models.Parameters.GetStreamContentsParameters(
      stream: forStream
    )

    let result = await httpClient.get(
      type: GoogleReader.Models.StreamItemIds.self,
      route: GoogleReader.Constants.StreamIdsRoute,
      queryItems: parameters.queryItems
    )

    switch result {
    case .some(let contents):
      return contents.itemRefs?.map({ $0.id }) ?? []
    case .none:
      return []
    }
  }

  public func getUnreadItems(since: Date?) async -> ([StreamItem], Date?) {

    var startTime: Int? = nil
    if let since = since {
      startTime = Int(since.timeIntervalSince1970)
    }

    var items: [GoogleReader.Models.StreamItem] = []
    var latestTimestamp: Int = 0
    var continuationToken: String? = ""

    while continuationToken != nil {
      let parameters = GoogleReader.Models.Parameters.GetStreamContentsParameters(
        count: 100,
        startTime: startTime,
        excludeTarget: GoogleReader.Constants.ReadCategory,
        continuation: (continuationToken?.count ?? 0) > 0 ? continuationToken : nil
      )

      let result = await httpClient.get(
        type: GoogleReader.Models.StreamContents.self,
        route:
          "\(GoogleReader.Constants.StreamContentsRoute)\(GoogleReader.Constants.ReadingListCategory.urlEncode())",
        queryItems: parameters.queryItems
      )

      switch result {
      case .some(let contents):
        items.append(contentsOf: contents.items)
        latestTimestamp = max(latestTimestamp, contents.updated)
        continuationToken = contents.continuation
      case .none:
        continuationToken = nil
      }
    }

    return (
      items.map({ StreamItem(gStreamItem: $0) }),
      Date(timeIntervalSince1970: Double(latestTimestamp))
    )
  }

  public func getSubscriptions() async -> [Subscription] {
    let result = await httpClient.get(
      type: GoogleReader.Models.SubscriptionList.self,
      route: GoogleReader.Constants.SubscriptionListRoute
    )

    switch result {
    case .some(let subscriptionList):
      return subscriptionList.subscriptions.map({ Subscription(gReaderSubscription: $0) })
    case .none:
      return []
    }

  }
}
