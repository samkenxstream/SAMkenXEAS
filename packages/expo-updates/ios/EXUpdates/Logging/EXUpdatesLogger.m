// Copyright 2022-present 650 Industries. All rights reserved.

#import "EXUpdatesLogger.h"

// Copyright 2022-present 650 Industries. All rights reserved.

// TODO: until we can successfully import the Swift header from ExpoModulesCore, we put the Objective C interface for Logger.swift here

@interface EXLogger

// This class method is the only way to create an instance
+ (EXLogger * _Nonnull)newInstance:(NSString * _Nonnull)category;

- (void)timeStart:(NSString * _Nonnull)id;
- (void)timeEnd:(NSString * _Nonnull)id;

- (void)trace:(NSString * _Nonnull)message code:(NSInteger)code;
- (void)debug:(NSString * _Nonnull)message code:(NSInteger)code;
- (void)info:(NSString * _Nonnull)message code:(NSInteger)code;
- (void)warn:(NSString * _Nonnull)message code:(NSInteger)code;
- (void)error:(NSString * _Nonnull)message code:(NSInteger)code;
- (void)fatal:(NSString * _Nonnull)message code:(NSInteger)code;

@end

@interface EXUpdatesLogger()

@property (nonatomic, strong, nonnull) EXLogger *logger;

@end

@implementation EXUpdatesLogger

- (instancetype)init
{
  if (self == [super init]) {
    self.logger = [EXLogger newInstance:@"expo-updates"];
  }
  return self;
}

- (void)traceWithCode:(NSInteger)code message:(NSString * _Nonnull)message
{
  [self.logger trace:message code:code];
}

- (void)debugWithCode:(NSInteger)code message:(NSString * _Nonnull)message
{
  [self.logger debug:message code:code];
}

- (void)infoWithCode:(NSInteger)code message:(NSString * _Nonnull)message
{
  [self.logger info:message code:code];
}

- (void)warnWithCode:(NSInteger)code message:(NSString * _Nonnull)message
{
  [self.logger warn:message code:code];
}

- (void)errorWithCode:(NSInteger)code message:(NSString * _Nonnull)message
{
  [self.logger error:message code:code];
}

- (void)fatalWithCode:(NSInteger)code message:(NSString * _Nonnull)message
{
  [self.logger fatal:message code:code];
}

- (void)timeStart:(NSString *)idString
{
  [self.logger timeStart:idString];
}

- (void)timeEnd:(NSString *)idString
{
  [self.logger timeEnd:idString];
}

@end
