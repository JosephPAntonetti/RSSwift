import Foundation
import LoremSwiftum

extension FolderModel {
  static func fake() -> FolderModel {
    return FolderModel(
      id: UUID().uuidString,
      name: Lorem.title,
      subscriptionIds: (0...10).map { _ in UUID().uuidString }
    )
  }
}
