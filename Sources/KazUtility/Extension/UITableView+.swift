import UIKit

extension UITableView {
  func reloadRow(row: Int, section: Int = 0) {
    self.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
  }
}
