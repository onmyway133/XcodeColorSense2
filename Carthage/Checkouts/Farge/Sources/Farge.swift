import Foundation

/// Returns name for hex color
///
/// - Parameter hex: Can include #, must contain 6 digits
/// - Returns: name
public func name(hex: String) -> String? {
  return Parser().parse(hex: hex)
}
