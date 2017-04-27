//
//  Regex.swift
//  XcodeColorSense2
//
//  Created by Khoa Pham on 27/04/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Foundation

struct Regex {

  static func check(string: String, pattern: String) -> NSRange? {
    let regex = try? NSRegularExpression(pattern: pattern, options: [])
    return regex?.firstMatch(in: string, options: [], range: NSMakeRange(0, string.characters.count))?.range
  }
}
