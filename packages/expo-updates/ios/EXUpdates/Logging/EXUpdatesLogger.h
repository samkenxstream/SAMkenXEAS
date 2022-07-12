// Copyright 2022-present 650 Industries. All rights reserved.

#import <Foundation/Foundation.h>

#import "EXUpdatesLogEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface EXUpdatesLogger : NSObject

- (void)traceWithCode:(NSInteger)code message:(NSString * _Nonnull)message;
- (void)debugWithCode:(NSInteger)code message:(NSString * _Nonnull)message;
- (void)infoWithCode:(NSInteger)code message:(NSString * _Nonnull)message;
- (void)warnWithCode:(NSInteger)code message:(NSString * _Nonnull)message;
- (void)errorWithCode:(NSInteger)code message:(NSString * _Nonnull)message;
- (void)fatalWithCode:(NSInteger)code message:(NSString * _Nonnull)message;

- (void)time:(NSString * _Nonnull)idString :(void (^ _Nonnull)(void))closure;
- (void)timeStart:(NSString * _Nonnull)idString;
- (void)timeEnd:(NSString * _Nonnull)idString;

@end

NS_ASSUME_NONNULL_END
