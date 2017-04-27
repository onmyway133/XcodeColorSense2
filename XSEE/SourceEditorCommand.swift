//
//  SourceEditorCommand.swift
//  XSEE
//
//  Created by Khoa Pham on 27/04/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Foundation
import XcodeKit
import Farge

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

    let newLine = process(line: line)

    invocation.buffer.lines.replaceObject(at: lineNumber, with: newLine)

    completionHandler(nil)
  }

  // MARK: - Helper

  func process(line: String) -> String {
    return line
  }

}
