//
//  TBWTagsVM.m
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 21/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import "TBWTagsVM.h"
@interface TBWTagsVM()
@property (nonatomic, strong) NSMutableArray *data;
@end
@implementation TBWTagsVM

#pragma mark - lazy getterss
- (NSMutableArray *)data{
    if(!_data){
        _data = [NSMutableArray new];
    }
    return _data;
}

#pragma mark - public
- (NSArray *)tags{
    return [NSArray arrayWithArray:self.data];
}
- (void)addTag:(NSString *)tag{
    [self.data addObject:tag];
    [self.delegate TBWTagsVMDatasetModified:self];
}
- (void)removeTagAtIndex:(NSInteger)index{
    [self.data removeObjectAtIndex:index];
    [self.delegate TBWTagsVMDatasetModified:self];
}
#pragma mark - MBXListViewModelProtocol
- (NSInteger)numberOfItemsInSection:(NSInteger)section{
    return [self.data count];
}
- (NSInteger)numberOfSections{
    return 1;
}
- (NSString *)titleForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self.data objectAtIndex:indexPath.row];
}
@end
