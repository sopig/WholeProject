//
//  PhotoViewer.m
//  NetDemo
//
//  Created by 海锋 周 on 12-6-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PhotoViewer.h"
@interface PhotoViewer()
-(void) BtnClicked:(id)sender;
-(void)handlePan:(UIPanGestureRecognizer *)recognizer;
-(void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *) contextInfo; 
@end

@implementation PhotoViewer
@synthesize imgUrl,imageView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor blackColor]];
        roation = 0;
        scale = 1;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    imageView = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"thumb_pic.png"] delegate:self];
    [imageView setFrame:CGRectMake(20,50,300,300)];
    [self.view addSubview:imageView];
  
    NSArray *array = [NSArray arrayWithObjects:@"rotate_left",@"rotate_right",@"zoom_in",@"zoom_out",nil];
    for (int i=0; i<[array count]; i++) 
    {
        UIImage *normal = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[array objectAtIndex:i]]];
        UIImage *active = [[UIImage imageNamed:@"imageviewer_toolbar_background.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(60+50*i,420,52,40)];
        [btn setImage:normal forState:UIControlStateNormal];
        [btn setBackgroundImage:active forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:i];
        [self.view addSubview:btn];
        [normal release];
        [active release];
    }
    
    UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbtn setFrame:CGRectMake(0,10,100,40)];
    [backbtn setImageEdgeInsets:UIEdgeInsetsMake(0,2,0,0)];
    [backbtn setTitleEdgeInsets:UIEdgeInsetsMake(2,-2,0,0)];
    [backbtn setImage:[UIImage imageNamed:@"imageviewer_return.png"] forState:UIControlStateNormal];
      [backbtn setTitle:@"返回" forState:UIControlStateNormal];
    [backbtn setBackgroundImage:[[UIImage imageNamed:@"imageviewer_toolbar_background.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [backbtn setTag:4];
    [backbtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbtn];
    
    UIButton *savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [savebtn setFrame:CGRectMake(220,10,100,40)];
    [savebtn setImageEdgeInsets:UIEdgeInsetsMake(0,2,0,0)];
    [savebtn setTitleEdgeInsets:UIEdgeInsetsMake(2,-2,0,0)];
    [savebtn setImage:[UIImage imageNamed:@"imageviewer_save.png"] forState:UIControlStateNormal];
     [savebtn setTitle:@"保存" forState:UIControlStateNormal];
    [savebtn setBackgroundImage:[[UIImage imageNamed:@"imageviewer_toolbar_background.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [savebtn setTag:5];
    [savebtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:savebtn];
    
    [imageView setUserInteractionEnabled:YES];
    UIPanGestureRecognizer *panRcognize=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panRcognize setMinimumNumberOfTouches:1];
    panRcognize.delegate=self;
    [panRcognize setEnabled:YES];
    [panRcognize delaysTouchesEnded];
    [panRcognize cancelsTouchesInView];
    
    UIPinchGestureRecognizer *pinchRcognize=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [pinchRcognize setEnabled:YES];
    [pinchRcognize delaysTouchesEnded];
    [pinchRcognize cancelsTouchesInView];
    
    UIRotationGestureRecognizer *rotationRecognize=[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
    [rotationRecognize setEnabled:YES];
    [rotationRecognize delaysTouchesEnded];
    [rotationRecognize cancelsTouchesInView];
    rotationRecognize.delegate=self;
    pinchRcognize.delegate=self;
    
    [imageView addGestureRecognizer:rotationRecognize];
    [imageView addGestureRecognizer:panRcognize];
    [imageView addGestureRecognizer:pinchRcognize];
}

-(void) BtnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 0:  //向左
        {
            [UIView animateWithDuration:0.5f animations:^{
                roation -=M_PI_2;
                imageView.transform = CGAffineTransformMakeRotation(roation);
            }];
        }
            break;
        case 1:  //向右
        {
            
            [UIView animateWithDuration:0.5f animations:^{
                roation +=M_PI_2;
                imageView.transform = CGAffineTransformMakeRotation(roation);
            }];
        }
            break;
        case 2:  //放大
        {
            [UIView animateWithDuration:0.5f animations:^{
                scale*=1.5;
                imageView.transform = CGAffineTransformMakeScale(scale,scale);
            }];
        }
            break;
        case 3:  //缩小
        {
            [UIView animateWithDuration:0.5f animations:^{
                scale/=1.5;
                imageView.transform = CGAffineTransformMakeScale(scale,scale);
            }];
        }
            break;
        case 4://返回
        {
            [self fadeOut];
        }
            break;
        case 5://保存.
        {
            //调用方法保存到相册的代码  
           UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);  
            
        }
            break;
        default:
            break;
    }
   
}

//实现类中实现  
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *) contextInfo 
{  
    NSString *message;  
    NSString *title;  
    if (!error) {  
        title = @"成功提示";  
        message = [NSString stringWithFormat:@"成功保存到相冊"];  
    } else {  
        title = @"失败提示";  
        message = [error description];  
    }  
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title  
                                                message:message  
                                                   delegate:nil  
                                                cancelButtonTitle:@"知道了"  
                                          otherButtonTitles:nil];  
    [alert show];  
    [alert release];  
}  



/*   
 *  移动图片处理的函数
 *  @recognizer 移动手势
 */
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.view];
    
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];

}
/*
 * handPinch 缩放的函数
 * @recognizer UIPinchGestureRecognizer 手势识别器
 */
- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer{
  
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
   
    recognizer.scale = 1;
    
}

/*
 * handleRotate 旋转的函数
 * recognizer UIRotationGestureRecognizer 手势识别器
 */
- (void)handleRotate:(UIRotationGestureRecognizer *)recognizer{
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)imageViewLoadedImage:(EGOImageView*)imageview
{
    CGFloat w = 1.0f;
    CGFloat h = 1.0f;
    if (imageview.image.size.width>300) {
        w = imageview.image.size.width/300;
    }
    if (imageview.image.size.height>400) {
        h = imageview.image.size.height/400;
    }
    CGFloat scole = w>h ? w:h;
    
    CGRect rect = CGRectMake(0, 0,imageview.image.size.width/scole,imageview.image.size.height/scole);
    [imageView setFrame:rect];
    imageView.center = self.view.center;
}

- (void)imageViewFailedToLoadImage:(EGOImageView*)imageview error:(NSError*)error
{
    [self.imageView cancelImageLoad];
    NSLog(@"Failed to load %@", imgUrl);
}


-(void) fadeIn
{   
    CGRect rect = [[UIScreen mainScreen] bounds];
      self.view.center = CGPointMake(rect.size.width/2, 720);
    [UIView animateWithDuration:0.5f animations:^{
         self.view.center = CGPointMake(rect.size.width/2, 240+10);  
    } completion:^(BOOL finished) {
        [imageView setImageURL:[NSURL URLWithString:imgUrl]];
    }];
}

-(void) fadeOut
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    [UIView animateWithDuration:0.5f animations:^{
        self.view.center = CGPointMake(rect.size.width/2, 720);
    } completion:^(BOOL finished) {
        [imageView cancelImageLoad];
        [imageView release];
        [imgUrl release];
        imageView = nil;
        imgUrl = nil;
        [self.view removeFromSuperview];
    }];
}



@end
