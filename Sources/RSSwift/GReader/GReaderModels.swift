public struct GReaderModels {

  typealias Parameters = GReaderRequestParameters

  public struct StreamItem: Codable {

    public let id: String
    public let categories: [String]?
    public let title: String
    public let published: Int?
    public let updated: Int?
    public let canonical: [Canonical]?
    public let summary: Summary?
    public let author: String?
    public let origin: Origin?

    public struct Canonical: Codable {
      public let href: String
    }

    public struct Summary: Codable {
      public let direction: String?
      public let content: String
    }

    public struct Origin: Codable {
      public let streamId: String
      public let title: String
      public let htmlUrl: String
    }
  }

  public struct StreamContents: Codable {

    public let direction: String?
    public let id: String
    public let title: String
    public let description: String
    public let updated: Int
    public let updatedUsec: Int?
    public let items: [StreamItem]
    public let continuation: String?

  }

  public struct Subscription: Codable {

    public let id: String
    public let title: String
    public let categories: [Category]?
    public let sortid: String
    public let firstitemmsec: Int?
    public let url: String?
    public let htmlUrl: String?
    public let iconUrl: String?

    public struct Category: Codable {
      public let id: String
      public let label: String
    }
  }

  public struct SubscriptionList: Codable {

    public let subscriptions: [Subscription]

  }

  struct StreamItemIds : Codable {

    let items : [String]?
    let itemRefs : [ItemRef]?

  }

  struct ItemRef : Codable {
    let id : String
  }
}
