//
//  TBWDataProvider.m
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 19/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import "TBWDataProvider.h"
#import "MBXBaseService.h"
#import "TBWFlickrKitConnector.h"
#import "MBXBaseParseParser.h"
#import "TBWFlickrPhoto.h"
#import "TBWFlickrFeedPage.h"

@implementation TBWDataProvider
+ (void)getImagesWithTags:(NSString *)tags withSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    MBXBaseService *service = [[MBXBaseService alloc] initWithParser:nil AndConnector:[TBWFlickrKitConnector new]];
    //TODO: make the per page pass per parmeter
    [service getObjectsWithParams:@{@"tags":tags, @"per_page":@"15"} success:^(id responseObject) {
        
        //TODO: put this in an NSOperation or GCD inside the parser utility to parse in background
        MBXBaseParseParser *pageParser = [MBXBaseParseParser newParserWithModelClass:[TBWFlickrFeedPage class]];
        [pageParser processWithData:responseObject AndCompletion:^(id result) {

            MBXBaseParseParser *photosParser = [MBXBaseParseParser newParserWithModelClass:[TBWFlickrPhoto class]];
            [photosParser processDataArray:[responseObject valueForKeyPath:@"photos.photo"] WithCompletion:success];
        }];
    } failure:failure];
}
@end
