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
#import "MBXBaseParser.h"
#import "TBWFlickrPhoto.h"
#import "TBWFlickrFeedPage.h"
#import "MBXMappedParser.h"

@implementation TBWDataProvider
+ (void)getImagesWithTags:(NSString *)tags forPage:(NSInteger) page withItemsPerPage:(NSInteger)itemsPerPage withSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{

    MBXBaseService *service = [[MBXBaseService alloc] initWithParser:nil AndConnector:[TBWFlickrKitConnector new]];
    [service getObjectsWithParams:@{@"tags":tags, @"per_page":[NSString stringWithFormat:@"%li",(long)itemsPerPage], @"page":[NSString stringWithFormat:@"%li",(long)page]} success:^(id responseObject) {

        MBXBaseParser *pageParser = [MBXBaseParser newParserWithModelClass:[TBWFlickrFeedPage class]];
        [pageParser processWithData:[responseObject valueForKey:@"photos"] AndCompletion:^(id result) {
            TBWFlickrFeedPage *page = result;
            MBXBaseParser *photosParser = [MBXBaseParser newParserWithModelClass:[TBWFlickrPhoto class]];
            [photosParser processDataArray:[responseObject valueForKeyPath:@"photos.photo"] WithCompletion:^(id result) {
                success(@{@"page":page, @"photos":result});
            }];
        }];
    } failure:failure];
}
+ (void)getPhotoInfoWithId:(NSString *)photoId withSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    MBXBaseService *service = [[MBXBaseService alloc] initWithParser:[MBXMappedParser newParserWithModelClass:[TBWFlickrPhoto class] andMapping:@{@"body":@"photo.description._content", @"title":@"photo.title._content", @"farm":@"photo.farm", @"server":@"photo.server", @"uid":@"photo.id",@"secret":@"photo.secret"}] AndConnector:[TBWFlickrKitConnector new]];

    [service getObjectWithParams:@{@"photo_id":photoId} success:^(id responseObject) {
        success(responseObject);
    } failure:failure];
}
@end
