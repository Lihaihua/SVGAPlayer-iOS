//
//  SVGAImageView.m
//  SVGAPlayer
//
//  Created by 崔 明辉 on 2017/3/30.
//  Copyright © 2017年 UED Center. All rights reserved.
//

#import "SVGAImageView.h"
#import "SVGAImage.h"
#import "SVGAVideoEntity.h"

@interface SVGAImageView ()

@property (nonatomic, strong) SVGAImage *image;
@property (nonatomic, strong) CAKeyframeAnimation *animator;

@end

@implementation SVGAImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.clearsAfterStop = YES;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.clearsAfterStop = YES;
    }
    return self;
}

- (void)setImage:(SVGAImage *)image {
    _image = image;
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.layer addSublayer:image.layer];
}

- (void)startAnimation {
    if (self.image.videoItem.FPS == 0) {
        return;
    }
    self.image.layer.hidden = NO;
    self.animator = [CAKeyframeAnimation animationWithKeyPath:@"currentFrame"];
    [self.animator setRepeatCount:self.loops <= 0 ? 99999 : self.loops - 1];
    [self.animator setValues:@[@(0), @(self.image.videoItem.frames - 1)]];
    [self.animator setDuration:self.image.videoItem.frames * (1.0 / (float)self.image.videoItem.FPS)];
    if (self.fillMode != nil) {
        [self.animator setFillMode:self.fillMode];
    }
    [self.image.layer addAnimation:self.animator forKey:@"currentFrame"];
}

- (void)pauseAnimation {
    [self stopAnimation:NO];
}

- (void)stopAnimation {
    [self stopAnimation:self.clearsAfterStop];
}

- (void)stopAnimation:(BOOL)clear {
    [self.image.layer removeAnimationForKey:@"currentFrame"];
    if (clear) {
        self.image.layer.hidden = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.frame.size.width == 0.0 || self.frame.size.height == 0.0 ||
        self.image.layer.frame.size.width == 0.0 || self.image.layer.frame.size.height == 0.0) {
        return;
    }
    switch (self.contentMode) {
        case UIViewContentModeScaleAspectFit:
            if (self.image.layer.frame.size.width / self.image.layer.frame.size.height > self.frame.size.width / self.frame.size.height) {
                self.image.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(self.frame.size.width / self.image.layer.frame.size.width, self.frame.size.width / self.image.layer.frame.size.width));
                self.image.layer.position = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
            }
            else {
                self.image.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(self.frame.size.height / self.image.layer.frame.size.height, self.frame.size.height / self.image.layer.frame.size.height));
                self.image.layer.position = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
            }
            break;
        case UIViewContentModeScaleAspectFill:
            if (self.image.layer.frame.size.width / self.image.layer.frame.size.height > self.frame.size.width / self.frame.size.height) {
                self.image.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(self.frame.size.height / self.image.layer.frame.size.height, self.frame.size.height / self.image.layer.frame.size.height));
                self.image.layer.position = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
            }
            else {
                self.image.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(self.frame.size.width / self.image.layer.frame.size.width, self.frame.size.width / self.image.layer.frame.size.width));
                self.image.layer.position = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
            }
            break;
        default:
            self.image.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(self.frame.size.width / self.image.layer.frame.size.width, self.frame.size.height / self.image.layer.frame.size.height));
            self.image.layer.position = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
            break;
    }
}

@end
