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
@property (nonatomic, strong) TBWDataProvider *dataProvider;
@end
@implementation TBWDetailVM

#pragma mark - public
- (TBWDataProvider *)dataProvider{
    if(!_dataProvider){
        _dataProvider = [TBWDataProvider new];
    }
    return _dataProvider;
}
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
    TBWDetailVM __weak *weakSelf = self;
    [self.dataProvider getPhotoInfoWithId:self.photoId withSuccess:^(id result) {
        weakSelf.data = result;
        success();
    } failure:failure];
}
@end
