//
//  ViewController.m
//  UNLock
//
//  Created by mika on 2017/12/22.
//  Copyright © 2017年 mika. All rights reserved.
//

#import "ViewController.h"
#import "GesView.h"
@interface ViewController ()
@property (nonatomic, strong) GesView *gesView;
@property (nonatomic, strong) UILabel *passWordLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.passWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 80, self.view.frame.size.width-100, 40)];
    self.passWordLabel.textAlignment = NSTextAlignmentCenter;
    self.passWordLabel.textColor = [UIColor whiteColor];
    self.passWordLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.passWordLabel.layer.borderWidth = 0.5;
    self.passWordLabel.backgroundColor = [UIColor grayColor];
    self.passWordLabel.text = @"请绘制手势";
    [self.view addSubview:self.passWordLabel];
    
    self.gesView = [[GesView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, self.view.frame.size.width-20)];
    self.gesView.backgroundColor = [UIColor orangeColor];
    self.gesView.center =self.view.center;
    __weak typeof(self) weakSelf = self;
    [self.gesView setCompleteBlock:^(NSString *passWord) {
        weakSelf.passWordLabel.text = passWord;
    }];
    [self.view addSubview:self.gesView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
