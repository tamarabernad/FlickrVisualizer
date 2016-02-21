//
//  MBXRoundedIconButton.m
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 21/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import "MBXRoundedIconButton.h"

@implementation MBXRoundedIconButton
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setImage:[self.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    self.layer.cornerRadius = self.frame.size.width * 0.5;
    self.layer.borderColor = [self.borderColor CGColor];
    self.layer.borderWidth = 2;
}

@end
