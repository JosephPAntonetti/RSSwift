import Foundation
import LoremSwiftum

public struct Subscription {

  public let id: String
  public let title: String
  public let sortID: String
  public let latestItemTimestamp: Date?
  public let url: URL?
  public let iconUrl: URL?
  public let categories: [Category]

  public init(
    id: String,
    title: String,
    sortID: String,
    latestItemTimestamp: Date? = nil,
    url: URL? = nil,
    iconUrl: URL? = nil,
    categories: [Category] = []
  ) {
    self.id = id
    self.title = title
    self.sortID = sortID
    self.latestItemTimestamp = latestItemTimestamp
    self.url = url
    self.iconUrl = iconUrl
    self.categories = categories
  }
}

extension Subscription {

  public static func mock(categories: [Category] = []) -> Subscription {
    return Subscription(
      id: UUID().uuidString,
      title: Lorem.title,
      sortID: UUID().uuidString,
      categories: categories
    )
  }
}
