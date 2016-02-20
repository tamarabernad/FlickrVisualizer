//
//  MBXListViewModelProtocol.h
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 20/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MBXListViewModelProtocol <NSObject>
- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;

@optional
- (NSString *)titleForItemAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)imageUrlForIndexPath:(NSIndexPath *)indexPath;
@end