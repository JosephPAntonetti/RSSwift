import Foundation
import InoreaderSwift

extension FolderModel {

  init(tagOrFolder: TagOrFolder) {
    self.init(id: tagOrFolder.id, name: tagOrFolder.id, subscriptionIds: [])
  }
}
