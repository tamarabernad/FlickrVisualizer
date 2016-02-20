//
//  TBWThumbsVM.m
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 20/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import "TBWThumbsVM.h"
#import "TBWDataProvider.h"

@implementation TBWThumbsVM

#pragma mark - MBXAsyncViewModelProtocol
- (void)retrieveDataWithSuccess:(void (^)(void))success AndFailure:(void (^)(NSError *))failure{
    [TBWDataProvider getImagesWithTags:@"grass" withSuccess:^(id result) {
        success();
    } failure:failure];
}

#pragma mark - MBXListViewModelProtocol
- (NSInteger)numberOfItemsInSection:(NSInteger)section{
    return 0;
}
- (NSInteger)numberOfSections{
    return 0;
}
- (NSString *)imageUrlForIndexPath:(NSIndexPath *)indexPath{
    return @"";
}
@end
