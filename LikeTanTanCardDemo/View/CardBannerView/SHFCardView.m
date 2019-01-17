//
//  SHFCardView.m
//  LikeTanTanCardDemo
//
//  Created by sunhongfu on 2018/9/17.
//  Copyright © 2018年 sunhongfu. All rights reserved.
//

#import "SHFCardView.h"
@interface SHFCardView ()



@end

@implementation SHFCardView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //        self.layer.masksToBounds = YES;
        self.layer.cornerRadius =10;
        //        self.layer.borderWidth = 1;
        self.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
        self.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
        self.layer.shadowOpacity = 0.1;//阴影透明度
        self.layer.shadowRadius = 10;//阴影直径
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        [self addSubview:self.defaultImgview];
        [self addSubview:self.imgview];
    }
    return self;
}

- (void)setCardBannerUrl:(NSString *)cardBannerUrl
{
    if (_cardBannerUrl != cardBannerUrl) {
        _cardBannerUrl = cardBannerUrl;
    }
    _imgview.image = [UIImage imageNamed:cardBannerUrl];
}

- (UIImageView *)imgview
{
    if (!_imgview) {
        _imgview = [[UIImageView alloc] initWithFrame:self.bounds];
        _imgview.contentMode = UIViewContentModeScaleAspectFill;
        _imgview.layer.cornerRadius = 10;
        _imgview.clipsToBounds = YES;
        _imgview.alpha = 0;
        
    }
    return _imgview;
}

- (UIImageView *)defaultImgview
{
    if (!_defaultImgview) {
        _defaultImgview = [[UIImageView alloc] initWithFrame:self.bounds];
        _defaultImgview.contentMode = UIViewContentModeScaleAspectFill;
        _defaultImgview.layer.cornerRadius = 10;
        _defaultImgview.clipsToBounds = YES;
        _defaultImgview.backgroundColor = [UIColor lightGrayColor];
    }
    return _defaultImgview;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
