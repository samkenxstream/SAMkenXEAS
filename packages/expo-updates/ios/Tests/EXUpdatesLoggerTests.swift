//  Copyright (c) 2022 650 Industries, Inc. All rights reserved.

import XCTest

@testable import EXUpdates
@testable import ExpoModulesCore

@available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
class EXUpdatesLoggerTests : XCTestCase {

  let serialQueue = DispatchQueue(label: "EXUpdatesLoggerTests")

  func test_BasicLoggingWorks() {
    let sem = DispatchSemaphore(value: 1)

    serialQueue.async {
      let logger = UpdatesLogger()
      let logReader = UpdatesLogReader()

      // Mark the date
      let epoch = Date()

      // Write a log message
      logger.error(message: "Test message", code: .NoUpdatesAvailable)
      
      // Write another log message
      logger.warn(message: "Warning message", code: .AssetsFailedToLoad, updateId: "myUpdateId", assetId: "myAssetId")

      // Use reader to retrieve messages, get the last one written
      let logEntries: NSArray? = logReader.getLogEntries(newerThan: epoch)

      // Verify number of log entries and decoded values
      XCTAssertTrue(logEntries?.count ?? 0 == 2)
      let logEntryText: String = logEntries![0] as! String
      let logEntry = UpdatesLogEntry.create(from: logEntryText)
      XCTAssertTrue(logEntry?.timestamp == UInt(epoch.timeIntervalSince1970))
      XCTAssertTrue(logEntry?.message == "Test message")
      XCTAssertTrue(logEntry?.code == "NoUpdatesAvailable")
      XCTAssertTrue(logEntry?.level == "error")
      XCTAssertTrue(logEntry?.updateId == "")
      XCTAssertTrue(logEntry?.assetId == "")

      let logEntryText2: String = logEntries![1] as! String
      let logEntry2 = UpdatesLogEntry.create(from: logEntryText2)
      XCTAssertTrue(logEntry2?.timestamp == UInt(epoch.timeIntervalSince1970))
      XCTAssertTrue(logEntry2?.message == "Warning message")
      XCTAssertTrue(logEntry2?.code == "AssetsFailedToLoad")
      XCTAssertTrue(logEntry2?.level == "warn")
      XCTAssertTrue(logEntry2?.updateId == "myUpdateId")
      XCTAssertTrue(logEntry2?.assetId == "myAssetId")

      sem.signal()
    }
    sem.wait()


  }

  func test_OnlyExpoUpdatesLogsAppear() {
    let sem = DispatchSemaphore(value: 1)

    serialQueue.async {
      let logger = UpdatesLogger()
      let logReader = UpdatesLogReader()
      let otherLogger = Logger.init(category: "bogus")

      // Mark the date
      let epoch = Date()

      // Write an updates log
      logger.error(message: "Test message", code: .NoUpdatesAvailable)

      // Write a log message with a different category
      otherLogger.error("Bogus")

      // Get all entries newer than the date
      let logEntries: NSArray? = logReader.getLogEntries(newerThan: epoch)

      // Verify that only the expected message shows up in the reader
      XCTAssertTrue(logEntries?.count ?? 0 == 1)
      let logEntryText: String = logEntries![logEntries!.count - 1] as! String
      XCTAssertFalse(logEntryText.contains("Bogus"))
      XCTAssertTrue(logEntryText.contains("Test message"))

      sem.signal()
    }
    sem.wait()

  }
}
