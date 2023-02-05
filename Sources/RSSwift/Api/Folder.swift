class Folder: Feed {

  private let folderModel: FolderModel

  init(client: RssClient, folderModel: FolderModel) {
    self.folderModel = folderModel
    super.init(id: folderModel.id, name: folderModel.name, client: client)
  }

  func getSubscriptions() async -> [Subscription] {
    let subscriptionModels = await client.getSubscriptionsForFolder(folderId: folderModel.id)
    return subscriptionModels.map { Subscription(client: client, subscriptionModel: $0) }
  }
}
