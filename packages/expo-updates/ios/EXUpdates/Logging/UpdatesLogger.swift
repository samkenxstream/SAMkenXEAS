// Copyright 2022-present 650 Industries. All rights reserved.

// Wrapper for expo-updates to have its own Logger instance and useful methods

import Foundation

import ExpoModulesCore

@objc(EXUpdatesLogger) public class UpdatesLogger: NSObject {
  private var logger: ExpoModulesCore.Logger;

  @objc override public init() {
    logger = Logger.newInstance(category: "expo-updates")
    super.init()
  }

  @objc(trace:code:) public func trace(message: String, code: Int = 0) {
    logger.trace(code, message);
  }

  @objc(debug:code:) public func debug(message: String, code: Int = 0) {
    logger.debug(code, message);
  }

  @objc(info:code:) public func info(message: String, code: Int = 0) {
    logger.info(code, message);
  }

  @objc(warn:code:) public func warn(message: String, code: Int = 0) {
    logger.warn(code, message);
  }

  @objc(error:code:) public func error(message: String, code: Int = 0) {
    logger.error(code, message);
  }

  @objc(fatal:code:) public func fatal(message: String, code: Int = 0) {
    logger.fatal(code, message);
  }

  @objc(timeStart:) public func timeStart(idString: String) {
    logger.timeStart(idString);
  }

  @objc(timeEnd:) public func timeEnd(idString: String) {
    logger.timeEnd(idString);
  }
}
