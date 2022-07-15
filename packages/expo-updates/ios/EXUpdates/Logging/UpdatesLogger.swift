// Copyright 2022-present 650 Industries. All rights reserved.

// Wrapper for expo-updates to have its own Logger instance and useful methods

import Foundation

import ExpoModulesCore

// MARK: - Error code enum

@objc(EXUpdatesErrorCode)
public enum UpdatesErrorCode: Int {
  case None = 0
  case NoUpdatesAvailable = 1
  case UpdateAssetsNotAvailable = 2
  case UpdateServerUnreachable = 3
  case UpdateHasIncorrectHash = 4
  case UpdateFailedToLoad = 5
  case AssetsFailedToLoad = 6
  case JSRuntimeError = 7

  var asString: String {
    switch self {
    case .None:
      return "None"
    case .NoUpdatesAvailable:
      return "NoUpdatesAvailable"
    case .UpdateAssetsNotAvailable:
      return "UpdateAssetsNotAvailable"
    case .UpdateServerUnreachable:
      return "UpdateServerUnreachable"
    case .UpdateHasIncorrectHash:
      return "UpdateHasIncorrectHash"
    case .UpdateFailedToLoad:
      return "UpdateFailedToLoad"
    case .AssetsFailedToLoad:
      return "AssetsFailedToLoad"
    case .JSRuntimeError:
      return "JSRuntimeError"
    }
  }
}

// MARK: - Schema for JSON in log messages

public struct UpdatesLogEntry: Codable {
  var timestamp: UInt // seconds since 1/1/1970 UTC
  var message: String
  var code: String // One of the UpdatesErrorCode string values above
  var level: String // One of the ExpoModulesCore.LogType string values
  var updateId: String // EAS update ID, if any
  var assetId: String // EAS asset ID, if any

  public func asString() -> String? {
    do {
      let jsonEncoder = JSONEncoder()
      let jsonData = try jsonEncoder.encode(self)
      return String(data: jsonData, encoding: .utf8) ?? nil
    } catch {
      return nil
    }
  }

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

// MARK: - UpdatesLogger class

@objc(EXUpdatesLogger)
public class UpdatesLogger: NSObject {
  private var logger: ExpoModulesCore.Logger

  @objc override public init() {
    logger = Logger(category: "expo-updates")
    super.init()
  }

  // MARK: - Public logging functions

  @objc(trace:code:updateId:assetId:)
  public func trace(
    message: String,
    code: UpdatesErrorCode = .None,
    updateId: String?,
    assetId: String?
  ) {
    log(message: message, code: code, level: .trace, updateId: updateId, assetId: assetId)
  }

  @objc(trace:code:)
  public func trace(
    message: String,
    code: UpdatesErrorCode = .None
  ) {
    trace(message: message, code: code, updateId: nil, assetId: nil)
  }

  @objc(debug:code:updateId:assetId:)
  public func debug(
    message: String,
    code: UpdatesErrorCode = .None,
    updateId: String?,
    assetId: String?
  ) {
    log(message: message, code: code, level: .debug, updateId: updateId, assetId: assetId)
  }

  @objc(debug:code:)
  public func debug(
    message: String,
    code: UpdatesErrorCode = .None
  ) {
    debug(message: message, code: code, updateId: nil, assetId: nil)
  }

  @objc(info:code:updateId:assetId:)
  public func info(
    message: String,
    code: UpdatesErrorCode = .None,
    updateId: String?,
    assetId: String?
  ) {
    log(message: message, code: code, level: .info, updateId: updateId, assetId: assetId)
  }

  @objc(info:code:)
  public func info(
    message: String,
    code: UpdatesErrorCode = .None
  ) {
    info(message: message, code: code, updateId: nil, assetId: nil)
  }

  @objc(warn:code:updateId:assetId:)
  public func warn(
    message: String,
    code: UpdatesErrorCode = .None,
    updateId: String?,
    assetId: String?
  ) {
    log(message: message, code: code, level: .warn, updateId: updateId, assetId: assetId)
  }

  @objc(warn:code:)
  public func warn(
    message: String,
    code: UpdatesErrorCode = .None
  ) {
    warn(message: message, code: code, updateId: nil, assetId: nil)
  }

  @objc(error:code:updateId:assetId:)
  public func error(
    message: String,
    code: UpdatesErrorCode = .None,
    updateId: String?,
    assetId: String?
  ) {
    log(message: message, code: code, level: .error, updateId: updateId, assetId: assetId)
  }

  @objc(error:code:)
  public func error(
    message: String,
    code: UpdatesErrorCode = .None
  ) {
    error(message: message, code: code, updateId: nil, assetId: nil)
  }

  @objc(fatal:code:updateId:assetId:)
  public func fatal(
    message: String,
    code: UpdatesErrorCode = .None,
    updateId: String?,
    assetId: String?
  ) {
    log(message: message, code: code, level: .fatal, updateId: updateId, assetId: assetId)
  }

  @objc(fatal:code:)
  public func fatal(
    message: String,
    code: UpdatesErrorCode = .None
  ) {
    fatal(message: message, code: code, updateId: nil, assetId: nil)
  }

  @objc(timeStart:)
  public func timeStart(idString: String) {
    logger.timeStart(idString)
  }

  @objc(timeEnd:)
  public func timeEnd(idString: String) {
    logger.timeEnd(idString)
  }

  // MARK: - Private logging implementation

  func log(
    message: String,
    code: UpdatesErrorCode = .None,
    level: ExpoModulesCore.LogType = .trace,
    updateId: String?,
    assetId: String?
  ) {
    let logEntry = UpdatesLogEntry(
      timestamp: UInt(Date().timeIntervalSince1970),
      message: message,
      code: code.asString,
      level: level.asString,
      updateId: updateId ?? "",
      assetId: assetId ?? ""
    )
    logger.log(type: level, logEntry.asString() ?? logEntry.message)
  }


}
