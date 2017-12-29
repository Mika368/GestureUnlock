//
//  GesView.m
//  UNLock
//
//  Created by mika on 2017/12/22.
//  Copyright © 2017年 mika. All rights reserved.
//

#import "GesView.h"
@interface GesView ()
@property (nonatomic, assign) CGPoint currentPoint;
@property (nonatomic, strong) NSMutableArray *buttonsArray;
@property (nonatomic, strong) NSMutableArray *selectedButtonsArray;
@end
@implementation GesView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonsArray = [NSMutableArray array];
        self.selectedButtonsArray = [NSMutableArray array];
        self.userInteractionEnabled = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:pan];
        [self initsubViews];
    }
    return self;
}

- (void)initsubViews {
    CGFloat margin = self.frame.size.width/10.0;
    CGFloat btnW = margin*2;
    
    for (int i = 0; i < 9; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1001+i;
        button.frame = CGRectMake(margin+(btnW+margin)*(i%3),margin+(btnW+margin)*(i/3),btnW,btnW);
        [button setTitle:@"🔘" forState:UIControlStateNormal];
        [button setTitle:@"㊙️" forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self addSubview:button];
        [self.buttonsArray addObject:button];
    }
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    self.currentPoint = [pan locationInView:self];
    [self setNeedsDisplay];
    for (UIButton *btn in self.buttonsArray) {
        if (CGRectContainsPoint(btn.frame, self.currentPoint)&&btn.isSelected == NO) {
            btn.selected = YES;
            [self.selectedButtonsArray addObject:btn];
        }
    }
    [self setNeedsLayout];
    if (pan.state == UIGestureRecognizerStateEnded) {
        NSString *passWord = @"";
        for (UIButton *button in self.selectedButtonsArray) {
            passWord = [passWord stringByAppendingString:[NSString stringWithFormat:@"%ld",button.tag-1000]];
            button.selected = NO;
        }
        [self.selectedButtonsArray removeAllObjects];
        if (self.completeBlock) {
            self.completeBlock(passWord);
        }
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.selectedButtonsArray.count == 0) {
        return;
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < self.selectedButtonsArray.count; i++) {
        UIButton *button = self.selectedButtonsArray[i];
        if (i==0) {
            [path moveToPoint:button.center];
        }else{
            [path addLineToPoint:button.center];
        }
    }
    [path addLineToPoint:self.currentPoint];
    [[UIColor blueColor] set];
    [path setLineWidth:5];
    path.lineJoinStyle = kCGLineJoinRound;//终点处理
    path.lineCapStyle = kCGLineCapRound;//线条拐角
    [path stroke];
}

@end
