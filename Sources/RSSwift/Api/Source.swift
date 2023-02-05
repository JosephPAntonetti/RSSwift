class Source {

  private let client: RssClient

  init(client: RssClient) {
    self.client = client
  }

  func getFolders() async -> [Folder] {
    let folderModels = await client.getFolders()
    return folderModels.map { Folder(client: client, folderModel: $0) }
  }

  func getSubscriptions() async -> [Subscription] {
    let subscriptionModels = await client.getSubscriptions()
    return subscriptionModels.map { Subscription(client: client, subscriptionModel: $0) }
  }
}