public protocol AppError: Error {
  var logDescription: String { get }
  var alertDescription: String { get }
}
