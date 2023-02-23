import Foundation

public class SubscriptionListRequest: Request<GoogleReader.Models.SubscriptionList> {

  public init(baseURL: String) {
    super.init(baseURL: baseURL, route: "subscription/list")
  }

}
