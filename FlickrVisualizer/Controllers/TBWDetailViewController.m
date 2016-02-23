//
//  TBWDetailViewController.m
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 21/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import "TBWDetailViewController.h"
#import "TBWDetailVM.h"
#import "UIImageView+AFNetworking.h"

@interface TBWDetailViewController()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITextView *lbDescription;
@property (weak, nonatomic) IBOutlet UINavigationItem *navTitle;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) TBWDetailVM *viewModel;
@end
@implementation TBWDetailViewController

#pragma mark - public
- (void)setPhotoId:(NSString *)photoId{
    [self.viewModel setPhotoId:photoId];
}

#pragma mark - actions
- (IBAction)onCloseClick:(id)sender {
    [self.delegate TBWDetailViewControllerDismiss:self];
}

#pragma mark - Lazy getters
- (TBWDetailVM *)viewModel{
    if(!_viewModel){
        _viewModel = [TBWDetailVM new];
    }
    return  _viewModel;
}

#pragma mark - Life cycle
- (void)viewWillAppear:(BOOL)animated{
    self.lbTitle.text = @"";
    self.lbDescription.text = @"";
    self.navTitle.title = @"";
}
- (void)viewDidAppear:(BOOL)animated{
    TBWDetailViewController __weak *weakSelf = self;
    [self.viewModel retrieveDataWithSuccess:^{
        [weakSelf loadImage];
        weakSelf.lbTitle.text = [weakSelf.viewModel title];
        weakSelf.lbDescription.text = [weakSelf.viewModel body];
        weakSelf.navTitle.title = [weakSelf.viewModel title];
    } AndFailure:^(NSError *error) {
        //TODO: show error handling
    }];
}
- (void)loadImage{
    [self.activityIndicator startAnimating];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self.viewModel imageUrl]]];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    TBWDetailViewController __weak *weakSelf = self;
    [self.imgView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [weakSelf.activityIndicator stopAnimating];
        weakSelf.imgView.image = image;
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        [weakSelf.activityIndicator stopAnimating];
        weakSelf.imgView.image = nil;
    }];
}
@end
