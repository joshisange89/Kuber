//
//  CartItemTableViewCell.h
//  Kuber
//
//  Created by Santa on 7/28/15.
//  Copyright (c) 2015 Kubercube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartItemTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *brandName;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, strong) UIImage *itemImage;

@end
