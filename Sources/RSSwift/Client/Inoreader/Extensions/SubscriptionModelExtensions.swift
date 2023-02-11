import Foundation
import InoreaderSwift

extension SubscriptionModel {
    init(inoreaderSubscription: InoreaderSwift.Subscription) {
        self.init(id: inoreaderSubscription.id, name: inoreaderSubscription.title, url: URL(string: inoreaderSubscription.url))
    }
}
