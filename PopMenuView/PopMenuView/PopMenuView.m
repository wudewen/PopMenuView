//
//  PopMenuView.m
//  PopMenuView
//
//  Created by 吴德文 on 2019/8/8.
//  Copyright © 2019 Shanutec. All rights reserved.
//

#import "PopMenuView.h"

#define ItemW (SCREEN_WIDTH - kScaleFit(15*2))/4
#define ItemH kScaleFit(100)

@interface PopMenuView ()

@property (nonatomic, copy) void (^blockTapAction)(NSInteger index);

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imgNameArray;

@property (nonatomic ,strong) UIView *contentView;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@end


@implementation PopMenuView

+(void)showPopMenuView:(NSArray *)titleArray imgNameArray:(NSArray *)imgNameArray blockTapAction:(void(^) (NSInteger index))blockTapAction
{
    PopMenuView *popMenuView = [[PopMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    popMenuView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    popMenuView.alpha = 0;
    popMenuView.titleArray = titleArray;
    popMenuView.imgNameArray = imgNameArray;
    popMenuView.blockTapAction = blockTapAction;
    [[UIApplication sharedApplication].keyWindow addSubview:popMenuView];
    
    [popMenuView bulidContentView];
    
    [popMenuView show];
    
    [popMenuView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:popMenuView action:@selector(dismiss)]];
}

#pragma mark - 显示弹出框
-(void)show
{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.alpha = 1;
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -self.contentView.bounds.size.height);
    }];
}

#pragma mark - 创建视图
-(void)bulidContentView
{
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,kScaleFit(30) + ((self.titleArray.count-1)/4+1) * kScaleFit(100) + kScaleFit(50))];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(kScaleFit(20), kScaleFit(20))];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = KWhiteColor.CGColor;
    [self.contentView.layer addSublayer:shapeLayer];
    [self addSubview:self.contentView];
    
    [self bulidButton];
    
    [self bulidCancle];
}

#pragma mark - 创建按钮
-(void)bulidButton
{
    self.buttonArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.titleArray.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.frame = CGRectMake(kScaleFit(15) + i%4*ItemW, kScaleFit(10) + i/4*ItemH, ItemW, ItemH);
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0.46f green:0.50f blue:0.54f alpha:1.00f] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.imgNameArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        
        // button标题/图片的偏移量
        button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView.bounds.size.height + kScaleFit(10), -button.imageView.bounds.size.width, 0,0);
        button.imageEdgeInsets = UIEdgeInsetsMake(kScaleFit(5), button.titleLabel.bounds.size.width/2, button.titleLabel.bounds.size.height + kScaleFit(5), -button.titleLabel.bounds.size.width/2);
        [self.buttonArray addObject:button];
        
        button.alpha = 0;
        button.transform = CGAffineTransformMakeTranslation(0, self.contentView.bounds.size.height);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self showButton];
    });
}

#pragma mark - 取消按钮
- (void)bulidCancle
{
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(0, self.contentView.bounds.size.height - kScaleFit(50), self.contentView.bounds.size.width, kScaleFit(50));
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor colorWithRed:0.22f green:0.69f blue:0.99f alpha:1.00f] forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, cancleButton.bounds.size.width, 1);
    layer.backgroundColor = [UIColor colorWithRed:0.98f green:0.98f blue:0.98f alpha:1.00f].CGColor;
    [cancleButton.layer addSublayer:layer];
    
    [self.contentView addSubview:cancleButton];
}

#pragma mark - 按钮点击事件
- (void)tapAction:(UIButton *)button
{
    [self dismiss];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.blockTapAction)
        {
            self.blockTapAction(button.tag);
        }
    });
}

#pragma mark - 按钮动画效果
- (void)showButton
{
    for (int i = 0; i < self.buttonArray.count; i++) {
        
        UIButton *button = self.buttonArray[i];
        
        [UIView animateWithDuration:0.7 delay:i*0.05 - i/4*0.2 usingSpringWithDamping:0.7 initialSpringVelocity:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            button.alpha = 1;
            button.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark - 视图退出
- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.alpha = 0;
        self.contentView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

@end
