import Foundation

public struct GReaderStreamContents: Codable {

  public let direction: String?
  public let id: String
  public let title: String
  public let description: String
  public let updated: Int
  public let updatedUsec: String?
  public let items: [Item]
  public let continuation: String?

  public struct Item: Codable {

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
}

extension GReaderStreamContents.Item {

  public func toStreamItem() -> StreamItem {

    var publishedDate: Date? = nil
    if let publishedTimestamp = published {
      publishedDate = Date(timeIntervalSince1970: Double(publishedTimestamp))
    }

    var updatedDate: Date? = nil
    if let updatedTimestamp = updated {
      updatedDate = Date(timeIntervalSince1970: Double(updatedTimestamp))
    }

    var canonicalUrl: URL? = nil
    if let canonicalUrlString = canonical?.first?.href {
      canonicalUrl = URL(string: canonicalUrlString)
    }

    let read = categories?.contains(GReaderConstants.ReadCategory) ?? false
    let starred = categories?.contains(GReaderConstants.StarredCategory) ?? false

    return StreamItem(
      id: id,
      title: title,
      published: publishedDate,
      updated: updatedDate,
      summary: summary?.content,
      author: author,
      canonical: canonicalUrl,
      read: read,
      starred: starred,
      subscriptionId: origin?.streamId
    )
  }
}
