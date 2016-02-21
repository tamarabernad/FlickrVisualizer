//
//  TBWDetailViewController.h
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 21/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TBWDetailViewControllerDelegate;
@interface TBWDetailViewController : UIViewController
@property(nonatomic, weak) id<TBWDetailViewControllerDelegate> delegate;
- (void)setPhotoId:(NSString *)photoId;
@end

@protocol TBWDetailViewControllerDelegate <NSObject>

- (void)TBWDetailViewControllerDismiss:(TBWDetailViewController *)controller;

@end