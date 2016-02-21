//
//  MBXBaseParseParser.h
//  sven-10
//
//  Created by Tamara Bernad on 27/09/15.
//  Copyright (c) 2015 moodbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBXServiceParserProtocol.h"

@interface MBXBaseParser : NSObject<MBXServiceParserProtocol>
@property (nonatomic) Class modelClass;

+ (instancetype)newParserWithModelClass:(Class)modelClass;
- (instancetype)initWithModelClass:(Class)modelClass;
@end
