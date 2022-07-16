// Copyright 2022-present 650 Industries. All rights reserved.

// Error codes for expo-updates logs

import Foundation

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
  
  // Because this enum is exported to Objective-C,
  // the usual "\(UpdatesErrorCode.NoUpdatesAvailable)"
  // string representation will not work as expected,
  // so we add this representation here
  public var asString: String {
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
