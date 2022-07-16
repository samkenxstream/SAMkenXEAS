// Copyright 2022-present 650 Industries. All rights reserved.

// Reads expo-updates logs from the last hour

import Foundation
import OSLog

import ExpoModulesCore

@available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
@objc(EXUpdatesLogReader)
public class UpdatesLogReader: NSObject {

  /**
   Get expo-updates logs newer than the given date
   Returns an Objective-C NSArray of strings
   The strings are all in the JSON format of UpdatesLogEntry
   */
  @objc(getLogEntriesNewerThan:)
  public func getLogEntries(newerThan: Date) -> NSArray {
    let result = NSMutableArray()
    do {
      let logStore = try OSLogStore(scope: .currentProcessIdentifier)
      // Get all the logs since the given date.
      let position = logStore.position(date: newerThan)

      // Fetch log objects.
      let allEntries = try logStore.getEntries(at: position)

      // Filter the log to select our subsystem and the expo-updates category
      // and extract just the log message strings
      let allEntriesMessages = allEntries
          .compactMap { $0 as? OSLogEntryLog }
          .filter { $0.subsystem == "dev.expo.modules" }
          .filter { $0.category == "expo-updates" }
          .compactMap { $0.composedMessage }
      for entry in allEntriesMessages.enumerated() {
        result.add(entry.element as String)
      }
    } catch {
      result.add("Error occurred in UpdatesLogReader: \(error.localizedDescription)")
    }
    return result
  }
  
  /**
   Convenience method for returning expo-updates logs from last hour
   */
  @objc public func logEntriesInLastHour() -> NSArray {
    return getLogEntries(newerThan: Date().addingTimeInterval(-3600))
  }

  /**
   Convenience method for returning expo-updates logs from last day
   */
  @objc public func logEntriesInLastDay() -> NSArray {
    return getLogEntries(newerThan: Date().addingTimeInterval(-86400))
  }
}
