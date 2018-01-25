//
//  ShareImageView.m
//  QianfengSchool
//
//  Created by chenhuan on 16/7/20.
//  Copyright © 2016年 Combanc. All rights reserved.
//

#import "SelectPhotoView.h"
#import "ShareImageFlowLayout.h"
#import "ShareImageCollectionCell.h"
#import "WSelectPhoto.h"
#import <CommonCrypto/CommonDigest.h>
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "SDPhotoBrowser.h"

static NSString *const shareImageCellID = @"SHAREIMAGE_CELLID";

//图片大小大于800kb的时候就压缩
#define FILE_MAXSIZE 800

@interface SelectPhotoView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ShareShareImageCellDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SDPhotoBrowserDelegate>

@property (nonatomic, strong) UICollectionView *shareImageCollectionView;/**<分享图片 */
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;/**<布局 */
@property (nonatomic, strong) NSMutableArray *selectImageMubArray;/**<选择的图片数组 */
@property (nonatomic, strong) NSMutableArray *imageSizeArray;/**图片的大小 */
@property (nonatomic, strong) NSMutableArray *imageFileNameArray;/**图片的文件名 */
@property (nonatomic, strong) NSMutableArray *imageUserNameArray;/**图片的重命名 */
@property (nonatomic, assign) NSInteger photoMaxCount;/**< 最多选择图片的个数*/
@property (nonatomic, assign) CGSize itemSize;/**cell的大小 */
@property (nonatomic, strong) NSMutableArray *placeholderArray;/**提示图片数组 */
@property (nonatomic, assign) NSInteger spaceOfLine;/**item间隔 */
@property (nonatomic, strong) NSMutableArray *MWPhotoArray;/**将图片转化为MWPhoto */
@end

@implementation SelectPhotoView

- (instancetype)initWithItemSize:(CGSize)size
                placeholderImage:(NSMutableArray *)imageArray
             selectPhotoMaxCount:(NSInteger)count
                  passImageArray:(NSMutableArray *)array
                     spaceOfline:(NSInteger)spaceOfLine {
    
    if (self = [super init]) {
        
        _itemSize = size;
        self.placeholderArray = [NSMutableArray arrayWithArray:imageArray];
        _photoMaxCount = count;
        _spaceOfLine = spaceOfLine;
        
        if (array.count > 0) {
            for (int i = 0; i < array.count; i++) {
                UIImage *image = array[i];
                NSData *imageData = UIImagePNGRepresentation(image);
                NSInteger length = [imageData length]/1024;
                [self.selectImageMubArray addObject:image];
                [self.imageSizeArray addObject:[NSString stringWithFormat:@"%ld",(long)length]];
                [self.imageFileNameArray addObject:[self getPhotoName]];
                [self.imageUserNameArray addObject:[self getPhotoName]];
            }
        }
        
        [self setUI];
    }
    return self;
}

- (void)reloadWithImageArray:(NSMutableArray *)array {
    
    [self.selectImageMubArray removeAllObjects];
    for (int i = 0; i < array.count; i++) {
        [self.selectImageMubArray addObject:array[i]];
    }
    [self.shareImageCollectionView reloadData];
}

#pragma mark - 懒加载

- (UICollectionViewFlowLayout *)layout {
    
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.minimumLineSpacing = _spaceOfLine;
        _layout.minimumInteritemSpacing = _spaceOfLine;
    }
    return _layout;
}

- (UICollectionView *)shareImageCollectionView {
    
    if (!_shareImageCollectionView) {
        _shareImageCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _shareImageCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _shareImageCollectionView.delegate = self;
        _shareImageCollectionView.dataSource = self;
        _shareImageCollectionView.scrollEnabled = NO;
        _shareImageCollectionView.backgroundColor = [UIColor whiteColor];
        [_shareImageCollectionView registerClass:[ShareImageCollectionCell class] forCellWithReuseIdentifier:shareImageCellID];
    }
    return _shareImageCollectionView;
}

- (NSMutableArray *)placeholderArray {
    
    if (!_placeholderArray) {
        _placeholderArray = [[NSMutableArray alloc]init];
    }
    return _placeholderArray;
}

- (NSMutableArray *)selectImageMubArray {
    
    if (!_selectImageMubArray) {
        _selectImageMubArray = [[NSMutableArray alloc]init];
    }
    return _selectImageMubArray;
}

- (NSMutableArray *)imageFileNameArray {
    
    if (!_imageFileNameArray) {
        _imageFileNameArray = [[NSMutableArray alloc]init];
    }
    return _imageFileNameArray;
}

- (NSMutableArray *)imageSizeArray {
    
    if (!_imageSizeArray) {
        _imageSizeArray = [[NSMutableArray alloc]init];
    }
    return _imageSizeArray;
}

- (NSMutableArray *)imageUserNameArray {
    
    if (!_imageUserNameArray) {
        _imageUserNameArray = [[NSMutableArray alloc]init];
    }
    return _imageUserNameArray;
}

- (NSMutableArray *)MWPhotoArray {
    
    if (!_MWPhotoArray) {
        _MWPhotoArray = [[NSMutableArray alloc]init];
    }
    return _MWPhotoArray;
}

#pragma mark - 设置UI

- (void)setUI {
    
    //首次添加时默认高度为0
    [self addSubview:self.shareImageCollectionView];
    [self.shareImageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(self.spaceOfLine);
        make.right.equalTo(self.mas_right).offset(-self.spaceOfLine);
    }];
}

#pragma mark - CollectionViewDelegate && DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.selectImageMubArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ShareImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shareImageCellID forIndexPath:indexPath];
    cell.deleteImgBtn.hidden = YES;
    
    cell.deleteImgBtn.hidden = NO;
    cell.deleteImgBtn.tag = indexPath.item;
    cell.delegate = self;
    cell.imageV.contentMode = UIViewContentModeScaleToFill;
    [self setCellImageViewWithCell:cell image:self.selectImageMubArray[indexPath.item]];
    return cell;
}

- (void)setCellImageViewWithCell:(ShareImageCollectionCell *)cell image:(id)image {
    
    if ([[image class] isSubclassOfClass:[NSString class]]) {
        //传入的是图片名称
        cell.imageV.image = [UIImage imageNamed:image];
    }else if ([[image class] isSubclassOfClass:[NSURL class]]){
        //传入的是图片的URL地址
        [cell.imageV sd_setImageWithURL:image placeholderImage:[UIImage imageNamed:@"mine_download_video_default_img"]];
    }else if ([[image class] isSubclassOfClass:[UIImage class]]){
        //传入的是图片
        cell.imageV.image = image;
    }else {
        //传入的是压缩的图片
        cell.imageV.image = [UIImage imageWithData:image];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //否则浏览图片
    if (self.MWPhotoArray.count > 0 ) {
        [self.MWPhotoArray removeAllObjects];
    }
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self.shareImageCollectionView; // 原图的父控件
    browser.imageCount = self.selectImageMubArray.count; // 图片总数
    browser.currentImageIndex = indexPath.item;
    browser.delegate = self;
    [browser show];
}

#pragma mark - flowLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return _itemSize;
}
//cell的代理方法
- (void)deleteImageWithButton:(UIButton *)btn {
    
    [self.selectImageMubArray removeObjectAtIndex:btn.tag];
    [self.imageUserNameArray removeObjectAtIndex:btn.tag];
    [self.imageFileNameArray removeObjectAtIndex:btn.tag];
    [self.imageSizeArray removeObjectAtIndex:btn.tag];

    self.selectImageBlock(self.selectImageMubArray,self.imageFileNameArray,self.imageSizeArray,self.imageUserNameArray);
    [self.shareImageCollectionView reloadData];
}

#pragma mark - photobrowser代理方法
// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    //    return nil;
    ShareImageCollectionCell *cell = (ShareImageCollectionCell *)[self collectionView:self.shareImageCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    return cell.imageV.image;
}

//返回高质量图片的URL
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    
    //    return self.imageArray[index];
    return nil;
}

#pragma mark - 拍照方法
- (void)takePhoto {
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
 
}

- (void)addPhoto {
    
    WSelectPhotoPickerViewController *pickerVc = [[WSelectPhotoPickerViewController alloc] init];
    //跳转到相册界面
  
    // 默认显示相册里面的内容SavePhotos
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.minCount = _photoMaxCount - _selectImageMubArray.count;
    
    __weak __typeof(self)weakSelf = self;
    pickerVc.callBack = ^(NSArray *assets){
        for (WSelectPhotoAssets *ass in assets) {

            if (weakSelf.selectImageMubArray.count > _photoMaxCount - 1) {
                break;
            }
            [weakSelf.selectImageMubArray addObject:ass.originImage];
            [weakSelf.imageFileNameArray addObject:ass.fileName];
            [weakSelf.imageSizeArray addObject:[NSString stringWithFormat:@"%f",ass.fileSize]];
            [weakSelf.imageUserNameArray addObject:[self getPhotoName]];
        }
        //改变photo所在的view以及显示选择的照片
        weakSelf.selectImageBlock(weakSelf.selectImageMubArray,weakSelf.imageFileNameArray,weakSelf.imageSizeArray,weakSelf.imageUserNameArray);
        //刷新界面
        [weakSelf.shareImageCollectionView reloadData];
    };
    pickerVc = nil;
}

#pragma mark - 拍照方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //获取image
    UIImage *selectImage=[info objectForKey:UIImagePickerControllerOriginalImage];
    selectImage = [self fixOrientation:selectImage];
    NSData *imageData = UIImagePNGRepresentation(selectImage);
    NSInteger length = [imageData length]/1024;
    
    [self.selectImageMubArray addObject:selectImage];
    [self.imageFileNameArray addObject:[self getPhotoName]];
    [self.imageUserNameArray addObject:[self getPhotoName]];
    [self.imageSizeArray addObject:[NSString stringWithFormat:@"%ld",length]];
    
    //改变photo所在的view以及显示选择的照片
    self.selectImageBlock(self.selectImageMubArray,self.imageFileNameArray,self.imageSizeArray,self.imageUserNameArray);
    [self.shareImageCollectionView reloadData];
    
    if (self.dismissBlock) {
        self.dismissBlock(nil);
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    if (self.dismissBlock) {
        self.dismissBlock(nil);
    }
}

#pragma mark - 以时间戳去命名拍照图片的名字
- (NSString *)getPhotoName {
    
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970] * 1000;  //  *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%f", a]; //转为字符型
    NSString *phName = [self md5:timeString];
    phName = [NSString stringWithFormat:@"%@.png",phName];
    return phName;
}
-(NSString *)md5:(NSString *)inPutText {
    
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
#pragma mark - 图片压缩
- (NSData *)compressImage:(UIImage *)image {
    
    NSUInteger maxFileSize = FILE_MAXSIZE;
    NSData *originImageData = UIImagePNGRepresentation(image);
    NSInteger length = [originImageData length]/1024;
    if (length < maxFileSize) {
        return originImageData;
    } else {
        CGFloat compressionRatio = 0.7f;
        CGFloat maxCompressionRatio = 0.1f;
        NSData *imageData = UIImageJPEGRepresentation(image, compressionRatio);
        
        while (imageData.length > maxFileSize && compressionRatio > maxCompressionRatio) {
            compressionRatio -= 0.1f;
            imageData = UIImageJPEGRepresentation(image, compressionRatio);
        }
        return imageData;
    }
}
#pragma mark - 旋转90度
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp) return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma mark - setMethod
- (void)setPhotoMaxCount:(NSInteger)photoMaxCount {
    _photoMaxCount = photoMaxCount;
}

@end
