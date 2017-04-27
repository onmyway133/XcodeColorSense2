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
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.

    completionHandler(nil)
  }

}
