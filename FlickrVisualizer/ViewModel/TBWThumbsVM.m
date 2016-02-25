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
@property (nonatomic, strong) TBWDataProvider *dataProvider;
@end
@implementation TBWThumbsVM

#pragma mark - Lazy getters
- (TBWDataProvider *)dataProvider{
    if(!_dataProvider){
        _dataProvider = [TBWDataProvider new];
    }
    return _dataProvider;
}
- (NSArray *)data{
    if(!_data){
        _data = @[];
    }
    return _data;
}
- (NSString *)searchTags{
    if(!_searchTags || [_searchTags isEqualToString:@""]){
        _searchTags = @"ocean";
    }
    return _searchTags;
}

#pragma mark - Public
- (void)setTags:(NSArray *)tags{
    [self reset];
    self.searchTags = [tags componentsJoinedByString:@","];
    [self retrieveDataForPage:0 notifyDataSetChange:YES];
}
- (NSString *)getFlickrPhotoIdAtIndexPath:(NSIndexPath *)indexPath{
    return [self photoAtIndex:indexPath.row].uid;
}
- (void)setNumberOfItemsPerPage:(NSInteger)nItemsPerPage{
    _itemsPerPage = nItemsPerPage;
}
- (void)checkDataForIndexPath:(NSIndexPath *)indexPath{

    if((indexPath.row >= [self.page.page integerValue] * [self.page.perpage integerValue]) && !self.isLoadingData){
        [self retrieveDataForPage:[self.page.page integerValue] + 1 notifyDataSetChange:NO];
    }
}

#pragma mark - Data provisioning
- (void)retrieveDataForPage:(NSInteger)page{
    [self retrieveDataForPage:page notifyDataSetChange:YES];
}
- (void)retrieveDataForPage:(NSInteger)page notifyDataSetChange:(BOOL)notify{
    self.isLoadingData = YES;
    
    TBWThumbsVM __weak *weakSelf = self;
    [self.dataProvider getImagesWithTags:self.searchTags forPage:page withItemsPerPage:[self nItemsToRequest] withSuccess:^(id result) {
        weakSelf.isLoadingData = NO;
        
        NSMutableArray *arr = [NSMutableArray arrayWithArray:[result valueForKey:@"photos"]];
        weakSelf.data = [weakSelf.data arrayByAddingObjectsFromArray:arr];
        weakSelf.page = [result valueForKey:@"page"];
        if(notify)[weakSelf.delegate TBWThumbsVMDidLoadData:weakSelf];
    } failure:^(NSError *error) {
        weakSelf.isLoadingData = NO;
        weakSelf.data = @[];
       [weakSelf.delegate TBWThumbsVMDidLoadData:weakSelf];
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
