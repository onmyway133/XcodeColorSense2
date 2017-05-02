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
    let line = line.replacingOccurrences(of: "\n", with: "")
    let hex = hex.replacingOccurrences(of: "\"", with: "")

    guard let name = name(hex: hex) else {
      return line
    }

    // Remove mark if needed
    if let removedMark = findMarkAndRemove(string: line){
      return removedMark
    }

    // Add mark
    let rgb = Converter().rgb(hex: hex)
    let literal = "#colorLiteral(red: \(rgb.r/255), green: \(rgb.g/255), blue: \(rgb.b/255), alpha: 1.0)"
    return line.appending(" // color: \(name)").appending(" \(literal)")
  }

  func findHex(string: String) -> String? {
    let pattern = "\"#?[A-Fa-f0-9]{6}\""
    guard let range = Regex.check(string: string, pattern: pattern) else {
      return nil
    }

    return (string as NSString).substring(with: range)
  }

  func findMarkAndRemove(string: String) -> String? {
    let pattern = " \\/\\/ color: .*"
    guard let range = Regex.check(string: string, pattern: pattern) else {
      return nil
    }

    return (string as NSString).substring(to: range.location)
  }
}
