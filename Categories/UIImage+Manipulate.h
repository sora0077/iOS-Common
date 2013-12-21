//
//  UIImage+Manipulate.h
//  VividTunes
//
//  Created by 林 達也 on 2013/10/29.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Manipulate)

- (UIImage *)squareImage;

- (UIImage *)circleImage;
- (UIImage *)clipCornerRadius:(CGFloat)cornerRadius;
- (UIImage *)clipUsingBezierPath:(UIBezierPath *)bezierPath;

@end
