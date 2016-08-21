//
//  RSideMainController.m
//  LeftSide
//
//  Created by Rockey on 16/8/21.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "RSideMainController.h"

@interface RSideMainController ()

/** 展示 左侧 */
@property (nonatomic, assign)  BOOL toLeft;

@end

@implementation RSideMainController
- (void)leftBarAction:(UIButton *)sender {
    
    _toLeft = !_toLeft;
    if (_delegate && [_delegate respondsToSelector:@selector(RSideMainControllerLeftBar:toLeft:)]) {
        __weak id weakSelft = self;
        [_delegate RSideMainControllerLeftBar:weakSelft toLeft:_toLeft];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Main2313";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blueColor]};
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [button setTitle:@"ToLeft" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self action:@selector(leftBarAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setRSideToLeft:(BOOL)toLeft {
    _toLeft = toLeft;
}

@end
