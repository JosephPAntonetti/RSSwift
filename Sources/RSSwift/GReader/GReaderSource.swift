import Foundation

public class GReaderSource: Source {

  private let baseURL: String

  private let httpClient: HttpClient

  public init(baseURL: String, authToken: String) {
    self.baseURL = baseURL
    self.httpClient = HttpClient(
      baseURL: baseURL,
      authorizationFunction: {
        url in
        var request = URLRequest(url: url)
        request.addValue("GoogleLogin auth=\(authToken)", forHTTPHeaderField: "Authorization")
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

    let parameters = GoogleReader.Models.Parameters.GetStreamContentsParameters(
      excludeTarget: GoogleReader.Constants.ReadCategory
    )

    let result = await httpClient.get(
      type: GoogleReader.Models.StreamContents.self,
      route:
        "\(GoogleReader.Constants.StreamContentsRoute)\(GoogleReader.Constants.ReadingListCategory.urlEncode())",
      queryItems: parameters.queryItems
    )

    switch result {
    case .some(let contents):
      let items = contents.items.map({ StreamItem(gStreamItem: $0) })
      let timestamp = Date(timeIntervalSince1970: Double(contents.updated))
      return (items, timestamp)
    case .none:
      return ([], nil)
    }
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
