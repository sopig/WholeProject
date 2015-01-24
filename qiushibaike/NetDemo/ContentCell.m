//
//  ContentCell.m
//  NetDemo
//
//  Created by 海锋 周 on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ContentCell.h"
#import "CommentsViewController.h"
#define FGOOD       101
#define FBAD        102
#define FCOMMITE    103

@interface ContentCell()
-(void) BtnClicked:(id)sender;
-(void) ImageBtnClicked:(id)sender;
@end;

@implementation ContentCell
@synthesize txtContent,txtAnchor,headPhoto,footView,centerimageView,TagPhoto;
@synthesize commentsbtn,badbtn,goodbtn,imgUrl,txtTag;
@synthesize imgPhoto,imgMidUrl;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
        
        UIImage *centerimage = [UIImage imageNamed:@"block_center_background.png"];
        centerimageView = [[UIImageView alloc]initWithImage:centerimage];
        [centerimageView setFrame:CGRectMake(0, 0, 320, 220)];
        [self addSubview:centerimageView];
 
        
        txtContent = [[UILabel alloc]init];
        [txtContent setBackgroundColor:[UIColor clearColor]];
        [txtContent setFrame:CGRectMake(20, 28, 280, 220)];
        [txtContent setFont:[UIFont fontWithName:@"Arial" size:14]];
        [txtContent setLineBreakMode:UILineBreakModeTailTruncation];
        [self addSubview:txtContent];
    
        imgPhoto = [[EGOImageButton alloc]initWithPlaceholderImage:[UIImage imageNamed:@"thumb_pic.png"] delegate:self];
        [imgPhoto setFrame:CGRectMake(0, 0, 0, 0)];
       
        [imgPhoto addTarget:self action:@selector(ImageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];        
        [self addSubview:imgPhoto];
        
        headPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 24, 24)];
        [headPhoto setImage:[UIImage imageNamed:@"thumb_avatar.png"]];
        [self addSubview:headPhoto];
    
        txtAnchor = [[UILabel alloc]initWithFrame:CGRectMake(45,5, 200, 30)];
        [txtAnchor setText:@"匿名"];
        [txtAnchor setFont:[UIFont fontWithName:@"Arial" size:14]];
        [txtAnchor setBackgroundColor:[UIColor clearColor]];
        [txtAnchor setTextColor:[UIColor brownColor]];
        [self addSubview:txtAnchor];
        
        txtTag = [[UILabel alloc]initWithFrame:CGRectMake(45,200, 200, 30)];
        [txtTag setText:@""];
        [txtTag setFont:[UIFont fontWithName:@"Arial" size:14]];
        [txtTag setBackgroundColor:[UIColor clearColor]];
        [txtTag setTextColor:[UIColor brownColor]];
        [self addSubview:txtTag];
        
        TagPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(15, 200, 24, 24)];
        [TagPhoto setImage:[UIImage imageNamed:@"icon_tag.png"]];
        [self addSubview:TagPhoto];
        
        UIImage *footimage = [UIImage imageNamed:@"block_foot_background.png"];
        footView = [[UIImageView alloc]initWithImage:footimage];
        [footView setFrame:CGRectMake(0, txtContent.frame.size.height, 320, 15)];
        [self addSubview:footView];
       
        //添加Button，顶，踩，评论  
        goodbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [goodbtn setFrame:CGRectMake(10,txtContent.frame.size.height-30,70,32)];
        [goodbtn setBackgroundImage:[UIImage imageNamed:@"button_vote.png"] forState:UIControlStateNormal];
        [goodbtn setBackgroundImage:[UIImage imageNamed:@"button_vote_active.png"] forState:UIControlStateHighlighted];
        [goodbtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 25)];
        [goodbtn setImage:[UIImage imageNamed:@"icon_for_good.png"] forState:UIControlStateNormal];
        [goodbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -25)];
        [goodbtn setTitle:@"0" forState:UIControlStateNormal];
        [goodbtn.titleLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
        [goodbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [goodbtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:goodbtn];
        
       badbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [badbtn setFrame:CGRectMake(100,txtContent.frame.size.height-30,70,32)];
        [badbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -25)];
        [badbtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 25)];
        [badbtn setBackgroundImage:[UIImage imageNamed:@"button_vote.png"] forState:UIControlStateNormal];
        [badbtn setBackgroundImage:[UIImage imageNamed:@"button_vote_active.png"] forState:UIControlStateHighlighted];
        [badbtn setImage:[UIImage imageNamed:@"icon_for_bad.png"] forState:UIControlStateNormal];
        [badbtn setTitle:@"0" forState:UIControlStateNormal];
        [badbtn.titleLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
        [badbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [badbtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:badbtn];
        
        commentsbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [commentsbtn setFrame:CGRectMake(230,txtContent.frame.size.height-30,70,32)];
        [commentsbtn setBackgroundImage:[UIImage imageNamed:@"button_vote.png"] forState:UIControlStateNormal];
        [commentsbtn setBackgroundImage:[UIImage imageNamed:@"button_vote_active.png"] forState:UIControlStateHighlighted];
        [commentsbtn setImage:[UIImage imageNamed:@"icon_for_comment.png"] forState:UIControlStateNormal];
        [commentsbtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 25)];
        [commentsbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -25)];
        [commentsbtn.titleLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
        [commentsbtn setTitle:@"0" forState:UIControlStateNormal];
        [commentsbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [commentsbtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [commentsbtn setTag:FCOMMITE];
        [self addSubview:commentsbtn];
     
    }
    return self;
}


-(void) resizeTheHeight
{   
    CGFloat contentWidth = 280;  
 
    UIFont *font = [UIFont fontWithName:@"Arial" size:14];  
    
    CGSize size = [txtContent.text sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 220) lineBreakMode:UILineBreakModeTailTruncation];  
    
    [txtContent setFrame:CGRectMake(20, 28, 280, size.height+60)];
    
    if (imgUrl!=nil&&![imgUrl isEqualToString:@""]) {
       [imgPhoto setFrame:CGRectMake(30, size.height+70, 72, 72)];
       [centerimageView setFrame:CGRectMake(0, 0, 320, size.height+200)];
       [imgPhoto setImageURL:[NSURL URLWithString:imgUrl]];
       [self imageButtonLoadedImage:imgPhoto];
    }
    else
    {
        [imgPhoto cancelImageLoad];
       [imgPhoto setFrame:CGRectMake(120, size.height, 0, 0)];
        [centerimageView setFrame:CGRectMake(0, 0, 320, size.height+120)];
    }
    
    [footView setFrame:CGRectMake(0, centerimageView.frame.size.height, 320, 15)];
    [goodbtn setFrame:CGRectMake(10,centerimageView.frame.size.height-28,70,32)];
    [badbtn setFrame:CGRectMake(100,centerimageView.frame.size.height-28,70,32)];
    [commentsbtn setFrame:CGRectMake(230,centerimageView.frame.size.height-28,70,32)];
    [txtTag setFrame:CGRectMake(40,centerimageView.frame.size.height-50,200, 30)];
    [TagPhoto setFrame:CGRectMake(15,centerimageView.frame.size.height-50,24, 24)];
    
}

-(void) ImageBtnClicked:(id)sender
{
    PhotoViewer *photoview = [[PhotoViewer alloc]initWithNibName:@"PhotoViewer" bundle:nil];
    [photoview.view setFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
    [[[UIApplication sharedApplication]keyWindow] addSubview:photoview.view];
    photoview.imgUrl = self.imgMidUrl;
    [photoview fadeIn];
}

-(void) BtnClicked:(id)sender
{
    UIButton *btn =(UIButton *) sender;
    switch (btn.tag) {
        case FGOOD:    //顶
        {
            
        }break;
        case FBAD:     //踩 
        {
            
        }break;
        case FCOMMITE: //评论 
        {
           
       
        }break;
        default:
            break;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) dealloc
{
    [txtContent release];
    [txtAnchor release];
    [centerimageView release];
    [imgPhoto release];
    [TagPhoto release];
    [footView release];
    [goodbtn release];
    [badbtn release];
    [commentsbtn release];
    [txtTag release];
    [super dealloc];
}

#pragma mark - delegate

- (void)imageButtonLoadedImage:(EGOImageButton*)imageButton
{
     // NSLog(@" Did finish load %@",imgUrl);
    UIImage *image = imageButton.imageView.image;
    CGFloat w = 1.0f;
    CGFloat h = 1.0f;
    if (image.size.width>280) {
        w = image.size.width/280;
    }
    if (image.size.height>72) {
        h = image.size.height/72;
    }
    CGFloat scole = w>h ? w:h;
    
    CGRect rect = CGRectMake(30 ,imageButton.frame.origin.y,image.size.width/scole,image.size.height/scole);
    [imgPhoto setFrame:rect];
   
}

- (void)imageButtonFailedToLoadImage:(EGOImageButton*)imageButton error:(NSError*)error;
{
    [imageButton cancelImageLoad];
    //NSLog(@"Failed to load %@", imgUrl);
}
@end
