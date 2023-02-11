public enum SystemFolderType {
  case unread
  case starred
  case read
  case all

  func getName() -> String {
    switch self {
    case .unread:
      return "Unread"
    case .starred:
      return "Starred"
    case .read:
      return "Read"
    case .all:
      return "All"
    }
  }
}

public class SystemFolder: Feed {

  public let type: SystemFolderType

  init(type: SystemFolderType, client: RssClient) {
    self.type = type
    super.init(id: type.getName(), name: type.getName(), client: client)
  }

}
