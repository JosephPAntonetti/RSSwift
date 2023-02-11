import InoreaderSwift

class InoreaderClient: RssClient {
  private let api: InoreaderApi

  init(appId: String, appKey: String, accessToken: String) {
    api = InoreaderApi(
      authorizationProvider: AppAuthorizationProvider(
        appID: appId,
        appKey: appKey,
        token: accessToken
      )
    )
  }

  func getFolders() async -> [FolderModel] {
    let result = await api.getFolders()
    switch result {
    case let .success(folders):
      return folders.map { FolderModel(tagOrFolder: $0) }
    case .failure:
      return []
    }
  }

  func getSubscriptions() async -> [SubscriptionModel] {
    let result = await api.getSubscriptions()
    switch result {
    case let .success(subscriptions):
      return subscriptions.map { SubscriptionModel(inoreaderSubscription: $0) }
    case .failure:
      return []
    }
  }

  func getArticlesForFeed(feedId: String) async -> [ArticleModel] {
    let result = await api.getStreamContents(streamID: feedId)
    switch result {
    case let .success(contents):
      return contents.items.map { ArticleModel(item: $0) }
    case .failure:
      return []
    }
  }

  func getSubscriptionsForFolder(folderId _: String) async -> [SubscriptionModel] {
    // TODO:
    return []
  }
}
