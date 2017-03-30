//
//  SVGAImageView.h
//  SVGAPlayer
//
//  Created by 崔 明辉 on 2017/3/30.
//  Copyright © 2017年 UED Center. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SVGAImage;

@interface SVGAImageView : UIView

@property (nonatomic, assign) IBInspectable NSInteger loops;
@property (nonatomic, assign) IBInspectable BOOL clearsAfterStop;
@property (nonatomic, assign) IBInspectable NSString *fillMode;

- (void)setImage:(SVGAImage *)image;

- (void)startAnimation;

- (void)pauseAnimation;

- (void)stopAnimation;

@end
