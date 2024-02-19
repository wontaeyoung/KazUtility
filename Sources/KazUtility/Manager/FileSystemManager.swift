import Foundation

enum PhotoFileRouter {
  
  enum FileExtension: String {
    
    case jpg
    case png
    
    var name: String {
      return ".\(self.rawValue)"
    }
  }
  
  enum CompressionLevel {
    
    case high
    case middle
    case low
    case raw
    
    var percent: CGFloat {
      switch self {
        case .high:
          return 0.25
        case .middle:
          return 0.5
        case .low:
          return 0.75
        case .raw:
          return 1
      }
    }
  }
  
  case write(fileName: String, fileExtension: FileExtension, level: CompressionLevel)
  case read(fileName: String, fileExtension: FileExtension)
  
  var baseDirectory: URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  }
  
  var path: String {
    return "Photo"
  }
  
  var directoryURL: URL {
    return baseDirectory.appendingPathComponent(path)
  }
  
  var fileURL: URL {
    switch self {
      case .write(let fileName, let fileExtension, _):
        return directoryURL.appendingPathComponent(fileName + fileExtension.name)
        
      case .read(let fileName, let fileExtension):
        return directoryURL.appendingPathComponent(fileName + fileExtension.name)
    }
  }
  
  var directoryPath: String {
    return directoryURL.path
  }
  
  var filePath: String {
    return fileURL.path
  }
  
  var directoryExist: Bool {
    return FileManager.default.fileExists(atPath: directoryPath)
  }
  
  var fileExist: Bool {
    return FileManager.default.fileExists(atPath: filePath)
  }
  
  var compressionPercent: CGFloat {
    switch self {
      case .write(_, _, let level):
        return level.percent
      case .read:
        return CompressionLevel.raw.percent
    }
  }
}
