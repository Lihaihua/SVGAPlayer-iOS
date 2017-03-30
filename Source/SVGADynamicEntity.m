//
//  SVGADynamicEntity.m
//  SVGAPlayer
//
//  Created by 崔 明辉 on 2017/3/30.
//  Copyright © 2017年 UED Center. All rights reserved.
//

#import "SVGADynamicEntity.h"

@interface SVGADynamicEntity ()

@property (nonatomic, copy) NSDictionary *dynamicObjects;
@property (nonatomic, copy) NSDictionary *dynamicLayers;
@property (nonatomic, copy) NSDictionary *dynamicTexts;

@end

@implementation SVGADynamicEntity

- (void)setImage:(UIImage *)image forKey:(NSString *)aKey referenceLayer:(CALayer *)referenceLayer {
    if (image == nil) {
        return;
    }
    NSMutableDictionary *mutableDynamicObjects = [self.dynamicObjects mutableCopy];
    [mutableDynamicObjects setObject:image forKey:aKey];
    self.dynamicObjects = mutableDynamicObjects;
    if (referenceLayer != nil) {
        NSMutableDictionary *mutableDynamicLayers = [self.dynamicLayers mutableCopy];
        [mutableDynamicLayers setObject:referenceLayer forKey:aKey];
        self.dynamicLayers = mutableDynamicLayers;
    }
}

- (void)setAttributedText:(NSAttributedString *)attributedText forKey:(NSString *)aKey {
    if (attributedText == nil) {
        return;
    }
    NSMutableDictionary *mutableDynamicTexts = [self.dynamicTexts mutableCopy];
    [mutableDynamicTexts setObject:attributedText forKey:aKey];
    self.dynamicTexts = mutableDynamicTexts;
}

- (void)clearDynamicObjects {
    self.dynamicObjects = nil;
    self.dynamicLayers = nil;
}

- (NSDictionary *)dynamicObjects {
    if (_dynamicObjects == nil) {
        _dynamicObjects = @{};
    }
    return _dynamicObjects;
}

- (NSDictionary *)dynamicLayers {
    if (_dynamicLayers == nil) {
        _dynamicLayers = @{};
    }
    return _dynamicLayers;
}

- (NSDictionary *)dynamicTexts {
    if (_dynamicTexts == nil) {
        _dynamicTexts = @{};
    }
    return _dynamicTexts;
}

@end
