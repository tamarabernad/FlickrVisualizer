//
//  TBWTagsVM.h
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 21/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBXListViewModelProtocol.h"

@protocol TBWTagsVMDelegate;
@interface TBWTagsVM : NSObject<MBXListViewModelProtocol>
@property (nonatomic, weak)id<TBWTagsVMDelegate> delegate;
- (void)addTag:(NSString *)tag;
- (void)removeTagAtIndex:(NSInteger)index;
- (NSArray *)tags;
@end

@protocol TBWTagsVMDelegate
- (void)TBWTagsVMDatasetModified:(TBWTagsVM *)viewModel;

@end
