// Copyright 2022-present 650 Industries. All rights reserved.

#import "EXUpdatesLogger.h"

// Copyright 2022-present 650 Industries. All rights reserved.

// TODO: until we can successfully import the Swift header from ExpoModulesCore, we put the Objective C interface for Logger.swift here

@interface EXLogger

// This class method is the only way to create an instance
+ (EXLogger * _Nonnull)newInstanceWithCategory:(NSString * _Nonnull)category;

- (void)traceWithCode:(NSInteger)code message:(NSString * _Nonnull)message;
- (void)debugWithCode:(NSInteger)code message:(NSString * _Nonnull)message;
- (void)infoWithCode:(NSInteger)code message:(NSString * _Nonnull)message;
- (void)warnWithCode:(NSInteger)code message:(NSString * _Nonnull)message;
- (void)errorWithCode:(NSInteger)code message:(NSString * _Nonnull)message;
- (void)fatalWithCode:(NSInteger)code message:(NSString * _Nonnull)message;

- (void)timeStart:(NSString * _Nonnull)idString;
- (void)timeEnd:(NSString * _Nonnull)idString;

@end

@interface EXUpdatesLogger()

@property (nonatomic, strong, nonnull) EXLogger *logger;

@end

@implementation EXUpdatesLogger

- (instancetype)init
{
  if (self == [super init]) {
    self.logger = [EXLogger newInstanceWithCategory:@"expo-updates"];
  }
  return self;
}

- (void)traceWithCode:(NSInteger)code message:(NSString * _Nonnull)message
{
  [self.logger traceWithCode:code message:message];
}

- (void)debugWithCode:(NSInteger)code message:(NSString * _Nonnull)message
{
  [self.logger debugWithCode:code message:message];
}

- (void)infoWithCode:(NSInteger)code message:(NSString * _Nonnull)message
{
  [self.logger infoWithCode:code message:message];
}

- (void)warnWithCode:(NSInteger)code message:(NSString * _Nonnull)message
{
  [self.logger warnWithCode:code message:message];
}

- (void)errorWithCode:(NSInteger)code message:(NSString * _Nonnull)message
{
  [self.logger errorWithCode:code message:message];
}

- (void)fatalWithCode:(NSInteger)code message:(NSString * _Nonnull)message
{
  [self.logger fatalWithCode:code message:message];
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
