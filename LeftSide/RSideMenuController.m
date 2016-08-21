//
//  RSideMenuController.m
//  LeftSide
//
//  Created by Rockey on 16/8/21.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "RSideMenuController.h"
#import "UIView+Extention.h"
#define kBackgroundColor [UIColor colorWithRed:13.f / 255.f green:184.f / 255.f blue:246.f / 255.f alpha:1]
@interface RSideMenuController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSDictionary *>*dataArray;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation RSideMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"menu";
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = kBackgroundColor;
    self.dataArray = @[@{@"img":[UIImage imageNamed:@"sidebar_business"], @"title":@"我的商城"},
                       @{@"img":[UIImage imageNamed:@"sidebar_purse"], @"title":@"QQ钱包"},
                       @{@"img":[UIImage imageNamed:@"sidebar_decoration"], @"title":@"个性装扮"},
                       @{@"img":[UIImage imageNamed:@"sidebar_favorit"], @"title":@"我的收藏"},
                       @{@"img":[UIImage imageNamed:@"sidebar_album"], @"title":@"我的相册"},
                       @{@"img":[UIImage imageNamed:@"sidebar_file"], @"title":@"我的文件"}];
    self.tableView.tableHeaderView = self.imageView;
    self.tableView.tableFooterView = [UIView new];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.imageView.image = self.dataArray[indexPath.row][@"img"];
    cell.textLabel.text = self.dataArray[indexPath.row][@"title"];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = false;
    }
    return _tableView;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 280)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.image = [UIImage imageNamed:@"sidebar_bg"];
        _imageView.clipsToBounds = YES;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header"]];
        imageView.size = CGSizeMake(60, 60);
        imageView.left = 25;
        imageView.top = 64;
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = imageView.width / 2;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 2.f;
        [_imageView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 30, imageView.top + 10, 100, 20)];
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont boldSystemFontOfSize:20];
        label.text = @"taotao";
        [_imageView addSubview:label];
    }
    return _imageView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
