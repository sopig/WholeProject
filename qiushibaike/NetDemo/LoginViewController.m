//
//  LoginViewController.m
//  NetDemo
//
//  Created by 海锋 周 on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
-(void) login:(id)sender;
-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;
-(void) BtnClicked:(id)sender;
@end

@implementation LoginViewController
@synthesize username,password;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
    //糗事列表
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(30, 80, kDeviceWidth-60,200) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn.titleLabel setTextColor:[UIColor brownColor]];
    [btn.titleLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(90, 180, 150, 30)];
    [self.view addSubview:btn];
    
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
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(140, 6, 160, 32)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont: [UIFont fontWithName:@"Arial" size:24]];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:[NSString stringWithFormat:@"登 陆"]];
    [self.view addSubview:label];
    [label release];

}

-(void) BtnClicked:(id)sender
{
     [self dismissModalViewControllerAnimated:YES];
}

-(void) login:(id)sender
{
    //表单提交前的验证
    if (username.text == nil||password.text==nil||[username.text isEqualToString:@""]||[password.text isEqualToString:@""] ) {
        [tooles MsgBox:@"用户名或密码不能为空！"];
		return;
    }
    
    //隐藏键盘
    [username resignFirstResponder];
    [password resignFirstResponder];
    //等待提示
    [tooles showHUD:@"正在登陆...."];
	NSString *urlstr = LoginURLString(username.text, password.text);
	NSURL *myurl = [NSURL URLWithString:urlstr];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:myurl];
	//设置表单提交项
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(GetResult:)];
	[request setDidFailSelector:@selector(GetErr:)];
	[request startAsynchronous];
    
}

   //获取请求结果
- (void)GetResult:(ASIHTTPRequest *)request{	
	
	[tooles removeHUD];
    NSData *data =[request responseData];
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:data error:nil];
    //输出接收到的字符串
	NSString *str = [NSString stringWithUTF8String:[data bytes]];
    NSLog(@"%@",str);
    //判断是否登陆成功
    if ([dictionary objectForKey:@"yes"]) {
		[tooles MsgBox:[dictionary objectForKey:@"yes"]];
		return;
    }else if ([dictionary objectForKey:@"error"] != [NSNull null]) {
		[tooles MsgBox:[dictionary objectForKey:@"error"]];
		return;
	}
	
}

  //连接错误调用这个函数
- (void) GetErr:(ASIHTTPRequest *)request{
    
    [tooles removeHUD];
    [tooles MsgBox:@"网络错误,连接不到服务器"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void) dealloc
{
    [username release];
    [password release];
    [super dealloc];
}


#pragma mark - TableView*

- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString *identifier = @"_QiShiCELL";
        UITableViewCell *cell =(UITableViewCell *) [tableview dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil){
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 0) {
               
                [cell.textLabel setTextColor:[UIColor blackColor]];
                [cell.textLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
                [cell.textLabel setText: @"用户名:"];
                
                username = [[UITextField alloc]initWithFrame:CGRectMake(90, 6, 140, 24)];
                [username setBorderStyle:UITextBorderStyleNone];
                [username setTextColor:[UIColor brownColor]];
                [username setFont:[UIFont fontWithName:@"Arial" size:14]];
                [username setPlaceholder:@"请输入用户名"];
                [cell addSubview:username];
                [username becomeFirstResponder];  //弹出键盘
            }else if(indexPath.row == 1)
            {
                
                [cell.textLabel setTextColor:[UIColor blackColor]];
                [cell.textLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
                [cell.textLabel setText:  @"密   码:"];
               
                password = [[UITextField alloc]initWithFrame:CGRectMake(90, 6, 140, 24)];
                [password setBorderStyle:UITextBorderStyleNone];
                [password setPlaceholder:@"请输入密码"];
                [password setTextColor:[UIColor brownColor]];
                [password setFont:[UIFont fontWithName:@"Arial" size:14]];
                [password setSecureTextEntry:YES];
                [password setReturnKeyType:UIReturnKeyDone];
                [cell addSubview:password];
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
