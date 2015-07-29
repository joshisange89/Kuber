//
//  Layout.h
//  Kuber
//
//  Created by Santa on 7/27/15.
//  Copyright (c) 2015 Kubercube. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Layout : NSObject

+ (UIColor*)colorLightGrey;
+ (UIColor*)colorDefaultApp;
+ (UIColor*)colorGreen;
+ (UIColor*)colorPlaceHolderGrey;
+ (UIColor*)colorWhite;
+ (UIColor*)colorGrey;
+ (UIColor*)colorBlackOpaque;
+ (UIView *)selectedBackgroundView;
+ (UIColor*)colorRowSeparatorLight;
+ (void)drawCellSeparatorWithRect:(CGRect)rect;

@end
