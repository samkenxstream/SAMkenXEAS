//
//  EXUpdatesLogEntry.h
//  ASN1Decoder
//
//  Created by Douglas Lowder on 7/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum
{
  EXUpdatesErrorCodeNone = 0,
  EXUpdatesErrorCodeNoUpdatesAvailable,
  EXUpdatesErrorCodeUpdateAssetsNotAvailable,
  EXUpdatesErrorCodeUpdateServerUnreachable,
  EXUpdatesErrorCodeUpdateHasIncorrectHash,
  EXUpdatesErrorCodeUpdateFailedToLoad,
  EXUpdatesErrorCodeAssetsFailedToLoad,
  EXUpdatesErrorCodeJSRuntimeError,
} EXUpdatesErrorCode;

typedef enum
{
  EXUpdatesLogLevelTrace = 0,
  EXUpdatesLogLevelDebug,
  EXUpdatesLogLevelInfo,
  EXUpdatesLogLevelWarn,
  EXUpdatesLogLevelError,
  EXUpdatesLogLevelFatal,
} EXUpdatesLogLevel;

@interface EXUpdatesLogEntry : NSObject <NSCoding>

@property (nonnull, nonatomic, strong) NSString *message;
@property (nonatomic, assign) EXUpdatesErrorCode code;
@property (nullable, nonatomic, copy) NSString *updateId;
@property (nullable, nonatomic, copy) NSString *assetId;

@end

NS_ASSUME_NONNULL_END
