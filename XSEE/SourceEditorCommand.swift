//
//  SourceEditorCommand.swift
//  XSEE
//
//  Created by Khoa Pham on 27/04/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {

  func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
    guard let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange else {
      completionHandler(nil)
      return
    }

    let lineNumber = selection.start.line

    guard lineNumber < invocation.buffer.lines.count,
      let line = invocation.buffer.lines[lineNumber] as? String else {
      completionHandler(nil)
      return
    }

    guard let hex = findHex(string: line) else {
      completionHandler(nil)
      return
    }

    let newLine = process(line: line, hex: hex)

    invocation.buffer.lines.replaceObject(at: lineNumber, with: newLine)

    completionHandler(nil)
  }

  // MARK: - Helper

  func process(line: String, hex: String) -> String {
    guard let name = name(hex: hex) else {
      return line
    }

    let newLine = line.appending(" // color: \(name)")
    return newLine
  }

  func findHex(string: String) -> String? {
    let pattern = "\"#?[A-Fa-f0-9]{6}\""
    guard let range = Regex.check(string: string, pattern: pattern) else {
      return nil
    }

    return (string as NSString).substring(with: range)
  }
}
