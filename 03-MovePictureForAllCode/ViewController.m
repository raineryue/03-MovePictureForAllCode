//
//  ViewController.m
//  03-MovePictureForAllCode
//
//  Created by Rainer on 15/11/11.
//  Copyright © 2015年 Rainer. All rights reserved.
//

#import "ViewController.h"

typedef enum {
    DirectionButtonUp = 10,
    DirectionButtonDown,
    DirectionButtonLeft,
    DirectionButtonRight
} DirectionButton;

#define kDirectionDelta 20

@interface ViewController ()

/** 被操纵的图像按钮 */
@property (nonatomic, weak) UIButton *iconButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1.设置被操纵的图像按钮
    [self iconButton];
    
    // 2.设置上下左右按钮
    [self setupDirectionButtons];
    
    // 3.设置放大缩小按钮
    [self setupScaleButtons];
    
    // 4.设置左右旋转按钮
    [self setupRotateButtons];
}

/**
 *  设置被操纵的图像按钮
 */
- (UIButton *)iconButton {
    if (nil == _iconButton) {
        // 1.创建并设置位置
        CGFloat iconButtonW = 150;
        CGFloat iconButtonH = 150;
        CGFloat iconButtonX = (self.view.bounds.size.width - iconButtonW) * 0.5;
        CGFloat iconButtonY = 100;
        
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(iconButtonX, iconButtonY, iconButtonW, iconButtonH)];
        
        // 2.设置背景图片
        [iconButton setBackgroundImage:[UIImage imageNamed:@"btn_01"] forState:UIControlStateNormal];
        [iconButton setBackgroundImage:[UIImage imageNamed:@"btn_02"] forState:UIControlStateHighlighted];
        
        // 3.设置文字
        [iconButton setTitle:@"摸我啊" forState:UIControlStateNormal];
        [iconButton setTitle:@"摸我干啥" forState:UIControlStateHighlighted];
        
        // 4.设置文字颜色
        [iconButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [iconButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        
        // 5.设置文字内容对齐方式
        iconButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        
        _iconButton = iconButton;
        
        // 6.将按钮添加到试图上
        [self.view addSubview:_iconButton];
    }
    
    return _iconButton;
}

/**
 *  设置上下左右按钮
 */
- (void)setupDirectionButtons {
    // 1.向上按钮
    UIButton *upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    upButton.frame = CGRectMake(50, self.view.bounds.size.height - 150, 30, 30);
    [upButton setBackgroundImage:[UIImage imageNamed:@"top_normal"] forState:UIControlStateNormal];
    [upButton setBackgroundImage:[UIImage imageNamed:@"top_highlighted"] forState:UIControlStateHighlighted];
    [upButton addTarget:self action:@selector(directionButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    upButton.tag = DirectionButtonUp;
    [self.view addSubview:upButton];
    
    // 1.向下按钮
    UIButton *downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    downButton.frame = CGRectMake(50, self.view.bounds.size.height - 50, 30, 30);
    [downButton setBackgroundImage:[UIImage imageNamed:@"bottom_normal"] forState:UIControlStateNormal];
    [downButton setBackgroundImage:[UIImage imageNamed:@"bottom_highlighted"] forState:UIControlStateHighlighted];
    [downButton addTarget:self action:@selector(directionButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    downButton.tag = DirectionButtonDown;
    [self.view addSubview:downButton];
    
    // 1.向左按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(10, self.view.bounds.size.height - 100, 30, 30);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"left_normal"] forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"left_highlighted"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(directionButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.tag = DirectionButtonLeft;
    [self.view addSubview:leftButton];
    
    // 1.向右按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(90, self.view.bounds.size.height - 100, 30, 30);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"right_normal"] forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"right_highlighted"] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(directionButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.tag = DirectionButtonRight;
    [self.view addSubview:rightButton];
}

/**
 *  设置放大缩小按钮
 */
- (void)setupScaleButtons {
    // 1.放大按钮
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    plusButton.frame = CGRectMake(self.view.bounds.size.width - 110, self.view.bounds.size.height - 150, 30, 30);
    [plusButton setBackgroundImage:[UIImage imageNamed:@"plus_normal"] forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageNamed:@"plus_highlighted"] forState:UIControlStateHighlighted];
    [plusButton addTarget:self action:@selector(scaleButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    plusButton.tag = 1;
    [self.view addSubview:plusButton];
    
    // 1.缩小按钮
    UIButton *minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    minusButton.frame = CGRectMake(self.view.bounds.size.width - 40, self.view.bounds.size.height - 150, 30, 30);
    [minusButton setBackgroundImage:[UIImage imageNamed:@"minus_normal"] forState:UIControlStateNormal];
    [minusButton setBackgroundImage:[UIImage imageNamed:@"minus_highlighted"] forState:UIControlStateHighlighted];
    [minusButton addTarget:self action:@selector(scaleButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    minusButton.tag = 0;
    [self.view addSubview:minusButton];
}

/**
 *  设置左右旋转按钮
 */
- (void)setupRotateButtons {
    // 1.左旋按钮
    UIButton *leftRotateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftRotateButton.frame = CGRectMake(self.view.bounds.size.width - 110, self.view.bounds.size.height - 50, 30, 30);
    [leftRotateButton setBackgroundImage:[UIImage imageNamed:@"left_rotate_normal"] forState:UIControlStateNormal];
    [leftRotateButton setBackgroundImage:[UIImage imageNamed:@"left_rotate_highlighted"] forState:UIControlStateHighlighted];
    [leftRotateButton addTarget:self action:@selector(rotateButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    leftRotateButton.tag = 1;
    [self.view addSubview:leftRotateButton];
    
    // 1.右旋按钮
    UIButton *rightRotateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightRotateButton.frame = CGRectMake(self.view.bounds.size.width - 40, self.view.bounds.size.height - 50, 30, 30);
    [rightRotateButton setBackgroundImage:[UIImage imageNamed:@"right_rotate_normal"] forState:UIControlStateNormal];
    [rightRotateButton setBackgroundImage:[UIImage imageNamed:@"right_rotate_highlighted"] forState:UIControlStateHighlighted];
    [rightRotateButton addTarget:self action:@selector(rotateButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    rightRotateButton.tag = 0;
    [self.view addSubview:rightRotateButton];
}

#pragma mark - 按钮监听事件

/**
 *  按钮移动事件处理
 */
- (void)directionButtonClickAction:(UIButton *)button {
    // 1.申明并初始化方向上的直
    CGFloat dx = 0,dy = 0;
    
    // 2.判断是什么方向上的操作：（Y：上下，X：左右）
    if (DirectionButtonUp == button.tag || DirectionButtonDown == button.tag) {
        dy = (DirectionButtonUp == button.tag) ? -kDirectionDelta : kDirectionDelta;
    }
    
    if (DirectionButtonLeft == button.tag || DirectionButtonRight == button.tag) {
        dx = (DirectionButtonLeft == button.tag) ? -kDirectionDelta : kDirectionDelta;
    }
    
    // 3.添加首尾式动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    
    // 4.改变位移属性
    self.iconButton.transform = CGAffineTransformTranslate(self.iconButton.transform, dx, dy);

    [UIView commitAnimations];
}

/**
 *  放大缩小按钮事件处理
 */
- (void)scaleButtonClickAction:(UIButton *)button {
    // 1.定义放大缩小的比例
    CGFloat scaleDelta = (button.tag) ? 1.2 : 0.8;
    
    // 2.添加首尾式动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    
    // 3.改变形变属性
    self.iconButton.transform = CGAffineTransformScale(self.iconButton.transform, scaleDelta, scaleDelta);
    
    [UIView commitAnimations];
}

/**
 *  左右旋转按钮事件处理
 */
- (void)rotateButtonClickAction:(UIButton *)button {
    // 1.定义并初始化旋转的弧度值
    CGFloat angleDelta =  (button.tag) ? -M_PI_4 : M_PI_4;
    
    // 2.添加首尾式动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    
    // 3.改变形变属性（弧度）
    self.iconButton.transform = CGAffineTransformRotate(self.iconButton.transform, angleDelta);
    
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
