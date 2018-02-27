//
//  ScrollViewDemoViewController.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2018/2/27.
//  Copyright © 2018年 思 彭. All rights reserved.
//

#import "ScrollViewDemoViewController.h"

@interface ScrollViewDemoViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIView *pictureView;
@property (nonatomic, strong) UIView *videoView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, weak) UIButton *picButton;
@property (nonatomic, weak) UIButton *videoButton;

@end

@implementation ScrollViewDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"scrollView切换视图";
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 300)];
    self.scrollView.contentSize = CGSizeMake(K_SCREEN_WIDTH * 2, 300);
    self.scrollView.delegate = self;
    self.scrollView.bounces = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.pictureView];
    [self.scrollView addSubview:self.videoView];
    
    // 两个按钮
    UIButton *PicButton = [UIButton buttonWithType: UIButtonTypeCustom];
    PicButton.tag = 100;
    PicButton.frame = CGRectMake(70, (300 - 44) / 2, 60, 44);
    PicButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    PicButton.layer.borderWidth = 0.5;
    [PicButton setTitle:@"图片" forState:UIControlStateNormal];
    [PicButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    PicButton.titleLabel.font = FONT_14;
    PicButton.backgroundColor = [UIColor orangeColor];
    [PicButton addTarget:self action:@selector(buttonDidChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:PicButton];
    self.picButton = PicButton;
    
    UIButton *videoutton = [UIButton buttonWithType: UIButtonTypeCustom];
    videoutton.tag = 101;
    videoutton.frame = CGRectMake(150, (300 - 44) / 2, 60, 44);
    videoutton.backgroundColor = [UIColor whiteColor];
    [videoutton setTitle:@"视频" forState:UIControlStateNormal];
    [videoutton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    videoutton.titleLabel.font = FONT_14;
    [videoutton addTarget:self action:@selector(buttonDidChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:videoutton];
    self.videoButton = videoutton;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat index = scrollView.contentOffset.x / K_SCREEN_WIDTH;
    if (index == 0) {
       // 图片
        self.picButton.backgroundColor = [UIColor orangeColor];
        self.videoButton.backgroundColor = [UIColor whiteColor];
    } else {
        // 视频
        self.videoButton.backgroundColor = [UIColor orangeColor];
        self.picButton.backgroundColor = [UIColor whiteColor];
    }
    
}

- (void)buttonDidChange: (UIButton *)button {
    switch (button.tag) {
        case 100:
        {
            
        }
            break;
        case 101:
        {
            
        }
            break;
        default:
            break;
    }
}

- (UIView *)pictureView {
    if (!_pictureView) {
        _pictureView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 300)];
        _pictureView.backgroundColor = [UIColor redColor];
    }
    return _pictureView;
}

- (UIView *)videoView {
    if (!_videoView) {
        _videoView = [[UIView alloc]initWithFrame:CGRectMake(K_SCREEN_WIDTH, 0, K_SCREEN_WIDTH, 300)];
        _videoView.backgroundColor = [UIColor greenColor];
    }
    return _videoView;
}

@end
