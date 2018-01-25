//
//  TagListCollectionLayout.m
//  changpingSchoolTeacher
//
//  Created by 王楠 on 16/9/4.
//  Copyright © 2016年 combanc. All rights reserved.
//

#import "TagListCollectionLayout.h"

@interface TagListCollectionLayout ()
@property (nonatomic, assign) CGPoint endPoint;

@property (nonatomic, assign) NSInteger count;

// arrays to keep track of insert, delete index paths
@property (nonatomic, strong) NSMutableArray *deleteIndexPaths;
@property (nonatomic, strong) NSMutableArray *insertIndexPaths;
@end

@implementation TagListCollectionLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.endPoint = CGPointZero;
    //获取item的UICollectionViewLayoutAttributes
    _count = [self.collectionView numberOfItemsInSection:0];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (CGSize)collectionViewContentSize
{
    CGSize contentSize;
    contentSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), self.endPoint.y);
    return contentSize;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat width = 0.0;
    if ([self.delegate collectionView:self.collectionView layout:self widthAtIndexPath:indexPath]) {
        width = [self.delegate collectionView:self.collectionView layout:self widthAtIndexPath:indexPath];
    }
    CGFloat heigh = self.itemHeigh;
    CGFloat x = 0.0;
    CGFloat y = 0.0;
    
    CGFloat judge = self.endPoint.x + width + self.itemSpacing + self.sectionInset.right;
    // 大于就换行
    if (judge > CGRectGetWidth(self.collectionView.frame)) {
        x = self.sectionInset.left;
        y = self.endPoint.y + self.lineSpacing;
    }else{
        if (indexPath.item == 0) {
            x = self.sectionInset.left;
            y = self.sectionInset.top;
        }else{
            x = self.endPoint.x + self.itemSpacing;
            y = self.endPoint.y - heigh;
        }
        
    }
    // 更新结束位置
    self.endPoint = CGPointMake(x + width, y + heigh);
    
    if (indexPath.row + 1 == _count) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cellHeight" object:nil userInfo:@{@"height":[NSString stringWithFormat:@"%f",y+heigh]}];
    }
    
    attr.frame = CGRectMake(x, y, width, heigh);
    return attr;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray * attrsArray = [NSMutableArray array];
    
    for (NSInteger j = 0; j < _count; j++) {
        UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:j inSection:0]];
        [attrsArray addObject:attrs];
    }
    return  attrsArray;
}

@end
