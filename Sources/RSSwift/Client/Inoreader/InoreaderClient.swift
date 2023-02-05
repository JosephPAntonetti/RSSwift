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

    func getArticlesForFeed(feedId _: String) async -> [ArticleModel] {
        // TODO:
        return []
    }

    func getSubscriptionsForFolder(folderId _: String) async -> [SubscriptionModel] {
        // TODO:
        return []
    }
}
