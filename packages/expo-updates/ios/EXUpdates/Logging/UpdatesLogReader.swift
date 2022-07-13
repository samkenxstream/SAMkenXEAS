// Copyright 2022-present 650 Industries. All rights reserved.

// Reads expo-updates logs from the last hour

import Foundation
import OSLog

import ExpoModulesCore

@objc(EXUpdatesLogReader) public class UpdatesLogReader: NSObject {
  @objc public func getLogEntries() -> NSArray {
    let result = NSMutableArray()
    do {
      if #available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *) {
        let logStore = try OSLogStore(scope: .currentProcessIdentifier)
        // Get all the logs from the last hour.
        let oneHourAgo = logStore.position(date: Date().addingTimeInterval(-3600))

        // Fetch log objects.
        let allEntries = try logStore.getEntries(at: oneHourAgo)

        // Filter the log to be relevant for our specific subsystem
        // and remove other elements (signposts, etc).
        let allEntriesMessages = allEntries
            .compactMap { $0 as? OSLogEntryLog }
            .filter { $0.subsystem == "dev.expo.modules" }
            .compactMap { $0.composedMessage as String }
        for entry in allEntriesMessages.enumerated() {
          result.add(entry)
        }
      } else {
        result.add("getLogEntries not available in this version of iOS")
      }
    } catch {
      result.add("Error occurred: \(error.localizedDescription)")
    }
    return result
  }
}
