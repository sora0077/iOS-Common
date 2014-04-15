//
//  UIImage+Manipulate.m
//  VividTunes
//
//  Created by 林 達也 on 2013/10/29.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import "UIImage+Manipulate.h"

@implementation UIImage (Manipulate)

- (UIImage *)squareImage
{
    if (self.size.width == self.size.height) {
        return self;
    }

    CGRect rect;
    if (self.size.height > self.size.width) {
        rect.origin.x = 0;
        rect.origin.y = (self.size.height - self.size.width) / 2.0;
        rect.size = CGSizeMake(self.size.width, self.size.width);
    } else {
        rect.origin.x = (self.size.width - self.size.height) / 2.0;
        rect.origin.y = 0;
        rect.size = CGSizeMake(self.size.height, self.size.height);
    }
    rect.size.width *= self.scale;
    rect.size.height *= self.scale;

    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);

    UIImage *cropped = [UIImage imageWithCGImage:imageRef
                                           scale:self.scale
                                     orientation:self.imageOrientation];
    CGImageRelease(imageRef);

    return cropped;
}

- (UIImage *)circleImage
{
    UIImage *squareImage = [self squareImage];
    return [squareImage clipCornerRadius:MAX(squareImage.size.width, squareImage.size.height) / 2];
}

- (UIImage *)clipCornerRadius:(CGFloat)cornerRadius
{
    cornerRadius = MIN(MAX(self.size.width, self.size.height) / 2, cornerRadius);

    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);

    CGRect bounds = CGRectZero;
    bounds.size = self.size;
    [[UIBezierPath bezierPathWithRoundedRect:bounds
                                cornerRadius:cornerRadius] addClip];

    [self drawInRect:bounds];

    UIImage *ret = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return ret;
}

- (UIImage *)clipUsingBezierPath:(UIBezierPath *)bezierPath
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);

    [bezierPath addClip];
    CGRect bounds = CGRectZero;
    bounds.size = self.size;
    [self drawInRect:bounds];

    UIImage *ret = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return ret;
}

@end
