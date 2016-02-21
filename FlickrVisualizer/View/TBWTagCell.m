//
//  TBWTagCell.m
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 21/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import "TBWTagCell.h"

@implementation TBWTagCell

- (void)awakeFromNib {
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
}

@end
