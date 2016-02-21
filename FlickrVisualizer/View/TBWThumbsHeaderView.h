//
//  TBWThumbsHeaderView.h
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 21/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TBWThumbsHeaderViewDelegate;
@interface TBWThumbsHeaderView : UICollectionReusableView
@property (nonatomic, weak)id<TBWThumbsHeaderViewDelegate> delegate;
@end

@protocol TBWThumbsHeaderViewDelegate <NSObject>
- (void)TBWThumbsHeaderView:(TBWThumbsHeaderView *)view didUpdateTags:(NSArray *)tags;
@end