import Foundation
import LoremSwiftum

public struct Article {

  public let id: String
  public let title: String
  public let published: Date?
  public let updated: Date?
  public let summary: String?
  public let author: String?
  public let canonical: URL?
  public let read: Bool
  public let starred: Bool
  public let subscriptionId: String?

  public init(
    id: String,
    title: String,
    published: Date? = nil,
    updated: Date? = nil,
    summary: String? = nil,
    author: String? = nil,
    canonical: URL? = nil,
    read: Bool = false,
    starred: Bool = false,
    subscriptionId: String? = nil
  ) {
    self.id = id
    self.title = title
    self.published = published
    self.updated = updated
    self.summary = summary
    self.author = author
    self.canonical = canonical
    self.read = read
    self.starred = starred
    self.subscriptionId = subscriptionId
  }

}

extension Article {

  public static func mock(subscriptionId: String? = nil) -> Article {
    return Article(
      id: UUID().uuidString,
      title: Lorem.title,
      published: Date(),
      updated: Date(),
      summary: Lorem.paragraphs(2),
      author: Lorem.fullName,
      canonical: URL(string: "google.com"),
      read: false,
      starred: false,
      subscriptionId: subscriptionId
    )
  }
}
