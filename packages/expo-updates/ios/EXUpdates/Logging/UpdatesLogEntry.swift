// Copyright 2022-present 650 Industries. All rights reserved.

// Schema for the fields in expo-updates log message JSON strings

import Foundation

public struct UpdatesLogEntry: Codable {
  var timestamp: UInt // seconds since 1/1/1970 UTC
  var message: String
  var code: String // One of the UpdatesErrorCode string values
  var level: String // One of the ExpoModulesCore.LogType string values
  var updateId: String // EAS update ID, if any
  var assetId: String // EAS asset ID, if any

  /**
   Returns a JSON string representation from this UpdatesLogEntry object
   */
  public func asString() -> String? {
    do {
      let jsonEncoder = JSONEncoder()
      let jsonData = try jsonEncoder.encode(self)
      return String(data: jsonData, encoding: .utf8) ?? nil
    } catch {
      return nil
    }
  }

  /**
   Returns a new UpdatesLogEntry from a JSON string, or nil if a decoding error occurs
   */
  public static func create(from: String) -> UpdatesLogEntry? {
    do {
      let jsonDecoder = JSONDecoder()
      guard let jsonData = from.data(using: .utf8) else { return nil }
      let logEntry: UpdatesLogEntry = try jsonDecoder.decode(UpdatesLogEntry.self, from: jsonData)
      return logEntry
    } catch {
      return nil
    }
  }
}

