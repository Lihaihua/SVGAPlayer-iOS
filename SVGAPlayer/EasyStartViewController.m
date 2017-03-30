//
//  EasyStartViewController.m
//  SVGAPlayer
//
//  Created by 崔 明辉 on 2017/3/30.
//  Copyright © 2017年 UED Center. All rights reserved.
//

#import "EasyStartViewController.h"
#import "SVGAImageView.h"
#import "SVGAImage.h"
#import "SVGAParser.h"

@interface EasyStartViewController ()

@property (weak, nonatomic) IBOutlet SVGAImageView *imageView;

@end

@implementation EasyStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SVGAParser *parser = [SVGAParser new];
    [parser parseWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"angel" ofType:@"svga"]]
                 cacheKey:@"file:///angel.svga"
          completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
              [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                  SVGAImage *image = [[SVGAImage alloc] initWithVideoItem:videoItem dynamicItem:nil];
                  [self.imageView setImage:image];
                  [self.imageView startAnimation];
              }];
    } failureBlock:nil];
    
}


@end
