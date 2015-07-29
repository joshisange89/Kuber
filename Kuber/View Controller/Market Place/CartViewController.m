//
//  CartViewController.m
//  Kuber
//
//  Created by Santa on 7/27/15.
//  Copyright (c) 2015 Kubercube. All rights reserved.
//

#import "CartViewController.h"
#import "CartItemTableViewCell.h"
#import "Layout.h"

@interface CartViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSArray *cartItemArray;

@end

@implementation CartViewController

#pragma mark - Initializers

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initializeUI
{
    
    self.navigationItem.title = @"Shopping Cart";
    
    if ([self.cartItemArray count] > 0) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        // must set delegate & dataSource, otherwise the the table will be empty and not responsive
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.backgroundColor = [UIColor whiteColor];
        
        // add to canvas
        [self.view addSubview:_tableView];
        [_tableView registerClass:[CartItemTableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
        [_tableView registerNib:[UINib nibWithNibName:@"CartItemTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellIdentifier"];
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleSingleLine)];
        self.tableView.separatorColor = [Layout colorRowSeparatorLight];
        
        self.tableView.tableFooterView = [UIView new];//To eliminate extra separator below TableView
        
        
        //Checkout button
        UIButton *checkoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkoutButton addTarget:self
                           action:@selector(proceedToCheckout)
                 forControlEvents:UIControlEventTouchUpInside];
        [checkoutButton setTitle:@"Proceed to checkout" forState:UIControlStateNormal];
        [self.view addSubview:checkoutButton];
        checkoutButton.translatesAutoresizingMaskIntoConstraints = NO;
        checkoutButton.backgroundColor = [Layout colorDefaultApp];
        
        // Constraints
        NSDictionary *dict = NSDictionaryOfVariableBindings(self.view, _tableView,checkoutButton);
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:dict]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_tableView]-2-[checkoutButton]" options:0 metrics:nil views:dict]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[checkoutButton]-|" options:0 metrics:nil views:dict]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[checkoutButton(==40)]-60-|" options:0 metrics:nil views:dict]];
    }
    else {
        UILabel *emptyCartLabel = [[UILabel alloc] init];
        emptyCartLabel.translatesAutoresizingMaskIntoConstraints = NO;
        emptyCartLabel.backgroundColor = [UIColor clearColor];
        emptyCartLabel.textColor = [UIColor darkGrayColor];
        emptyCartLabel.font = [UIFont boldSystemFontOfSize:20];
        emptyCartLabel.numberOfLines = 0;
        emptyCartLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
        emptyCartLabel.lineBreakMode = NSLineBreakByWordWrapping;
        emptyCartLabel.text = @"Your cart is empty";
        [self.view addSubview:emptyCartLabel];
        
        // Constraints
        NSDictionary *dict = NSDictionaryOfVariableBindings(self.view,emptyCartLabel);
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[emptyCartLabel]-|" options:0 metrics:nil views:dict]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[emptyCartLabel]-|" options:0 metrics:nil views:dict]];
    }
    
}

#pragma mark - Custom methods

- (CartItemTableViewCell *)cellForCartItemAtIndexPath:(NSIndexPath *)indexPath
{
    CartItemTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor clearColor];
    
    [cell setPrice:10];
    [cell setItemImage:[UIImage imageNamed:@"Cart"]];
    [cell setBrandName:@"kaya"];
    [cell setSize:@"4"];
    
    return cell;
    
}

-(UITableViewCell*)createStaticCellsForOrderInfoWithIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"identifier"];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor = [Layout colorGrey];
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.textColor = [Layout colorGrey];
    
    
    if (indexPath.row == self.cartItemArray.count) {
        cell.textLabel.text = @"Subtotal";
        cell.detailTextLabel.text = @"30";
        
    }
    else if (indexPath.row == self.cartItemArray.count+1) {
        cell.textLabel.text = @"Estimated Shipping";
        cell.detailTextLabel.text = @"2";
    }
    else{
        cell.textLabel.text = @"Order Total";
        cell.detailTextLabel.text = @"32";
    }
    return cell;
}


- (NSArray *)cartItemArray
{
    if (_cartItemArray != nil)
        return _cartItemArray;
    
    _cartItemArray = [[NSArray alloc] initWithObjects:@"a", @"b", @"c", nil];
    
    return  _cartItemArray;
}


#pragma mark - Action methods
-(void)proceedToCheckout
{
    
}

#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return self.cartItemArray.count+3;
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (indexPath.row < self.cartItemArray.count) {
        cell = [self cellForCartItemAtIndexPath:indexPath];
    }
    else{
        cell = [self createStaticCellsForOrderInfoWithIndexPath:indexPath];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %ld row", (long)indexPath.row);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.cartItemArray.count) {
        return 70;
    }
    else{
        return 30;
    }
}

@end
