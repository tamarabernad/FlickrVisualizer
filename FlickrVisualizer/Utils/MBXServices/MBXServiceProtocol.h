//
//  MBXServiceProtocol.h
//  sven-10
//
//  Created by Tamara Bernad on 25/09/15.
//  Copyright (c) 2015 moodbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBXServiceParserProtocol.h"
#import "MBXServiceConnectorProtocol.h"

@protocol MBXServiceProtocol <NSObject>
- (id)initWithParser:(id<MBXServiceParserProtocol>)parser AndConnector:(id<MBXServiceConnectorProtocol>)connector;
- (void) getObjectsWithParams:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
- (void) getObjectWithParams:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end
