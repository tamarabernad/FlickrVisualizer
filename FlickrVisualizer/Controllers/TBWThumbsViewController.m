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

#define CELL_DIM 50.0
@interface TBWThumbsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, TBWThumbsVMDelegate>

@property (nonatomic, strong) TBWThumbsVM *viewModel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSInteger itemsPerCol;

@end

@implementation TBWThumbsViewController

#pragma mark - Lazy getters
- (TBWThumbsVM *)viewModel{
    if(!_viewModel){
        _viewModel = [TBWThumbsVM new];
        _viewModel.delegate = self;
    }
    return _viewModel;
}

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //TODO move the reuse identifier to the cell with a protocol ReusableCellProtocol and a class method returning the identifier
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([TBWThumbCell class]) bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:NSStringFromClass([TBWThumbCell class])];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    NSInteger itemsPerRow = floor(self.view.bounds.size.width / CELL_DIM);
    self.itemsPerCol = floor(self.view.bounds.size.height / CELL_DIM);
    [self.viewModel setNumberOfItemsPerPage:self.itemsPerCol*itemsPerRow];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [self.viewModel retrieveDataForPage:0 WithSuccess:nil AndFailure:^(NSError *error) {
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
    TBWThumbCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TBWThumbCell class]) forIndexPath:indexPath];
    [self.viewModel checkDataForIndexPath:indexPath];
    [cell setImageUrl:[self.viewModel imageUrlForIndexPath:indexPath]];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CELL_DIM, CELL_DIM);
}
#pragma mark - TBWThumbsVMDelegate
- (void)TBWThumbsVMDidLoadData:(TBWThumbsVM *)viewModel{
    [self.collectionView reloadData];
}
@end
