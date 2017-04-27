import Foundation

struct Parser {

  func parse(hex: String) -> String? {
    let hex = hex.replacingOccurrences(of: "#", with: "")
    guard hex.characters.count == 6 else {
      return nil
    }

    var name = ""
    var minDiff: Float = Float.greatestFiniteMagnitude

    mapping.forEach({ key, value in
      let diff = self.diff(hex1: hex, hex2: key)

      if diff < minDiff {
        minDiff = diff
        name = value
      }
    })

    return name
  }

  // MARK: - Helper

  func diff(hex1: String, hex2: String) -> Float {
    let rgb1 = Converter().rgb(hex: hex1)
    let hsl1 = Converter().hsl(rgb: rgb1)

    let rgb2 = Converter().rgb(hex: hex2)
    let hsl2 = Converter().hsl(rgb: rgb2)

    let diffRGB = pow(rgb1.r - rgb2.r, 2) + pow(rgb1.g - rgb2.g, 2) + pow(rgb1.b - rgb2.b, 2)
    let diffHSL = pow(hsl1.h - hsl2.h, 2) + pow(hsl1.s - hsl2.s, 2) + pow(hsl1.l - hsl2.l, 2)
    return diffRGB + diffHSL * 2
  }
}
