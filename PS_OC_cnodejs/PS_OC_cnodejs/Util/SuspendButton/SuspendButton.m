//
//  SuspendButton.m
//  QianfengSchool
//
//  Created by AlicePan on 16/7/12.
//  Copyright © 2016年 Combanc. All rights reserved.
//

#import "SuspendButton.h"

@implementation SuspendButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
//    self.backgroundColor = QF_BLUE;
//    self.alpha = 0.8;
    [self setTitle:@"" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"interaction_add_icon"] forState:UIControlStateNormal];
    [self addTarget:self action:@selector(suspendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = ADD_BTN_WIDTH/2;
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:panGes];
}

- (void)panGesture:(UIGestureRecognizer *)gesture {
    
    CGPoint point = [gesture locationInView:self.superview];
    self.center = point;
    CGRect rect = self.frame;
    if (self.center.x < SCREEN_WIDTH - 100) {
        rect.origin.x = SCREEN_WIDTH - 100 - self.frame.size.width/2;
    }
    if (self.center.y < SCREEN_HEIGHT - 200) {
        rect.origin.y = SCREEN_HEIGHT - 200 - self.frame.size.width/2;
    }
    self.frame = rect;
}

- (void)suspendBtnClick {
    if (_suspendBtnClicked) {
        _suspendBtnClicked();
    }
}


@end
