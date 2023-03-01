import Foundation

public struct GReaderSubscriptionList: Codable {

  public let subscriptions: [Subscription]

  public struct Subscription: Codable {

    public let id: String
    public let title: String
    public let categories: [SubscriptionCategory]?
    public let sortid: String
    public let firstitemmsec: Int?
    public let url: String?
    public let htmlUrl: String?
    public let iconUrl: String?

    public struct SubscriptionCategory: Codable {
      public let id: String
      public let label: String
    }
  }

}

extension GReaderSubscriptionList.Subscription {

  public func toSubscription() -> Subscription {
    let url = url.flatMap({ URL(string: $0) })
    let iconUrl = iconUrl.flatMap({ URL(string: $0) })
    let latestItemTimestamp = firstitemmsec.flatMap({
      Date(timeIntervalSince1970: Double($0))
    }
    )

    let subscriptionCategories =
      categories?.map({
        Category(id: $0.id, label: $0.label)
      }) ?? []

    return Subscription(
      id: id,
      title: title,
      sortID: sortid,
      latestItemTimestamp: latestItemTimestamp,
      url: url,
      iconUrl: iconUrl,
      categories: subscriptionCategories
    )
  }
}
