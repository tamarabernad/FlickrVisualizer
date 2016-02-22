//
//  TBWThumbsHeaderView.m
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 21/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import "TBWThumbsHeaderView.h"
#import "TBWTagCell.h"
#import "TBWTagsVM.h"
@interface TBWThumbsHeaderView()<UICollectionViewDataSource, UICollectionViewDelegate, TBWTagsVMDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (nonatomic, strong) TBWTagsVM *viewModel;
@property (nonatomic, strong) UILabel *testLabel;
@end
@implementation TBWThumbsHeaderView

#pragma mark - lazy getters
- (UILabel *)testLabel{
    if(!_testLabel){
        _testLabel = [UILabel new];
    }
    return _testLabel;
}
- (TBWTagsVM *)viewModel{
    if(!_viewModel){
        _viewModel = [TBWTagsVM new];
        _viewModel.delegate = self;
    }
    return _viewModel;
}

#pragma mark - actions
- (IBAction)onAddClick:(id)sender {
    [self search];
}
- (void)onDeleteClick:(id)sender{
    [self.viewModel removeTagAtIndex:((UIButton *)sender).tag];
}
- (void)awakeFromNib{
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([TBWTagCell class]) bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:NSStringFromClass([TBWTagCell class])];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.tfSearch.delegate = self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.viewModel numberOfSections];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.viewModel numberOfItemsInSection:section];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TBWTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TBWTagCell class]) forIndexPath:indexPath];
    cell.lbTag.text = [self.viewModel titleForItemAtIndexPath:indexPath];
    [cell.lbTag sizeToFit];
    cell.btDelete.tag = indexPath.row;
    [cell.btDelete addTarget:self action:@selector(onDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //TODO way to ugly
    self.testLabel.text = [self.viewModel titleForItemAtIndexPath:indexPath];
    [self.testLabel sizeToFit];
    static CGFloat kDeleteButtonWidth = 35;
    return CGSizeMake(self.testLabel.frame.size.width + kDeleteButtonWidth, 20);
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

#pragma mark - TBWTagsVMDelegate
- (void)TBWTagsVMDatasetModified:(TBWTagsVM *)viewModel{
    [self.collectionView reloadData];
    [self.delegate TBWThumbsHeaderView:self didUpdateTags:[self.viewModel tags]];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self search];
    return YES;
}

#pragma mark - helpers
- (void)search{
    if([self.tfSearch.text isEqualToString:@""] || !self.tfSearch.text)return;
    [self.viewModel addTag:self.tfSearch.text];
    self.tfSearch.text = @"";
}
@end
