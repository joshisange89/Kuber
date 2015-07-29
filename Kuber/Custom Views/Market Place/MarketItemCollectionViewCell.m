//
//  MarketItemCollectionViewCell.m
//  Kuber
//
//  Created by Santa on 7/27/15.
//  Copyright (c) 2015 Kubercube. All rights reserved.
//

#import "MarketItemCollectionViewCell.h"
#import "Layout.h"

@implementation MarketItemCollectionViewCell{
    UIImageView *_itemImageView;
    UILabel *_brandNameLabel;
    UILabel *_sizeLabel;
    UILabel *_priceLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
//        self.selectedBackgroundView = [Layout selectedBackgroundView];
        
        _itemImageView = [[UIImageView alloc] init];
        _itemImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _itemImageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_itemImageView];
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        _brandNameLabel = [[UILabel alloc] init];
        _brandNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _brandNameLabel.backgroundColor = [UIColor clearColor];
        _brandNameLabel.textColor = [UIColor darkGrayColor];
        _brandNameLabel.font = [UIFont boldSystemFontOfSize:12];
        _brandNameLabel.numberOfLines = 0;
        _brandNameLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
        _brandNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:_brandNameLabel];
        
        _sizeLabel = [[UILabel alloc] init];
        _sizeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _sizeLabel.backgroundColor = [UIColor clearColor];
        _sizeLabel.textColor = [UIColor darkGrayColor];
        _sizeLabel.font = [UIFont boldSystemFontOfSize:12];
        _sizeLabel.numberOfLines = 0;
        _sizeLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
        _sizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:_sizeLabel];
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.textColor = [Layout colorDefaultApp];
        _priceLabel.font = [UIFont boldSystemFontOfSize:12];
        _priceLabel.numberOfLines = 0;
        _priceLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
        _priceLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:_priceLabel];

        
        // Constraints
        NSDictionary *dict = NSDictionaryOfVariableBindings(_itemImageView, _brandNameLabel, _sizeLabel,_priceLabel);
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_itemImageView]-|" options:0 metrics:nil views:dict]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_itemImageView(==270)]-2-[_brandNameLabel]" options:0 metrics:nil views:dict]];
        
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_brandNameLabel]-|" options:0 metrics:nil views:dict]];
        
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_sizeLabel]-|" options:0 metrics:nil views:dict]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_brandNameLabel]-1-[_sizeLabel]" options:0 metrics:nil views:dict]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_priceLabel]-|" options:0 metrics:nil views:dict]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_sizeLabel]-1-[_priceLabel]" options:0 metrics:nil views:dict]];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.masksToBounds = NO;
    self.layer.shadowPath = shadowPath.CGPath;
    self.layer.shadowOffset = CGSizeMake(1, 0);
    self.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    self.layer.shadowRadius = 2;
    self.layer.shadowOpacity = 0.6;
}

- (void)setBrandName:(NSString *)text {
    _brandName = text;
    _brandNameLabel.text = text;
}

- (void)setItemImage:(UIImage *)image {
    _itemImage = image;
    _itemImageView.image = image;
}

- (void)setSize:(NSString *)text {
    _size = text;
    _sizeLabel.text = text;
}

- (void)setPrice:(NSInteger)value {
    _price = value;
    _priceLabel.text = [NSString stringWithFormat:@"%ld$",(long)value];
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [Layout drawCellSeparatorWithRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [Layout colorGrey].CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, rect.size.width, 0);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextAddLineToPoint(context, 0, rect.size.height);
    CGContextStrokePath(context);
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.brandName = nil;
    self.size = nil;
}

@end
