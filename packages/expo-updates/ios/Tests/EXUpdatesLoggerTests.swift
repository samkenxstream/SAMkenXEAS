//  Copyright (c) 2022 650 Industries, Inc. All rights reserved.

import XCTest

@testable import EXUpdates
@testable import ExpoModulesCore

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

      // Use reader to retrieve messages, get the last one written
      let logEntries: NSArray? = logReader.getLogEntries(newerThan: epoch)

      // Verify number of log entries and decoded values
      XCTAssertTrue(logEntries?.count ?? 0 == 1)
      let logEntryText: String = logEntries![logEntries!.count - 1] as! String
      let logEntry = UpdatesLogEntry.create(from: logEntryText)
      XCTAssertTrue(logEntry?.message == "Test message")
      XCTAssertTrue(logEntry?.code == UpdatesErrorCode.NoUpdatesAvailable.asString)
      XCTAssertTrue(logEntry?.level == LogType.error.asString)
      XCTAssertTrue(logEntry?.updateId == "")
      XCTAssertTrue(logEntry?.assetId == "")

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
