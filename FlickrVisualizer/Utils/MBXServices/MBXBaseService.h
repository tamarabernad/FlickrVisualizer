//
//  MBXBaseService.h
//  sven-10
//
//  Created by Tamara Bernad on 27/09/15.
//  Copyright (c) 2015 moodbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBXServiceProtocol.h"
@interface MBXBaseService : NSObject<MBXServiceProtocol>
@property (nonatomic, strong) id<MBXServiceParserProtocol> parser;
@property (nonatomic, strong) id<MBXServiceConnectorProtocol> connector;
@end
