//
//  SVGADynamicEntity.h
//  SVGAPlayer
//
//  Created by 崔 明辉 on 2017/3/30.
//  Copyright © 2017年 UED Center. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVGADynamicEntity : NSObject

@property (nonatomic, readonly) NSDictionary *dynamicObjects;
@property (nonatomic, readonly) NSDictionary *dynamicLayers;
@property (nonatomic, readonly) NSDictionary *dynamicTexts;

- (void)setImage:(UIImage *)image forKey:(NSString *)aKey referenceLayer:(CALayer *)referenceLayer;
- (void)setAttributedText:(NSAttributedString *)attributedText forKey:(NSString *)aKey;
- (void)clearDynamicObjects;

@end
