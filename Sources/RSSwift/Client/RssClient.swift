/*
    Underlying DataProvider for this library.

    This interface returns a set of cacheable models, which are used by the application.

    This interface should not be used directly unless implementing your own data source!
*/
protocol RssClient {

  func getFolders() async -> [FolderModel]
  func getSubscriptions() async -> [SubscriptionModel]
  func getArticlesForFeed(feedId: String) async -> [ArticleModel]
  func getSubscriptionsForFolder(folderId: String) async -> [SubscriptionModel]

}
