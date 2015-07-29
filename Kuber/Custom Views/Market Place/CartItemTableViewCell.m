//
//  CartItemTableViewCell.m
//  Kuber
//
//  Created by Santa on 7/28/15.
//  Copyright (c) 2015 Kubercube. All rights reserved.
//

#import "CartItemTableViewCell.h"

@implementation CartItemTableViewCell
{
    IBOutlet UIButton *closeButton;
    IBOutlet UIImageView *itemImageView;
    IBOutlet UILabel *priceLabel;
    
    IBOutlet UILabel *sizeLabel;
    IBOutlet UILabel *brandNameLabel;
}

- (IBAction)closeButtonPressed:(id)sender {
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setBrandName:(NSString *)text {
    _brandName = text;
    brandNameLabel.text = text;
}

- (void)setItemImage:(UIImage *)image {
    _itemImage = image;
    itemImageView.image = image;
}

- (void)setSize:(NSString *)text {
    _size = text;
    sizeLabel.text = text;
}

- (void)setPrice:(NSInteger)value {
    _price = value;
    priceLabel.text = [NSString stringWithFormat:@"%ld$",(long)value];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
