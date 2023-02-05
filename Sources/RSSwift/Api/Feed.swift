class Feed {

  let client: RssClient

  public let id: String
  public let name: String

  init(id: String, name: String, client: RssClient) {
    self.client = client
    self.id = id
    self.name = name
  }

  func getArticles() async -> [Article] {
    let articleModels = await client.getArticlesForFeed(feedId: id)
    return articleModels.map({ Article(model: $0) })
  }

}
