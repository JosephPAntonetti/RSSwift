import Foundation
import LoremSwiftum

public struct Category {

  public let id: String
  public let label: String

  public init(id: String, label: String) {
    self.id = id
    self.label = label
  }

}

extension Category {

  public static func mock() -> Category {
    return Category(id: UUID().uuidString, label: Lorem.title)
  }
}
