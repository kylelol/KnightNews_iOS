//
//  KKNewsViewController.m
//  KnightNews
//
//  Created by Kyle Kirkland on 9/29/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "KKNewsViewController.h"
#import "KKNewsFeaturedTableViewCell.h"
#import "KKNewsTableViewCell.h"

@interface KKNewsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation KKNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpTableView];
    
    self.navigationItem.title = @"News";
    self.tabBarItem.image = [UIImage imageNamed:@"newspaper_25"];
    self.tabBarItem.title = @"News";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Interface Setup Methods 
-(void)setUpTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"KKNewsTableViewCell" bundle:nil]forCellReuseIdentifier:@"NewsCell"];
        [self.tableView registerNib:[UINib nibWithNibName:@"KKNewsFeaturedTableViewCell" bundle:nil]forCellReuseIdentifier:@"FeaturedNewsCell"];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            return [self setUpFeaturedTableViewCellForTableView:tableView];
            break;
        case 1:
            return [self setUpNewsTableViewCellForTableView:tableView];
            break;
            
        default:
            return [self setUpNewsTableViewCellForTableView:tableView];
            break;
    }
}

-(KKNewsTableViewCell *)setUpNewsTableViewCellForTableView:(UITableView *)tableView
{
    KKNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor darkGrayColor];
    
    return cell;
}

-(KKNewsFeaturedTableViewCell *)setUpFeaturedTableViewCellForTableView:(UITableView *)tableView
{
    KKNewsFeaturedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeaturedNewsCell"];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor darkGrayColor];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
        return 300.0f;
    return 170.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

/*-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 5)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}*/

#pragma mark - UITableViewDelegate Methods
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end