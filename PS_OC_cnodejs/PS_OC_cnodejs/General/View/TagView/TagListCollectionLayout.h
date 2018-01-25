//
//  TagListCollectionLayout.h
//  changpingSchoolTeacher
//
//  Created by 王楠 on 16/9/4.
//  Copyright © 2016年 combanc. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const UICollectionElementKindSectionHeader;
UIKIT_EXTERN NSString *const UICollectionElementKindSectionFooter;

@class TagListCollectionLayout;
@protocol TagCollectionLayoutDelegate <NSObject>
@required
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(TagListCollectionLayout*)collectionViewLayout widthAtIndexPath:(NSIndexPath *)indexPath;

@optional
//section header
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(TagListCollectionLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
//section footer
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(TagListCollectionLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
@end


@interface TagListCollectionLayout : UICollectionViewLayout

@property (nonatomic, weak) id<TagCollectionLayoutDelegate> delegate;

@property(nonatomic, assign) UIEdgeInsets sectionInset; //sectionInset
@property(nonatomic, assign) CGFloat lineSpacing;  //line space
@property(nonatomic, assign) CGFloat itemSpacing; //item space
@property(nonatomic, assign) CGFloat itemHeigh;  //item heigh

@end

