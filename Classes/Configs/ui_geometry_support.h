//
//  ui_geometry_support.h
//  VividTunes
//
//  Created by 林 達也 on 2013/09/25.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import <UIKit/UIKit.h>


UIKIT_STATIC_INLINE CGFloat UIMinX(UIView *view)
{
    return CGRectGetMinX(view.frame);
}

UIKIT_STATIC_INLINE CGFloat UIMidX(UIView *view)
{
    return CGRectGetMidX(view.frame);
}

UIKIT_STATIC_INLINE CGFloat UIMaxX(UIView *view)
{
    return CGRectGetMaxX(view.frame);
}

UIKIT_STATIC_INLINE CGFloat UIMinY(UIView *view)
{
    return CGRectGetMinY(view.frame);
}

UIKIT_STATIC_INLINE CGFloat UIMidY(UIView *view)
{
    return CGRectGetMidY(view.frame);
}

UIKIT_STATIC_INLINE CGFloat UIMaxY(UIView *view)
{
    return CGRectGetMaxY(view.frame);
}

UIKIT_STATIC_INLINE CGFloat UIWidth(UIView *view)
{
    return CGRectGetWidth(view.frame);
}

UIKIT_STATIC_INLINE CGFloat UIHeight(UIView *view)
{
    return CGRectGetHeight(view.frame);
}

UIKIT_STATIC_INLINE void CGRectVerticalDivideFromTop(CGRect baseRect, CGFloat amount, void (^block)(CGRect topRect, CGRect bottomRect))
{
    CGRect sliceRect = CGRectNull;
    CGRect remainderRect = CGRectNull;

    CGRectDivide(baseRect, &sliceRect, &remainderRect, amount, CGRectMinYEdge);

    if (block) {
        block(sliceRect, remainderRect);
    }
}

UIKIT_STATIC_INLINE void CGRectVerticalDivideFromBottom(CGRect baseRect, CGFloat amount, void (^block)(CGRect topRect, CGRect bottomRect))
{
    CGRect sliceRect = CGRectNull;
    CGRect remainderRect = CGRectNull;

    CGRectDivide(baseRect, &sliceRect, &remainderRect, amount, CGRectMaxYEdge);

    if (block) {
        block(sliceRect, remainderRect);
    }
}

UIKIT_STATIC_INLINE void CGRectHorizontalDivideFromLeft(CGRect baseRect, CGFloat amount, void (^block)(CGRect leftRect, CGRect rightRect))
{
    CGRect sliceRect = CGRectNull;
    CGRect remainderRect = CGRectNull;

    CGRectDivide(baseRect, &sliceRect, &remainderRect, amount, CGRectMinXEdge);

    if (block) {
        block(sliceRect, remainderRect);
    }
}

UIKIT_STATIC_INLINE void CGRectHorizontalDivideFromRight(CGRect baseRect, CGFloat amount, void (^block)(CGRect leftRect, CGRect rightRect))
{
    CGRect sliceRect = CGRectNull;
    CGRect remainderRect = CGRectNull;

    CGRectDivide(baseRect, &sliceRect, &remainderRect, amount, CGRectMaxXEdge);

    if (block) {
        block(sliceRect, remainderRect);
    }
}

