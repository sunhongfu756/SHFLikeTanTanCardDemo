//
//  SHFTableHeaderView.h
//  LikeTanTanCardDemo
//
//  Created by sunhongfu on 2018/9/17.
//  Copyright © 2018年 sunhongfu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHFTopCardBannerView.h"

@protocol SHFTableHeaderViewDelegate <NSObject>

@end

@interface SHFTableHeaderView : UIView

@property (nonatomic,strong) NSMutableArray *bannerDataArray;
@property (nonatomic,weak) id<SHFTableHeaderViewDelegate> delegate;
@property (nonatomic,strong) SHFTopCardBannerView *bannerView;
- (id)initWithFrame:(CGRect)frame withTableView:(UITableView *)tableview;

@end
