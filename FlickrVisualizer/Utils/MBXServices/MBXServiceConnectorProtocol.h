//
//  MBXServiceConnectorProtocol.h
//  sven-10
//
//  Created by Tamara Bernad on 25/09/15.
//  Copyright (c) 2015 moodbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MBXServiceConnectorProtocol <NSObject>
- (void) getObjectsWithParams:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
- (void) getObjectWithParams:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
