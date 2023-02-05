import InoreaderSwift

class InoreaderClient: RssClient {
    private let api: InoreaderApi

    init(appId: String, appKey: String, accessToken: String) {
        api = InoreaderApi(authorizationProvider: AppAuthorizationProvider(appID: appId, appKey: appKey, token: accessToken))
    }

    func getFolders() async -> [FolderModel] {
        // TODO:
        return []
    }

    func getSubscriptions() async -> [SubscriptionModel] {
        // TODO:
        return []
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
