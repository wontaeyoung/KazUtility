import Foundation

public enum PhotoFileRouter {
  
  public enum FileExtension: String {
    
    case jpg
    case png
    
    public var name: String {
      return ".\(self.rawValue)"
    }
  }
  
  public enum CompressionLevel {
    
    case high
    case middle
    case low
    case raw
    
    public var percent: CGFloat {
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
  
  public var baseDirectory: URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  }
  
  public var path: String {
    return "Photo"
  }
  
  public var directoryURL: URL {
    return baseDirectory.appendingPathComponent(path)
  }
  
  public var fileURL: URL {
    switch self {
      case .write(let fileName, let fileExtension, _):
        return directoryURL.appendingPathComponent(fileName + fileExtension.name)
        
      case .read(let fileName, let fileExtension):
        return directoryURL.appendingPathComponent(fileName + fileExtension.name)
    }
  }
  
  public var directoryPath: String {
    return directoryURL.path
  }
  
  public var filePath: String {
    return fileURL.path
  }
  
  public var directoryExist: Bool {
    return FileManager.default.fileExists(atPath: directoryPath)
  }
  
  public var fileExist: Bool {
    return FileManager.default.fileExists(atPath: filePath)
  }
  
  public var compressionPercent: CGFloat {
    switch self {
      case .write(_, _, let level):
        return level.percent
      case .read:
        return CompressionLevel.raw.percent
    }
  }
}

public final class FileSystemManager {
  
  static let shared = FileSystemManager()
  private init() { }
  
  public func loadImage(router: PhotoFileRouter) -> Data? {
    guard router.fileExist else { return nil }
    
    return FileManager.default.contents(atPath: router.filePath)
  }
  
  public func writeImage(with data: Data, router: PhotoFileRouter) throws {
    /// 파일 경로에 디렉토리가 존재하지 않으면 생성
    if !router.directoryExist {
      try FileManager.default.createDirectory(at: router.directoryURL, withIntermediateDirectories: false)
    }
    
    try data.write(to: router.fileURL)
  }
}
