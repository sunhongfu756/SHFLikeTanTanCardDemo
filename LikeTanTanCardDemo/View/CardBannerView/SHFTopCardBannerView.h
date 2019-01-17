//
//  SHFTopCardBannerView.h
//  LikeTanTanCardDemo
//
//  Created by sunhongfu on 2018/9/17.
//  Copyright © 2018年 sunhongfu. All rights reserved.
//

//控件x坐标
#define kFirstViewFrameX 15
//控件y坐标
#define kFirstPicFrameY 0
//touch拖动范围
#define kBeginPtYRange _beginPt.y>kFirstPicFrameY&&_beginPt.y<CGRectGetMaxY(_currentView.frame)
//宽度
#define kWidth self.frame.size.width
//高度
#define kHeight 320*SCREEN_WIDTHRATIO
//图片之间间隔距离
#define kImgViewRange 5
//当前页面的控件个数
#define kCurrentViewNum 3

//右边移除到中心点
#define kRemoveRightX kWidth+_currentView.frame.size.width
//左边移除到中心点
#define kRemoveLeftX 0-_currentView.frame.size.width
#import <UIKit/UIKit.h>
#import "SHFCardView.h"

@protocol SHFTopCardBannerViewDelegate <NSObject>

@optional
- (void)clickCurrentViewWithIndex:(NSInteger)index;

@end

@interface SHFTopCardBannerView : UIView
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong)id<SHFTopCardBannerViewDelegate> delegate;

@end
