//
//  MarketItemCollectionViewCell.h
//  Kuber
//
//  Created by Santa on 7/27/15.
//  Copyright (c) 2015 Kubercube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketItemCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSString *brandName;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, strong) UIImage *itemImage;


@end
