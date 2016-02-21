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

@property (nonatomic, strong) TBWDetailVM *viewModel;
@end
@implementation TBWDetailViewController

#pragma mark - public
- (void)setPhotoId:(NSString *)photoId{
    [self.viewModel setPhotoId:photoId];
}
#pragma mark - actions
- (IBAction)onCloseClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    [self.viewModel retrieveDataWithSuccess:^{
        [self.imgView setImageWithURL:[NSURL URLWithString:[self.viewModel imageUrl]]];
        self.lbTitle.text = [self.viewModel title];
        self.lbDescription.text = [self.viewModel body];
        self.navTitle.title = [self.viewModel title];
    } AndFailure:^(NSError *error) {
        //TODO: show error handling
    }];
}
@end
