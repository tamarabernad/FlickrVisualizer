//
//  TBWThumbsViewController.m
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 20/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import "TBWThumbsViewController.h"
#import "TBWThumbsVM.h"
#import "TBWThumbCell.h"
@interface TBWThumbsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) TBWThumbsVM *viewModel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation TBWThumbsViewController

#pragma mark - Lazy getters
- (TBWThumbsVM *)viewModel{
    if(!_viewModel){
        _viewModel = [TBWThumbsVM new];
    }
    return _viewModel;
}

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([TBWThumbCell class]) bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:NSStringFromClass([TBWThumbCell class])];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

}
- (void)viewDidAppear:(BOOL)animated{
    [self.viewModel retrieveDataWithSuccess:^{
        [self.collectionView reloadData];
    } AndFailure:^(NSError *error) {
       //TODO: show failure alert
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.viewModel numberOfSections];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.viewModel numberOfItemsInSection:section];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

@end
