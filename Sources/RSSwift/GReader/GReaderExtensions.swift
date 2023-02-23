import Foundation

extension StreamItem {

  init(gStreamItem: GoogleReader.Models.StreamItem) {

    var published: Date? = nil
    if let publishedTimestamp = gStreamItem.published {
      published = Date(timeIntervalSince1970: Double(publishedTimestamp))
    }

    var updated: Date? = nil
    if let updatedTimestamp = gStreamItem.updated {
      updated = Date(timeIntervalSince1970: Double(updatedTimestamp))
    }

    var canonical: URL? = nil
    if let canonicalUrlString = gStreamItem.canonical?.first?.href {
      canonical = URL(string: canonicalUrlString)
    }

    let read = gStreamItem.categories?.contains(GoogleReader.Constants.ReadCategory) ?? false
    let starred = gStreamItem.categories?.contains(GoogleReader.Constants.StarredCategory) ?? false

    self.init(
      id: gStreamItem.id,
      title: gStreamItem.title,
      published: published,
      updated: updated,
      summary: gStreamItem.summary?.content,
      author: gStreamItem.author,
      canonical: canonical,
      read: read,
      starred: starred
    )
  }
}

extension Subscription {

  init(gReaderSubscription: GoogleReader.Models.Subscription) {

    let url = gReaderSubscription.url.flatMap({ URL(string: $0) })
    let iconUrl = gReaderSubscription.iconUrl.flatMap({ URL(string: $0) })
    let latestItemTimestamp = gReaderSubscription.firstitemmsec.flatMap({
      Date(timeIntervalSince1970: Double($0))
    }
    )
    let categories =
      gReaderSubscription.categories?.map({
        Category(id: $0.id, label: $0.label)
      }) ?? []

    self.init(
      id: gReaderSubscription.id,
      title: gReaderSubscription.title,
      sortID: gReaderSubscription.sortid,
      latestItemTimestamp: latestItemTimestamp,
      url: url,
      iconUrl: iconUrl,
      categories: categories
    )
  }
}
