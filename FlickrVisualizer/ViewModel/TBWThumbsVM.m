    //
//  TBWThumbsVM.m
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 20/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import "TBWThumbsVM.h"
#import "TBWDataProvider.h"
#import "TBWFlickrFeedPage.h"

@interface TBWThumbsVM()
@property(nonatomic, strong) NSArray *data;
@property(nonatomic) NSInteger itemsPerPage;
@property(nonatomic) BOOL isLoadingData;
@property (nonatomic, strong) TBWFlickrFeedPage *page;
@property (nonatomic, strong)NSString *searchTags;
@end
@implementation TBWThumbsVM

#pragma mark - Lazy getters
- (NSArray *)data{
    if(!_data){
        _data = @[];
    }
    return _data;
}
- (NSString *)searchTags{
    if(!_searchTags || [_searchTags isEqualToString:@""]){
        _searchTags = @"Philips";
    }
    return _searchTags;
}

#pragma mark - Public
- (void)setTags:(NSArray *)tags{
    [self reset];
    self.searchTags = [tags componentsJoinedByString:@","];
    [self retrieveDataForPage:0 WithSuccess:nil AndFailure:nil];
}
- (NSString *)getFlickrPhotoIdAtIndexPath:(NSIndexPath *)indexPath{
    return [self photoAtIndex:indexPath.row].uid;
}
- (void)setNumberOfItemsPerPage:(NSInteger)nItemsPerPage{
    _itemsPerPage = nItemsPerPage;
}
- (void)checkDataForIndexPath:(NSIndexPath *)indexPath{

    if((indexPath.row >= [self.page.page integerValue] * [self.page.perpage integerValue]) && !self.isLoadingData){
        [self retrieveDataForPage:[self.page.page integerValue] + 1 WithSuccess:nil AndFailure:nil];
    }
}

#pragma mark - MBXAsyncViewModelProtocol
- (void)retrieveDataForPage:(NSInteger)page WithSuccess:(void (^)(void))success AndFailure:(void (^)(NSError *))failure{
    self.isLoadingData = YES;

    [TBWDataProvider getImagesWithTags:self.searchTags forPage:page withItemsPerPage:[self nItemsToRequest] withSuccess:^(id result) {
        self.isLoadingData = NO;
        
        NSMutableArray *arr = [NSMutableArray arrayWithArray:[result valueForKey:@"photos"]];
        self.data = [self.data arrayByAddingObjectsFromArray:arr];
        self.page = [result valueForKey:@"page"];
        [self.delegate TBWThumbsVMDidLoadData:self];
        if(success)success();
    } failure:^(NSError *error) {
        self.data = @[];
       [self.delegate TBWThumbsVMDidLoadData:self];
    }];
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
- (NSInteger)nItemsToRequest{
    return self.itemsPerPage * 2;
}
- (TBWFlickrPhoto *)photoAtIndex:(NSInteger)index{
    //TODO: scroll is not infinite yet, make it infinite with an circular array checking index on [self.page totalItems]
    return self.data.count - 1 < index ? nil : [self.data objectAtIndex:index];
}
- (void)reset{
    self.data = nil;
}
@end
