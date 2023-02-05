import Foundation

class Subscription: Feed {
  private let model: SubscriptionModel

  public var url: URL? {
    return model.url
  }

  init(client: RssClient, subscriptionModel: SubscriptionModel) {
    model = subscriptionModel
    super.init(id: subscriptionModel.id, name: subscriptionModel.name, client: client)
  }
}
