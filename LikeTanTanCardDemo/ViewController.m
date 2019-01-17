//
//  ViewController.m
//  LikeTanTanCardDemo
//
//  Created by sunhongfu on 2018/9/17.
//  Copyright © 2018年 sunhongfu. All rights reserved.
//

#import "ViewController.h"
#import "SHFBaseTableView.h"
#import "SHFTopCardBannerView.h"
#import "SHFTableHeaderView.h"
@interface ViewController ()<SHFTopCardBannerViewDelegate,SHFTableHeaderViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) SHFBaseTableView *myTableView;
@property (nonatomic,strong) SHFTableHeaderView *tableHeaderView;
@property (nonatomic, strong) NSMutableArray *pictureUrlArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadSubview];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"indexPath = %ld--%ld",(long)indexPath.section,(long)indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark - SHFTopCardBannerViewDelegate
- (void)clickCurrentViewWithIndex:(NSInteger)index
{
    NSLog(@"点击了%ld",(long)index);
}

#pragma mark - Private

- (void)loadSubview
{
    [self.view addSubview:self.myTableView];
}

#pragma mark - Getter

-(NSMutableArray *)pictureUrlArray
{
    if (!_pictureUrlArray) {
        _pictureUrlArray  = [[NSMutableArray alloc] initWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg", nil];
    }
    return _pictureUrlArray;
}

- (SHFBaseTableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[SHFBaseTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.tableHeaderView = self.tableHeaderView;
        _myTableView.delaysContentTouches = YES;
        _myTableView.canCancelContentTouches = NO;
    }
    return _myTableView;
}

- (SHFTableHeaderView *)tableHeaderView
{
    if (!_tableHeaderView) {
        _tableHeaderView = [[SHFTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 500) withTableView:self.myTableView];
        _tableHeaderView.delegate = self;
        _tableHeaderView.bannerDataArray = self.pictureUrlArray;
    }
    return _tableHeaderView;
}

@end
