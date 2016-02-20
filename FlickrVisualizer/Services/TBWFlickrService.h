//
//  TBWFlickrService.h
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 19/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBWFlickrService : NSObject
- (void)getObjectsWithParams:(NSDictionary *)params Success:(void (^)(id results))success failure:(void (^)(NSError *failure))failure;
@end
