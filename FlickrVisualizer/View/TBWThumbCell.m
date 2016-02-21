//
//  TBWThumbCell.m
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 20/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import "TBWThumbCell.h"
#import "UIImageView+AFNetworking.h"

@interface TBWThumbCell()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end
@implementation TBWThumbCell

#pragma mark - public
- (void)setImageUrl:(NSString *)url{
    self.imgView.image = nil;
    [self.activityIndicator startAnimating];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    TBWThumbCell __weak *weakSelf = self;
    [self.imgView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [weakSelf.activityIndicator stopAnimating];
        self.imgView.image = image;
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        [weakSelf.activityIndicator stopAnimating];
        self.imgView.image = nil;
    }];
}


@end
