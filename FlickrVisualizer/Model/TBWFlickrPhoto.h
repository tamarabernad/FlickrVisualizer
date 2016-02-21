//
//  TBWFlickrPhoto.h
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 20/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBWFlickrPhoto : NSObject
@property(nonatomic, strong) NSString *uid;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *server;
@property(nonatomic, strong) NSString *secret;
@property(nonatomic, strong) NSNumber *farm;

//photo info
@property(nonatomic, strong) NSString *body;

- (NSString *)imageUrlSmall;
- (NSString *)imageUrlLarge;
@end
