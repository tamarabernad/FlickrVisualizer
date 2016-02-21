//
//  TBWThumbsVM.h
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 20/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBXListViewModelProtocol.h"
#import "TBWFlickrPhoto.h"

@protocol TBWThumbsVMDelegate;
@interface TBWThumbsVM : NSObject<MBXListViewModelProtocol>

@property(nonatomic, weak)id<TBWThumbsVMDelegate> delegate;
- (void)retrieveDataForPage:(NSInteger)page WithSuccess:(void (^)(void))success AndFailure:(void (^)(NSError *))failure;
- (void)setNumberOfItemsPerPage:(NSInteger)nItemsPerPage;
- (void)checkDataForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)getFlickrPhotoIdAtIndexPath:(NSIndexPath *)indexPath;
@end

@protocol TBWThumbsVMDelegate <NSObject>
- (void)TBWThumbsVMDidLoadData:(TBWThumbsVM *)viewModel;
@end