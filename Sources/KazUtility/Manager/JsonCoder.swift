import Foundation

public final class JsonCoder {
  
  public static let shared = JsonCoder()
  private init() { }
  
  private let encoder = JSONEncoder()
  private let decoder = JSONDecoder()
  
  public func encode<T: Encodable>(from value: T) throws -> Data {
    return try encoder.encode(value)
  }
  
  public func decode<T: Decodable>(to type: T.Type, from data: Data) throws -> T {
    return try decoder.decode(type, from: data)
  }
}

// MARK: - Custom Json Decoding Extension
public extension KeyedDecodingContainer {
  func decodeWithDefaultValue<T: DefaultValueProvidable>(
    _ type: T.Type,
    forKey key: KeyedDecodingContainer<K>.Key
  ) throws -> T {
    return try decodeIfPresent(type, forKey: key) ?? .defaultValue
  }
}
