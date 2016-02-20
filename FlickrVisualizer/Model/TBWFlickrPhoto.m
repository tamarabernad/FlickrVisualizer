//
//  TBWFlickrPhoto.m
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 20/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import "TBWFlickrPhoto.h"
#import "FlickrKit.h"

@implementation TBWFlickrPhoto
- (NSString *)imageUrlSmall{
    return [[[FlickrKit sharedFlickrKit] photoURLForSize:FKPhotoSizeSmallSquare75 photoID:self.uid server:self.server secret:self.secret farm:[self.farm stringValue]] absoluteString];
}
@end
