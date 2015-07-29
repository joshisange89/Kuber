//
//  Layout.m
//  Kuber
//
//  Created by Santa on 7/27/15.
//  Copyright (c) 2015 Kubercube. All rights reserved.
//

#import "Layout.h"

@implementation Layout

+ (UIColor*)colorLightGrey {
    return [UIColor colorWithWhite:0.92 alpha:1.0];
}

+ (UIColor*)colorDefaultApp {
    return [UIColor colorWithRed:60/255.0 green:173/255.0 blue:251/255.0 alpha:1.0];
}

+ (UIColor*)colorGreen {
    return [UIColor colorWithRed:74/255.0 green:167/255.0 blue:30/255.0 alpha:1.0];
}

+ (UIColor*)colorPlaceHolderGrey {
    return [UIColor colorWithWhite:0.57 alpha:1.0];
}

+ (UIColor*)colorWhite {
    return [UIColor colorWithWhite:0.0 alpha:1.0];
}

+ (UIColor*)colorGrey {
    return [UIColor colorWithWhite:0.42 alpha:1.0];
}

+ (UIColor*)colorBlackOpaque {
    return [UIColor colorWithWhite:0.0 alpha:1.0];
}

+ (UIView *)selectedBackgroundView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [Layout colorGreen];
    return view;
}

+ (UIColor*)colorRowSeparatorLight {
    return [UIColor colorWithWhite:0.88 alpha:1.0];
}

+ (void)drawCellSeparatorWithRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, [Layout colorRowSeparatorLight].CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextMoveToPoint(context, 6, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

@end
