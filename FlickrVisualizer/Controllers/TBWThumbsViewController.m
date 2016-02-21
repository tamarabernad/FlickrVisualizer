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
@interface TBWThumbsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, TBWThumbsVMDelegate, TBWThumbsHeaderViewDelegate, TBWDetailViewControllerDelegate>
{
    UIDynamicAnimator* _animator;
    UIGravityBehavior* _gravity;
    UIGravityBehavior* _gravity2;
    UICollisionBehavior* _collision;
    UIPushBehavior *pushBehavior;
//    UIFieldBehavior *f;
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
    vc.delegate = self;
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
        headerView.delegate = self;
        reusableview = headerView;
    }
    return reusableview;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *clickedCell = [self.collectionView cellForItemAtIndexPath:indexPath];
    [self.collectionView bringSubviewToFront:clickedCell];
    NSArray *cells = [[self.collectionView visibleCells] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self != %@",clickedCell]];
    
//    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
//        UIFieldBehavior *f;
//    f  = [UIFieldBehavior radialGravityFieldWithPosition:clickedCell.frame.origin];
//    f.region = [[UIRegion alloc] initWithRadius:300.0];
//    f.strength = -30;
//    f.falloff = 1.0;
//    f.minimumRadius = 600.0;
//    for (UICollectionViewCell *c in cells) {
//        [f addItem:c];
//    }
//    [_animator addBehavior:f];
    
    [UIView animateWithDuration:1 animations:^{
        clickedCell.transform = CGAffineTransformScale(clickedCell.transform, 4, 4);
    }];

    [self performSelector:@selector(showDetailWithIndexPath:) withObject:indexPath afterDelay:1];

}
- (void)showDetailWithIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"segue-detail" sender:[self.viewModel getFlickrPhotoIdAtIndexPath:indexPath]];
}
#pragma mark - TBWThumbsVMDelegate
- (void)TBWThumbsVMDidLoadData:(TBWThumbsVM *)viewModel{
    [self.collectionView reloadData];
}

#pragma mark - TBWThumbsHeaderViewDelegate
- (void)TBWThumbsHeaderView:(TBWThumbsHeaderView *)view didUpdateTags:(NSArray *)tags{
    [self.viewModel setTags:tags];
}

#pragma mark - TBWDetailViewControllerDelegate
- (void)TBWDetailViewControllerDismiss:(TBWDetailViewController *)controller{
    [controller dismissViewControllerAnimated:YES completion:nil];
    [self.collectionView reloadData];
}
@end
