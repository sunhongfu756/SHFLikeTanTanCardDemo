//
//  SHFTableHeaderView.m
//  LikeTanTanCardDemo
//
//  Created by sunhongfu on 2018/9/17.
//  Copyright © 2018年 sunhongfu. All rights reserved.
//

#import "SHFTableHeaderView.h"
@interface SHFTableHeaderView ()<SHFTopCardBannerViewDelegate>

@property (nonatomic,weak) UITableView *tabelView;
@end

@implementation SHFTableHeaderView

- (id)initWithFrame:(CGRect)frame withTableView:(UITableView *)tableview
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tabelView = tableview;
        [self loadSubview];
    }
    return self;
}

- (void)loadSubview
{
    [self addSubview:self.bannerView];
    self.frame = CGRectMake(0, 0, self.frame.size.width, CGRectGetMaxY(self.bannerView.frame) +40);
}

- (void)setBannerDataArray:(NSMutableArray *)bannerDataArray
{
    _bannerDataArray = bannerDataArray;
    _bannerView.dataArray = _bannerDataArray;
}

- (void)setDelegate:(id<SHFTableHeaderViewDelegate>)delegate
{
    _delegate = delegate;
    self.bannerView.delegate = (id <SHFTopCardBannerViewDelegate>) delegate;
}

#pragma mark - LYTopCardBannerViewDelegate
- (void)clickCurrentViewWithIndex:(NSInteger)index
{
    
}

#pragma mark - Getter
- (SHFTopCardBannerView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [[SHFTopCardBannerView alloc] initWithFrame:CGRectMake(0, StatusBarHeight + (75), SCREEN_WIDTH, 320*SCREEN_WIDTHRATIO + 20)];
        _bannerView.tableView = _tabelView;
    }
    return _bannerView;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
