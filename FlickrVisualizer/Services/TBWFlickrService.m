//
//  TBWFlickrService.m
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 19/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import "TBWFlickrService.h"
#import "FlickrKit.h"

@implementation TBWFlickrService
- (void)getObjectsWithParams:(NSDictionary *)params Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [[FlickrKit sharedFlickrKit] call:@"flickr.photos.search" args:params maxCacheAge:FKDUMaxAgeOneHour completion:^(NSDictionary *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (response) {
                // extract images from the response dictionary
            } else {
                // show the error
            }
        });
    }];
}
@end
