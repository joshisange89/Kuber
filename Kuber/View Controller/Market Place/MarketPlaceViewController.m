//
//  MarketPlaceViewController.m
//  Kuber
//
//  Created by Santa on 7/27/15.
//  Copyright (c) 2015 Kubercube. All rights reserved.
//

#import "MarketPlaceViewController.h"
#import "MarketItemCollectionViewCell.h"
#import "MarketItemDetailViewController.h"
#import "FilterTableViewController.h"
#import <Parse/Parse.h>
#import "CartViewController.h"

@interface MarketPlaceViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) UICollectionView * collectionView;
@property (strong, nonatomic) NSMutableArray * imageArray;
@property (strong, nonatomic) NSMutableArray * cartItemsArray;
@property (strong, nonatomic) UILabel *cartBadgeValue;


@end

@implementation MarketPlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UILongPressGestureRecognizer *lpgr
    = [[UILongPressGestureRecognizer alloc]
       initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = .5; //seconds
    lpgr.delegate = self;
    [self.collectionView addGestureRecognizer:lpgr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Overriden

- (void)loadView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
    self.navigationItem.title = @"Market Place";
    [self getDataFromParseServer];
    
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.collectionView];
    [self setNavigationItems];
    
}

-(void)setNavigationItems
{
    UIImage *backButtonImage = [[UIImage imageNamed:@"BackButton"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    ;
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithImage:nil landscapeImagePhone:nil style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = btn;
    self.navigationItem.backBarButtonItem.title=@"";
    self.navigationController.navigationBar.backIndicatorImage = backButtonImage;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backButtonImage;
    [UINavigationBar appearance].backIndicatorImage = backButtonImage;
    [UINavigationBar appearance].backIndicatorTransitionMaskImage = backButtonImage;
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]init];
    
    UIImage *userSettingImage=[UIImage imageNamed:@"UserSettings"];
    CGRect userSetting = CGRectMake(0, 0, userSettingImage.size.width, userSettingImage.size.height);
    UIButton *userSettingButton=[[UIButton alloc]initWithFrame:userSetting];
    [userSettingButton setBackgroundImage:userSettingImage forState:UIControlStateNormal];
    [userSettingButton addTarget:self action:@selector(userSettingButtonPressed)
                forControlEvents:UIControlEventTouchUpInside];
    [userSettingButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc]initWithCustomView:userSettingButton];
    self.navigationItem.leftBarButtonItem=barButton;
    
    UIImage *cartImage=[UIImage imageNamed:@"Cart"];
    CGRect cart = CGRectMake(0, 15, cartImage.size.width, cartImage.size.height);
    UIButton *cartButton=[[UIButton alloc]initWithFrame:cart];
    [cartButton setBackgroundImage:cartImage forState:UIControlStateNormal];
    [cartButton addTarget:self action:@selector(cartButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    [cartButton setShowsTouchWhenHighlighted:YES];
    
    
    UIImage *filterImage=[UIImage imageNamed:@"filter"];
    CGRect filterFrame = CGRectMake(cartImage.size.width, 15, cartImage.size.width, cartImage.size.height);
    UIButton *filterButton=[[UIButton alloc]initWithFrame:filterFrame];
    [filterButton setBackgroundImage:filterImage forState:UIControlStateNormal];
    [filterButton addTarget:self action:@selector(filterButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
    [filterButton setShowsTouchWhenHighlighted:YES];
    
    UIImage *cartBadgeImage=[UIImage imageNamed:@"CartBadge"];
    CGRect cartBadgeFrame = CGRectMake(20, 20, cartBadgeImage.size.width, cartBadgeImage.size.height);
    
    UIImageView *cartBadgeImageView = [[UIImageView alloc] initWithFrame:cartBadgeFrame];
    cartBadgeImageView.image = cartBadgeImage;
    
    
    _cartBadgeValue = [[UILabel alloc] initWithFrame:cartBadgeImageView.frame];
    _cartBadgeValue.translatesAutoresizingMaskIntoConstraints = NO;
    _cartBadgeValue.backgroundColor = [UIColor clearColor];
    _cartBadgeValue.textColor = [UIColor darkGrayColor];
    _cartBadgeValue.font = [UIFont boldSystemFontOfSize:8];
    _cartBadgeValue.numberOfLines = 0;
    _cartBadgeValue.textAlignment = UIBaselineAdjustmentAlignCenters;
    _cartBadgeValue.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    UIView *rightBarButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, filterImage.size.width*2, filterImage.size.height*2)];
    [rightBarButtonView addSubview:cartButton];
    [rightBarButtonView addSubview:filterButton];
    [rightBarButtonView addSubview:cartBadgeImageView];
    [rightBarButtonView addSubview:_cartBadgeValue];
    
    
    rightBarButtonView.backgroundColor = [UIColor clearColor];
    
    
    UIBarButtonItem *rightBarButton=[[UIBarButtonItem alloc]initWithCustomView:rightBarButtonView];
    self.navigationItem.rightBarButtonItem=rightBarButton;
    
}



- (UICollectionView *)collectionView
{
    if (_collectionView != nil)
        return _collectionView;
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    [_collectionView registerClass:[MarketItemCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    
    return _collectionView;
}
- (NSMutableArray *)imageArray
{
    if (_imageArray != nil)
        return _imageArray;
    
    _imageArray = [[NSMutableArray alloc] init];
    
    return  _imageArray;
}
- (NSMutableArray *)cartItemsArray
{
    if (_cartItemsArray != nil)
        return _cartItemsArray;
    
    _cartItemsArray = [[NSMutableArray alloc] init];
    
    return  _cartItemsArray;
}

#pragma mark - Action Methods

-(void)backButtonPressed
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)cartButtonPressed
{
    NSLog(@"cartButtonPressed");
    CartViewController *cartViewController = [[CartViewController alloc] init];
    [self.navigationController pushViewController:cartViewController animated:YES];
}

-(void)filterButtonPressed
{
    NSLog(@"filterButtonPressed");
    FilterTableViewController *filterViewController = [[FilterTableViewController alloc] init];
    [self.navigationController pushViewController:filterViewController animated:YES];
}

-(void)userSettingButtonPressed
{
    NSLog(@"userSettingButtonPressed");
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint p = [gestureRecognizer locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    if (indexPath == nil){
        NSLog(@"couldn't find index path");
    } else {
        // get the cell at indexPath (the one you long pressed)
        UICollectionViewCell* cell = [self.collectionView cellForItemAtIndexPath:indexPath];
        // do stuff with the cell
        [self.cartItemsArray addObject:[self.imageArray objectAtIndex:indexPath.row]];
        cell.userInteractionEnabled = NO;
        self.cartBadgeValue.text = [NSString stringWithFormat:@"%ld",self.cartItemsArray.count];
        //        [self showAddedToCartView];
        [cell removeGestureRecognizer:gestureRecognizer];
        cell.contentView.userInteractionEnabled = NO;
        cell.exclusiveTouch = YES;
    }
}

#pragma mark - Custom Methods

-(void)showAddedToCartView
{
    
    CGFloat width = 100;
    CGFloat height = 50;
    UIView *addedToCartView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-width, self.view.frame.size.width/2-height, width, height)];
    
    UILabel *addedToCartLabel = [[UILabel alloc] initWithFrame:addedToCartView.frame];
    addedToCartLabel.translatesAutoresizingMaskIntoConstraints = NO;
    addedToCartLabel.backgroundColor = [UIColor clearColor];
    addedToCartLabel.textColor = [UIColor darkGrayColor];
    addedToCartLabel.font = [UIFont boldSystemFontOfSize:8];
    addedToCartLabel.numberOfLines = 0;
    addedToCartLabel.text = @"@Added to cart";
    addedToCartLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
    addedToCartLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    [addedToCartView addSubview:addedToCartLabel];
    
    [self.view addSubview:addedToCartView];
}


-(void)getDataFromParseServer
{
    PFQuery *query = [PFQuery queryWithClassName:@"marketPics"];
    //[query whereKey:@"imageName" equalTo:@"dstemkoski@example.com"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (!objects) {
                NSLog(@"The getFirstObject request failed.");
            } else {
                // The find succeeded.
                NSLog(@"Successfully retrieved the object %lu",(unsigned long)objects.count);
                if(objects.count > 0) {
                    for (int i = 0; i<[objects count]; i++) {
                        PFFile *userImageFile =  [[objects objectAtIndex:i]objectForKey:@"imageFile"];;
                        [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                            if (!error) {
                                [self.imageArray addObject: [UIImage imageWithData:imageData]];
                                [self.collectionView reloadData];
                                
                            }
                        }];
                    }
                }
            }
        }
        
    }];
}


- (MarketItemCollectionViewCell *)cellForMarketItemAtIndexPath:(NSIndexPath *)indexPath
{
    MarketItemCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.brandName = @"Tanishq";
    if (indexPath.row == 0) {
        cell.price = 50;
    }
    else{
        cell.price = 100;
    }
    
    cell.size = @"4";
    cell.itemImage = [self.imageArray objectAtIndex:indexPath.row];
    
    cell.backgroundColor=[UIColor clearColor];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return self.imageArray.count/2;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MarketItemCollectionViewCell *cell = [self cellForMarketItemAtIndexPath:indexPath];
    
    return cell;
}

-(CGSize) collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/2 , self.view.frame.size.height/2);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MarketItemDetailViewController *detailViewController = [[MarketItemDetailViewController alloc] init];
    //Call a delegate on Market Place View Controller to filter
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
