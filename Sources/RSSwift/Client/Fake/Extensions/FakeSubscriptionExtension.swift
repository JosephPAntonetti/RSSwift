extension Subscription {

  public static func fake() -> Subscription {
    return Subscription(client: FakeRssClient(), subscriptionModel: SubscriptionModel.fake())
  }
}
