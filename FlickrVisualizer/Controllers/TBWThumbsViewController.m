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
#import "TBWDetailViewController.h"
#import "TBWThumbsHeaderView.h"

#define CELL_DIM 100.0
@interface TBWThumbsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, TBWThumbsVMDelegate>
{
    UIDynamicAnimator* _animator;
    UIGravityBehavior* _gravity;
    UICollisionBehavior* _collision;
    UIPushBehavior *pushBehavior;
}
@property (nonatomic, strong) TBWThumbsVM *viewModel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

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
    
    //TODO: move the reuse identifier to the cell with a protocol ReusableCellProtocol and a class method returning the identifier
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([TBWThumbCell class]) bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:NSStringFromClass([TBWThumbCell class])];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    

    //TODO: control rotation and recalculate items per page
    //TODO: make cell dimention dynamic to have always the same distance between cells
    NSInteger itemsPerCol = floor(self.view.bounds.size.width / CELL_DIM);
    NSInteger itemsPerRow= floor(self.view.bounds.size.height / CELL_DIM);
    [self.viewModel setNumberOfItemsPerPage:itemsPerCol*itemsPerRow];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [self.viewModel retrieveDataForPage:0 WithSuccess:nil AndFailure:^(NSError *error) {
       //TODO: show error handling
    }];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    TBWDetailViewController *vc = (TBWDetailViewController *)segue.destinationViewController;
    [vc setPhotoId:sender];
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
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        TBWThumbsHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header-view" forIndexPath:indexPath];
        reusableview = headerView;
    }
    return reusableview;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"segue-detail" sender:[self.viewModel getFlickrPhotoIdAtIndexPath:indexPath]];
//    UICollectionViewCell *clickedCell = [self.collectionView cellForItemAtIndexPath:indexPath];
//    [self.collectionView bringSubviewToFront:clickedCell];
//    
//    NSArray *cells = @[clickedCell];//[[self.collectionView visibleCells] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self != %@",clickedCell]];
//
//    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
//    _gravity = [[UIGravityBehavior alloc] initWithItems:cells];
//    [_animator addBehavior:_gravity];
//    _collision = [[UICollisionBehavior alloc]
//                  initWithItems:cells];
//    [_collision setTranslatesReferenceBoundsIntoBoundary:YES];
//    [_animator addBehavior:_collision];
//    UIDynamicItemBehavior* itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:cells];
//    itemBehaviour.elasticity = 0.8;
//    [_animator addBehavior:itemBehaviour];

}

#pragma mark - TBWThumbsVMDelegate
- (void)TBWThumbsVMDidLoadData:(TBWThumbsVM *)viewModel{
    [self.collectionView reloadData];
}
@end
