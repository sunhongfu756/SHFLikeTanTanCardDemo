//
//  SHFBaseTableView.m
//  LikeTanTanCardDemo
//
//  Created by sunhongfu on 2018/9/17.
//  Copyright © 2018年 sunhongfu. All rights reserved.
//

#import "SHFBaseTableView.h"

@interface SHFBaseTableView ()
{
    NSInteger _beginTimeStamp;
    CGPoint  _beginPt;
    BOOL  _moveYes;
}
@end

@implementation SHFBaseTableView

- (void)dealloc {
    
    [self removeObserver:self forKeyPath:@"panGestureRecognizer.state"];
    
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    [self addObserver:self forKeyPath:@"panGestureRecognizer.state" options:NSKeyValueObservingOptionNew context:nil];
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (self.panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"开始");
        
        CGPoint vel = [self.panGestureRecognizer velocityInView:self];
        float x = vel.x>0?vel.x:-vel.x;
        float y = vel.y>0?vel.y:-vel.y;
        NSLog(@"x= %f y= %f",x,y);
        if ( x>y && self.contentOffset.y < [UIScreen mainScreen].bounds.size.height) {
            self.scrollEnabled = NO;
        }else{
            self.scrollEnabled = YES;
        }
    }
    
    if (self.panGestureRecognizer.state == UIGestureRecognizerStateChanged) { NSLog(@"改变");
        CGPoint vel = [self.panGestureRecognizer velocityInView:self];
        float x = vel.x>0?vel.x:-vel.x;
        float y = vel.y>0?vel.y:-vel.y;
        NSLog(@"x= %f y= %f",x,y);
        //        if ( x>30 ) {
        //            self.scrollEnabled = NO;
        //        }else{
        self.scrollEnabled = YES;
        //        }
    }
    if (self.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"结束");
        CGPoint vel = [self.panGestureRecognizer velocityInView:self];
        float x = vel.x>0?vel.x:-vel.x;
        float y = vel.y>0?vel.y:-vel.y;
        NSLog(@"x= %f y= %f",x,y);
        self.scrollEnabled = YES;
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
