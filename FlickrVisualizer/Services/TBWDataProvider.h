//
//  TBWDataProvider.h
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 19/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBWDataProvider : NSObject
+ (void) getImagesWithTags:(NSString *)tags withSuccess:(void (^)(id result))success failure:(void (^)(NSError *error))failure;
@end
