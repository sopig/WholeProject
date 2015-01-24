//
//  SettingViewController.m
//  NetDemo
//
//  Created by 海锋 周 on 12-6-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
-(void) BtnClicked:(id)sender;
@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
        //糗事列表
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 80, kDeviceWidth-40,200) style:UITableViewStyleGrouped];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        [self.view addSubview:tableView];
        
        //添加headbar 
        UIImage *headimage = [UIImage imageNamed:@"head_background.png"];
        UIImageView *headView = [[UIImageView alloc]initWithImage:headimage];
        [headView setFrame:CGRectMake(0, 0, 320, 44)];
        [self.view addSubview:headView];
        [headView release];
        [headimage release];
        
        UIButton *helpbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [helpbtn setFrame:CGRectMake(10,6,32,32)];
        [helpbtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [helpbtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:helpbtn];
        
        //添加UILabel
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(120, 6, 160, 32)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont: [UIFont fontWithName:@"Arial" size:24]];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:[NSString stringWithFormat:@"我的糗百"]];
        [self.view addSubview:label];
        [label release];
    }
    return self;
}


-(void) BtnClicked:(id)sender
{
    [self.view removeFromSuperview];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - TableView*

- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"_QiShiCELL";
    UITableViewCell *cell =(UITableViewCell *) [tableview dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
     
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section==0) {
            if (indexPath.row == 0) {
                [cell.detailTextLabel setText:@"用户名:念风2012"];
                [cell.detailTextLabel setTextColor:[UIColor brownColor]];
                [cell.detailTextLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
            }else if(indexPath.row == 1)
            {
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                [cell.detailTextLabel setText:  @"退出登陆"];
                [cell.detailTextLabel setTextAlignment:UITextAlignmentCenter];
                [cell.detailTextLabel setTextColor:[UIColor brownColor]];
                [cell.detailTextLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
            }
        }else if (indexPath.section==1){
            if (indexPath.row == 0) {
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                [cell.detailTextLabel setTextColor:[UIColor brownColor]];
                [cell.detailTextLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
                [cell.detailTextLabel setTextAlignment:UITextAlignmentCenter];
                [cell.detailTextLabel setText: @"说明"];
        }else if(indexPath.row == 1)
        {
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                [cell.detailTextLabel setTextColor:[UIColor brownColor]];
                [cell.detailTextLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
                [cell.detailTextLabel setTextAlignment:UITextAlignmentCenter];
                [cell.detailTextLabel setText:@"关于"];
        } 
        
        }    
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableview heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 30;
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
