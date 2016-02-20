//
//  TBWDataProvider.m
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 19/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import "TBWDataProvider.h"
#import "TBWFlickrService.h"

@implementation TBWDataProvider
+ (void)getImagesWithTags:(NSString *)tags withSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    TBWFlickrService *service = [TBWFlickrService new];
    //TODO: make the per page pass per parmeter
    [service getObjectsWithParams:@{@"tags":tags, @"per_page":@"15"} Success:success failure:failure];
}
@end
