//
//  NT_RepairViewController.m
//  NaiTangApp
//
//  Created by 张正超 on 14-4-14.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_RepairViewController.h"
#import "NT_RepairFirstCell.h"
#import "NT_RepairSecondCell.h"
#import "NT_RepairBottomCell.h"

@interface NT_RepairViewController ()

@end

@implementation NT_RepairViewController

@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLable.font = [UIFont boldSystemFontOfSize:20];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.text = @"闪退修复帮助";
    titleLable.textAlignment = TEXT_ALIGN_CENTER;
    [titleLable sizeToFit];
    self.navigationItem.titleView = titleLable;
    
    //返回按钮
    UIButton *leftBt = [UIButton buttonWithFrame:CGRectMake(0, 0, 44, 44) image:[UIImage imageNamed:@"top-back.png"] target:self action:@selector(gotoBack)];
    [leftBt setImage:[UIImage imageNamed:@"top-back-hover.png"] forState:UIControlStateHighlighted];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    
    if (isIOS7)
    {
        //设置ios7导航栏两边间距，和ios6以下两边间距一致
        UIBarButtonItem *spaceBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        spaceBar.width = -10;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:spaceBar,backItem, nil];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = backItem;
    }

    if (isIOS7)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    }
    else
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    }
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.opaque = YES;
    _tableView.alpha = 1.0f;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //滑动手势
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer];
}

//向右滑动
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"identifier%d",indexPath.row];
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    switch (indexPath.row) {
        case 0:
        {
            if (!cell) {
                cell = [[NT_RepairFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
            break;
        case 1:
        {
            if (!cell) {
                cell = [[NT_RepairSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
            break;
        case 2:
        {
            if (!cell) {
                cell = [[NT_RepairBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            UIButton *repairedButton = (UIButton *)[cell.contentView viewWithTag:456];
            [repairedButton addTarget:self action:@selector(repairedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            UIButton *unrepairedButton = (UIButton *)[cell.contentView viewWithTag:457];
            [unrepairedButton addTarget:self action:@selector(unrepairedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 250;
            break;
        case 1:
            return 546;
            break;
        case 2:
            return 100;
            break;
        default:
            break;
    }
    return 40;
}

//修复有用
- (void)repairedButtonPressed:(id)sender
{
    umengLogRepairedClick++;
    [self.navigationController popViewControllerAnimated:YES];
}

//修复无用
- (void)unrepairedButtonPressed:(id)sender
{
    umengLogNoRepairedClick++;
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)gotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
