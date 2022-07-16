//  Copyright (c) 2022 650 Industries, Inc. All rights reserved.

#import <XCTest/XCTest.h>

@interface EXUpdatesLoggerOCTests : XCTestCase

@end

// Headers for the Swift classes and enum
// In application code, EXUpdates-Swift.h can be imported instead

typedef enum {
  EXUpdatesErrorCodeNone = 0,
  EXUpdatesErrorCodeNoUpdatesAvailable = 1,
  EXUpdatesErrorCodeUpdateAssetsNotAvailable = 2,
  EXUpdatesErrorCodeUpdateServerUnreachable = 3,
  EXUpdatesErrorCodeUpdateHasIncorrectHash = 4,
  EXUpdatesErrorCodeUpdateFailedToLoad = 5,
  EXUpdatesErrorCodeAssetsFailedToLoad = 6,
  EXUpdatesErrorCodeJSRuntimeError = 7,
} EXUpdatesErrorCode;

API_AVAILABLE(ios(15.0))
@interface EXUpdatesLogReader : NSObject

- (NSArray * _Nonnull)getLogEntries;
- (NSArray * _Nonnull)getLogEntriesNewerThan:(NSDate * _Nonnull)epoch;

@end


API_AVAILABLE(ios(15.0))
@interface EXUpdatesLogger : NSObject

- (void)trace:(NSString * _Nonnull)message code:(EXUpdatesErrorCode)code updateId:(NSString * _Nullable)updateId assetId:(NSString * _Nullable)assetId;
- (void)trace:(NSString * _Nonnull)message code:(EXUpdatesErrorCode)code;
- (void)debug:(NSString * _Nonnull)message code:(EXUpdatesErrorCode)code updateId:(NSString * _Nullable)updateId assetId:(NSString * _Nullable)assetId;
- (void)debug:(NSString * _Nonnull)message code:(EXUpdatesErrorCode)code;
- (void)info:(NSString * _Nonnull)message code:(EXUpdatesErrorCode)code updateId:(NSString * _Nullable)updateId assetId:(NSString * _Nullable)assetId;
- (void)info:(NSString * _Nonnull)message code:(EXUpdatesErrorCode)code;
- (void)warn:(NSString * _Nonnull)message code:(EXUpdatesErrorCode)code updateId:(NSString * _Nullable)updateId assetId:(NSString * _Nullable)assetId;
- (void)warn:(NSString * _Nonnull)message code:(EXUpdatesErrorCode)code;
- (void)error:(NSString * _Nonnull)message code:(EXUpdatesErrorCode)code updateId:(NSString * _Nullable)updateId assetId:(NSString * _Nullable)assetId;
- (void)error:(NSString * _Nonnull)message code:(EXUpdatesErrorCode)code;
- (void)fatal:(NSString * _Nonnull)message code:(EXUpdatesErrorCode)code updateId:(NSString * _Nullable)updateId assetId:(NSString * _Nullable)assetId;
- (void)fatal:(NSString * _Nonnull)message code:(EXUpdatesErrorCode)code;

@end

API_AVAILABLE(ios(15.0))
@implementation EXUpdatesLoggerOCTests

- (void)test_UpdatesLoggerOCMethods {
  EXUpdatesLogger *logger = [EXUpdatesLogger new];
  EXUpdatesLogReader *logReader = [EXUpdatesLogReader new];
  
  NSDate *epoch = [NSDate date];
  
  [logger warn:@"Test warning from ObjC code" code:EXUpdatesErrorCodeJSRuntimeError];
  
  NSArray<NSString *> * logEntries = [logReader getLogEntriesNewerThan:epoch];
  
  XCTAssertTrue([logEntries count] > 0);
  
  NSString *logEntryText = [logEntries lastObject];
  
  NSData *logEntryData = [logEntryText dataUsingEncoding:NSUTF8StringEncoding];
  
  NSDictionary *logEntry = [NSJSONSerialization JSONObjectWithData:logEntryData options:0 error:nil];

  XCTAssertEqual([[logEntry objectForKey:@"timestamp"] unsignedIntValue], floor([epoch timeIntervalSince1970]));
  XCTAssertEqualObjects([logEntry objectForKey:@"message"], @"Test warning from ObjC code");
  
}

@end
