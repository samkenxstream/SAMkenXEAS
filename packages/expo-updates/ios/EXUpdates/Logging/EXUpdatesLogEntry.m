// Copyright 2022-present 650 Industries. All rights reserved.

#import "EXUpdatesLogEntry.h"


@implementation EXUpdatesLogEntry

- (id)initWithCoder:(NSCoder *)decoder {
  if (self = [super init]) {
    self.message = [decoder decodeObjectForKey:@"message"];
    self.code = (EXUpdatesErrorCode)[decoder decodeIntForKey:@"code"];
    self.updateId = [decoder decodeObjectForKey:@"updateId"];
    self.assetId = [decoder decodeObjectForKey:@"assetId"];

  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:_message forKey:@"message"];
  [encoder encodeInt:_code forKey:@"code"];
  [encoder encodeObject:_updateId forKey:@"updateId"];
  [encoder encodeObject:_assetId forKey:@"assetId"];
}


@end
