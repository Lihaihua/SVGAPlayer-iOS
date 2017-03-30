//
//  SVGAImage.h
//  SVGAPlayer
//
//  Created by 崔 明辉 on 2017/3/30.
//  Copyright © 2017年 UED Center. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SVGAVideoEntity, SVGADynamicEntity;

@interface SVGAImage : NSObject

@property (nonatomic, readonly) CALayer *layer;
@property (nonatomic, readonly) SVGAVideoEntity *videoItem;

- (instancetype)initWithVideoItem:(SVGAVideoEntity *)videoItem
                      dynamicItem:(SVGADynamicEntity *)dynamicItem;

- (void)drawFrame:(NSInteger)frame;

@end
