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
#import "TBWFlickrFeedPage.h"

@interface TBWThumbsVM()
@property(nonatomic, strong) NSArray *data;
@property(nonatomic) NSInteger itemsPerPage;
@property(nonatomic) BOOL isLoadingData;
@property (nonatomic, strong) TBWFlickrFeedPage *page;
@end
@implementation TBWThumbsVM

#pragma mark - Lazy getters
- (NSArray *)data{
    if(!_data){
        _data = @[];
    }
    return _data;
}
#pragma mark - Public
- (void)setNumberOfItemsPerPage:(NSInteger)nItemsPerPage{
    _itemsPerPage = nItemsPerPage;
}
- (void)checkDataForIndexPath:(NSIndexPath *)indexPath{
    if((indexPath.row >= [self.page.page integerValue] * self.itemsPerPage) && !self.isLoadingData){
        [self retrieveDataForPage:[self.page.page integerValue] + 1 WithSuccess:nil AndFailure:nil];
    }
}
#pragma mark - MBXAsyncViewModelProtocol
- (void)retrieveDataForPage:(NSInteger)page WithSuccess:(void (^)(void))success AndFailure:(void (^)(NSError *))failure{
    self.isLoadingData = YES;
    [TBWDataProvider getImagesWithTags:@"grass" forPage:page withItemsPerPage:self.itemsPerPage withSuccess:^(id result) {
        self.isLoadingData = NO;
        
        NSMutableArray *arr = [NSMutableArray arrayWithArray:[result valueForKey:@"photos"]];
        self.data = [self.data arrayByAddingObjectsFromArray:arr];
        self.page = [result valueForKey:@"page"];
        [self.delegate TBWThumbsVMDidLoadData:self];
        if(success)success();
    } failure:failure];
}

#pragma mark - MBXListViewModelProtocol
- (NSInteger)numberOfItemsInSection:(NSInteger)section{
    return [self.page totalItems];
}
- (NSInteger)numberOfSections{
    return 1;
}
- (NSString *)imageUrlForIndexPath:(NSIndexPath *)indexPath{
    return [[self photoAtIndex:indexPath.row] imageUrlSmall];
}

#pragma mark - helpers
- (TBWFlickrPhoto *)photoAtIndex:(NSInteger)index{
    return self.data.count - 1 < index ? nil : [self.data objectAtIndex:index];
}
@end
