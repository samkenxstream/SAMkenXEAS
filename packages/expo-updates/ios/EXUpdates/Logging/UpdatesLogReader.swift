// Copyright 2022-present 650 Industries. All rights reserved.

// Reads expo-updates logs from the last hour

import Foundation
import OSLog

import ExpoModulesCore

@objc(EXUpdatesLogReader)
public class UpdatesLogReader: NSObject {

  /**
   Get expo-updates logs for the last hour.
   Returns an Objective-C NSArray of NSStrings
   Apart from timer starts and stops, the strings are all in the JSON format of UpdatesLogEntry
   */
  @objc public func getLogEntries() -> NSArray {
    return getLogEntries(newerThan: Date().addingTimeInterval(-3600))
  }

  @objc public func getLogEntries(newerThan: Date) -> NSArray {
    let result = NSMutableArray()
    do {
      if #available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *) {
        let logStore = try OSLogStore(scope: .currentProcessIdentifier)
        // Get all the logs since the given date.
        let position = logStore.position(date: newerThan)

        // Fetch log objects.
        let allEntries = try logStore.getEntries(at: position)

        // Filter the log to select our subsystem and the expo-updates category
        let allEntriesMessages = allEntries
            .compactMap { $0 as? OSLogEntryLog }
            .filter { $0.subsystem == "dev.expo.modules" }
            .filter { $0.category == "expo-updates" }
            .compactMap { $0.composedMessage }
        for entry in allEntriesMessages.enumerated() {
          // Extract the log messages and remove the two initial characters
          // added by ExpoModulesCore.Logger handler
          // Accumulate the result as an NSString
          let rawMessage = entry.element as String
          let jsonStart = rawMessage.index(rawMessage.startIndex, offsetBy: 2)
          result.add(String(rawMessage.suffix(from: jsonStart)) as NSString)
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
