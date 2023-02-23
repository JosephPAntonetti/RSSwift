import Foundation

public protocol Source {

  func getUnreadItems(since: Date?) async -> ([StreamItem], Date?)

  func getItemIds(forStream: String) async -> [String]

  func getSubscriptions() async -> [Subscription]

}
