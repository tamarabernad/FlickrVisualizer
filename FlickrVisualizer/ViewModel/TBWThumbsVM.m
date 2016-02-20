//
//  TBWThumbsVM.m
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 20/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import "TBWThumbsVM.h"
#import "TBWDataProvider.h"
#import "TBWFlickrPhoto.h"
#import "FlickrKit.h"

@interface TBWThumbsVM()
@property(nonatomic, strong) NSArray *data;
@end
@implementation TBWThumbsVM

#pragma mark - MBXAsyncViewModelProtocol
- (void)retrieveDataWithSuccess:(void (^)(void))success AndFailure:(void (^)(NSError *))failure{
    [TBWDataProvider getImagesWithTags:@"grass" withSuccess:^(id result) {
        self.data = result;
        success();
    } failure:failure];
}

#pragma mark - MBXListViewModelProtocol
- (NSInteger)numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}
- (NSInteger)numberOfSections{
    return 1;
}
- (NSString *)imageUrlForIndexPath:(NSIndexPath *)indexPath{
    return [[self photoAtIndex:indexPath.row] imageUrlSmall];
}

#pragma mark - helpers
- (TBWFlickrPhoto *)photoAtIndex:(NSInteger)index{
    return [self.data objectAtIndex:index];
}
@end
