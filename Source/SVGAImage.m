//
//  SVGAImage.m
//  SVGAPlayer
//
//  Created by 崔 明辉 on 2017/3/30.
//  Copyright © 2017年 UED Center. All rights reserved.
//

#import "SVGAImage.h"
#import "SVGAParser.h"
#import "SVGAVideoEntity.h"
#import "SVGADynamicEntity.h"
#import "SVGAContentLayer.h"
#import "SVGAVideoSpriteEntity.h"

@interface SVGAImageLayer : CALayer

@property (nonatomic, assign) NSInteger currentFrame;

@end

@implementation SVGAImageLayer

+ (BOOL)needsDisplayForKey:(NSString *)key {
    return [key isEqualToString:@"currentFrame"] || [super needsDisplayForKey:key];
}

- (void)setCurrentFrame:(NSInteger)currentFrame {
    if (_currentFrame == currentFrame) {
        return;
    }
    _currentFrame = currentFrame;
    [CATransaction setDisableActions:YES];
    for (SVGAContentLayer *layer in self.sublayers) {
        if ([layer isKindOfClass:[SVGAContentLayer class]]) {
            [layer stepToFrame:currentFrame];
        }
    }
    [CATransaction setDisableActions:NO];
}

@end

@interface SVGAImage ()

@property (nonatomic, strong) SVGAImageLayer *layer;
@property (nonatomic, strong) SVGAVideoEntity *videoItem;
@property (nonatomic, strong) SVGADynamicEntity *dynamicItem;

@end

@implementation SVGAImage

- (instancetype)initWithVideoItem:(SVGAVideoEntity *)videoItem dynamicItem:(SVGADynamicEntity *)dynamicItem
{
    self = [super init];
    if (self) {
        self.videoItem = videoItem;
        self.dynamicItem = dynamicItem;
        [self createLayer];
    }
    return self;
}

- (void)createLayer {
    self.layer = [[SVGAImageLayer alloc] init];
    self.layer.frame = CGRectMake(0, 0, self.videoItem.videoSize.width, self.videoItem.videoSize.height);
    self.layer.masksToBounds = true;
    [self.videoItem.sprites enumerateObjectsUsingBlock:^(SVGAVideoSpriteEntity * _Nonnull sprite, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage *bitmap;
        if (sprite.imageKey != nil) {
            if (self.dynamicItem.dynamicObjects[sprite.imageKey] != nil) {
                bitmap = self.dynamicItem.dynamicObjects[sprite.imageKey];
            }
            else {
                bitmap = self.videoItem.images[sprite.imageKey];
            }
        }
        SVGAContentLayer *contentLayer = [sprite requestLayerWithBitmap:bitmap];
        [self.layer addSublayer:contentLayer];
        if (sprite.imageKey != nil) {
            if (self.dynamicItem.dynamicLayers[sprite.imageKey] != nil) {
                CALayer *dynamicLayer = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self.dynamicItem.dynamicLayers[sprite.imageKey]]];
                dynamicLayer.contentsGravity = kCAGravityResizeAspect;
                [contentLayer addSublayer:dynamicLayer];
            }
            if (self.dynamicItem.dynamicTexts[sprite.imageKey] != nil) {
                NSAttributedString *text = self.dynamicItem.dynamicTexts[sprite.imageKey];
                CGSize size = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:NULL].size;
                CATextLayer *textLayer = [CATextLayer layer];
                textLayer.contentsScale = [[UIScreen mainScreen] scale];
                [textLayer setString:self.dynamicItem.dynamicTexts[sprite.imageKey]];
                textLayer.frame = CGRectMake(0, 0, size.width, size.height);
                [contentLayer addSublayer:textLayer];
            }
        }
    }];
    [self drawFrame:0];
}

- (void)drawFrame:(NSInteger)frame {
    [(SVGAImageLayer *)self.layer setCurrentFrame:frame];
}

@end
