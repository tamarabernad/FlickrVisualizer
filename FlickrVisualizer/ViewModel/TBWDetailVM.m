//
//  TBWDetailVM.m
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 21/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import "TBWDetailVM.h"
#import "TBWFlickrPhoto.h"
#import "TBWDataProvider.h"

@interface TBWDetailVM()

@property(nonatomic, strong)NSString *photoId;
@property(nonatomic, strong)TBWFlickrPhoto *data;

@end
@implementation TBWDetailVM

#pragma mark - public
- (NSString *)imageUrl{
    return [self.data imageUrlLarge];
}
- (NSString *)title{
    return self.data.title;
}
- (NSString *)body{
    return self.data.body;
}
#pragma mark - MBXAsyncViewModelProtocol
- (void)retrieveDataWithSuccess:(void (^)(void))success AndFailure:(void (^)(NSError *))failure{
    [TBWDataProvider getPhotoInfoWithId:self.photoId withSuccess:^(id result) {
        self.data = result;
        success();
    } failure:failure];
}
@end
