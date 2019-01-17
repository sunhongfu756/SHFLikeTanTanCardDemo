//
//  SHFTopCardBannerView.m
//  LikeTanTanCardDemo
//
//  Created by sunhongfu on 2018/9/17.
//  Copyright © 2018年 sunhongfu. All rights reserved.
//

#import "SHFTopCardBannerView.h"

@interface SHFTopCardBannerView ()<UIGestureRecognizerDelegate>
{
    NSInteger _currentIndex;
    CGFloat _beginTimeStamp;
    CGPoint _beginPt;
    CGPoint _currentImgCenter;
    SHFCardView *_currentView;
    UIView *_needRemoveView;
    BOOL _moveYes;
    
    NSMutableArray *_picViewArray;
}
@end

@implementation SHFTopCardBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentIndex = 0;
        _dataArray = [NSMutableArray array];
        _picViewArray = [NSMutableArray array];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    if (_dataArray.count > 1 && _dataArray.count < 3) {
        [_dataArray addObjectsFromArray:dataArray];
    }
    
    for (SHFCardView *view in _picViewArray) {
        [view removeFromSuperview];
    }
    [_picViewArray removeAllObjects];
    [self createView];
}

#pragma mark - -
- (void)createView
{
    NSInteger picCount;
    if (_dataArray.count<kCurrentViewNum) {
        picCount = _dataArray.count;
    }else{
        picCount = kCurrentViewNum;
    }
    
    for (int i = 0; i<picCount; i++) {
        SHFCardView *view = [self addVIewWithFrame:
                             CGRectMake(
                                        kFirstViewFrameX+i*kImgViewRange*3,
                                        kFirstPicFrameY + i*kImgViewRange*4,
                                        kWidth-kFirstViewFrameX*2-i*kImgViewRange*2*3,
                                        kHeight-i*kImgViewRange*2)
                                    andWithdataNum:i];
        [self insertSubview:view atIndex:0];
        if (i == 0) {
            view.imgview.alpha = 1;
        }
        [_picViewArray addObject:view];
        
        if (i == 0) {
            _currentView = _picViewArray[0];
            _currentImgCenter = _currentView.center;
        }
    }
}

#pragma mark - 创建
- (SHFCardView *)addVIewWithFrame:(CGRect)frame andWithdataNum:(NSInteger)dataNum
{
    SHFCardView *cardView = [[SHFCardView alloc] initWithFrame:frame];
    cardView.cardBannerUrl = _dataArray[dataNum];
    
    return cardView;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    // 如果在当前 view 中 直接返回 self 这样自身就成为了第一响应者 subViews 不再能够接受到响应事件
    if ([self pointInside:point withEvent:event]) {
        return self;
    }
    return nil;
}

#pragma mark - 触摸开始
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1张禁止滑动
    //    if (_dataArray.count == 1) {
    //        return;
    //    }
    NSLog(@"touchesBegan------");
    self.tableView.scrollEnabled = NO;
    //防止快速滑动控件堆积问题
    if (_needRemoveView !=nil) {
        [_needRemoveView removeFromSuperview];
        _needRemoveView = nil;
    }
    
    _beginTimeStamp = event.timestamp;
    _beginPt = [[touches anyObject] locationInView:self];
    
    //控件滑动范围
    if (kBeginPtYRange)
        _moveYes = YES;
    else
        _moveYes = NO;
}

#pragma mark - 触摸移动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder]touchesMoved:touches withEvent:event];
    CGPoint pt = [[touches anyObject] locationInView:self];
    CGFloat x = pt.x - _beginPt.x;
    CGFloat y = pt.y - _beginPt.y;
    
    //图片范围内响应
    if (_moveYes == YES) {
        _currentView.center = CGPointMake(_currentImgCenter.x + x,_currentImgCenter.y + y);
        _currentView.transform=CGAffineTransformMakeRotation(x/1000);
    }
}

#pragma mark - 触摸结束
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.tableView.scrollEnabled = YES;
    CGPoint pt = [[touches anyObject] locationInView:self];
    CGFloat distanceX =  pt.x -_beginPt.x;
    CGFloat timeStamp = _beginTimeStamp - event.timestamp;
    
    if (kBeginPtYRange&&fabs(distanceX)<10)
    {
        if ([_delegate respondsToSelector:@selector(clickCurrentViewWithIndex:)]) {
            [_delegate clickCurrentViewWithIndex:_currentIndex];
        }
    }
    
    //快速小范围滑动/*1*/
    if (fabs(timeStamp)<0.12f&&fabs(distanceX)>25)
    {
        if (_dataArray.count >1) {
            if (distanceX>0)
            {
                [self moveViewX:kRemoveRightX Y:pt.y andRemoveView:YES];
            }
            else
            {
                [self moveViewX:kRemoveLeftX Y:pt.y andRemoveView:YES];
            }
        }
        else
        {
            [self moveViewX:_currentImgCenter.x Y:_currentImgCenter.y andRemoveView:NO];
        }
        
    }
    else
    {
        //慢速大范围/*1*/
        //向右
        if (distanceX>0)
        {
            if (distanceX>_currentView.frame.size.width/3 && _dataArray.count >1)
            {
                [self moveViewX:kRemoveRightX Y:pt.y andRemoveView:YES];
            }
            else
            {
                [self moveViewX:_currentImgCenter.x Y:_currentImgCenter.y andRemoveView:NO];
            }
        }
        else
        {
            //向左
            if ( fabs(distanceX)>_currentView.frame.size.width/3 && _dataArray.count >1)
            {
                [self moveViewX:kRemoveLeftX Y:pt.y andRemoveView:YES];
            }
            else
            {
                [self moveViewX:_currentImgCenter.x Y:_currentImgCenter.y andRemoveView:NO];
            }
        }
    } /*1*/
}

#pragma mark - -
- (void)moveViewX:(float)x Y:(float)y andRemoveView:(BOOL)isRemove
{
    [UIView animateWithDuration:0.3 animations:^{
        _currentView.center = CGPointMake(x  ,  y);
        _currentView.transform = CGAffineTransformMakeRotation(0);
        
    } completion:^(BOOL finished) {
        [_needRemoveView removeFromSuperview];
        _needRemoveView = nil;
    }];
    
    if (isRemove == YES) {
        _currentIndex++;
        id model = _dataArray[0];
        [_dataArray removeObjectAtIndex:0];
        /*做无限循环  如果不需要循环  去掉下面这句话*/
        [_dataArray addObject:model];
        if (_dataArray.count == 0) {
            self.userInteractionEnabled = NO;
            
        }else{
            self.userInteractionEnabled = YES;
            if (_dataArray.count > 1) {
                [self changeMoveView];
            }
        }
    }
}

#pragma mark - -
- (void)changeMoveView
{
    _needRemoveView = _picViewArray[0];
    [_picViewArray removeObjectAtIndex:0];
    
    NSInteger picCount;
    if (_dataArray.count<kCurrentViewNum)
    {
        picCount = _dataArray.count;
        //        [_picViewArray addObject:_currentView];
    }
    else
    {
        picCount = kCurrentViewNum;
        [_picViewArray addObject:[self addVIewWithFrame:
                                  CGRectMake(
                                             kFirstViewFrameX+(kCurrentViewNum-1)*kImgViewRange*3,
                                             kFirstPicFrameY + (kCurrentViewNum-1)*kImgViewRange*4,
                                             kWidth-kFirstViewFrameX*2-(kCurrentViewNum-1)*kImgViewRange*2*3,
                                             kHeight-(kCurrentViewNum-1)*kImgViewRange*2)
                                         andWithdataNum:picCount-1]];
    }
    
    //
    for (int i = 0; i<picCount; i++) {
        SHFCardView *cardView = _picViewArray[i];
        
        if (i == 0) {
            _currentView = cardView;
            _currentImgCenter = _currentView.center;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            cardView.frame = CGRectMake(kFirstViewFrameX+i*kImgViewRange*3,kFirstPicFrameY + i*kImgViewRange*4,kWidth-kFirstViewFrameX*2-i*kImgViewRange*2*3,kHeight-i*kImgViewRange*2);
            cardView.imgview.frame = cardView.bounds;
            cardView.defaultImgview.frame = cardView.bounds;
        } completion:^(BOOL finished) {
            if (i == 0) {
                [UIView animateWithDuration:0.2 animations:^{
                    cardView.imgview.alpha = 1;
                }];
            }
        }];
        
        if (i == picCount-1){
            
            cardView.alpha = 0;
            
            [UIView animateWithDuration:0.3 animations:^{
                cardView.alpha = 1;
            }];
            [self insertSubview:cardView atIndex:0];
        }
        
        if (i == 0) {
            _currentView = cardView;
            _currentImgCenter = _currentView.center;
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return NO;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
