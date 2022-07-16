// Copyright 2022-present 650 Industries. All rights reserved.

// Class that implements logging for expo-updates in its own os.log category

import Foundation
import os.log

import ExpoModulesCore

@available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
@objc(EXUpdatesLogger)
public class UpdatesLogger: NSObject {
  
  private let osLogger: os.Logger

  public override init() {
    osLogger = os.Logger(subsystem: "dev.expo.modules", category: "expo-updates")
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
      level: "\(level)",
      updateId: updateId ?? "",
      assetId: assetId ?? ""
    )
    osLogger.log(level: level.toOSLogType(), "\(logEntry.asString() ?? logEntry.message)")
  }


}
