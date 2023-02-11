import Foundation
import LoremSwiftum

extension SubscriptionModel {
  static func fake() -> SubscriptionModel {
    return SubscriptionModel(id: UUID().uuidString, name: Lorem.title, url: nil)
  }
}
