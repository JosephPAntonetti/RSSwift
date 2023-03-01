public struct GReaderStreamItemIds: Codable {

  public let items: [String]?
  public let itemRefs: [ItemRef]?

  public struct ItemRef: Codable {
    let id: String
  }

  public let continuation : String?
}
