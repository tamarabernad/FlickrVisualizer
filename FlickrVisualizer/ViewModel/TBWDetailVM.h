//
//  TBWDetailVM.h
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 21/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBXAsyncViewModelProtocol.h"

@interface TBWDetailVM : NSObject<MBXAsyncViewModelProtocol>
- (void)setPhotoId:(NSString *)photoId;
- (NSString *)imageUrl;
- (NSString *)title;
- (NSString *)body;
@end
