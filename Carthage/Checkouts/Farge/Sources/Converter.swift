import Foundation

struct Converter {

  func hsl(hex: String) -> HSL {
    return hsl(rgb: rgb(hex: hex))
  }

  func rgb(hex: String) -> RGB {
    let r = decimal(string: hex, from: 0, length: 2)
    let g = decimal(string: hex, from: 2, length: 2)
    let b = decimal(string: hex, from: 4, length: 2)

    return RGB(r: r, g: g, b: b)
  }

  func hsl(rgb: RGB) -> HSL {
    let r = rgb.r / 255
    let g = rgb.g / 255
    let b = rgb.b / 255
    let max = self.max(r, g, b)
    let min = self.min(r, g, b)
    var h: Float = 0
    var s: Float = 0
    let l: Float = (max + min) / 2

    if (max == min) {
      // achromatic
      h = 0
      s = 0
    } else {
      let d = max - min
      s = l > 0.5 ? d / (2 - max - min) : d / (max + min)
      switch max {
      case r:
        h = (g - b) / d + (g < b ? 6 : 0)
      case g:
        h = (b - r) / d + 2
      case b:
        h = (r - g) / d + 4
      default:
        break
      }

      h = h / 6
    }

    return HSL(h: floor(h * 360), s: floor(s * 100), l: floor(l * 100))
  }

  // MARK: - Helper

  func decimal(string: String, from: Int, length: Int) -> Float {
    let start = string.index(string.startIndex, offsetBy: from)
    let end = string.index(start, offsetBy: length)
    let range = Range(uncheckedBounds: (start, end))
    let substring = string.substring(with: range)
    let value = UInt8(substring, radix: 16) ?? 0
    return Float(value)
  }

  func max(_ a: Float, _ b: Float, _ c: Float) -> Float {
    return Swift.max(Swift.max(a, b), c)
  }

  func min(_ a: Float, _ b: Float, _ c: Float) -> Float {
    return Swift.min(Swift.min(a, b), c)
  }
}
