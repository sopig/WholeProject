//
//  NT_BUIView.h
//  NaiTangApp
//
//  Created by 张正超 on 14-2-26.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  处理弹出框

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface UIView (NT_BUIView) <UIAlertViewDelegate,UIActionSheetDelegate>
//UIAlertView
-(void)showWithCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;



//UIActionSheet
-(void)showInView:(UIView *)view withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

-(void)showFromToolbar:(UIToolbar *)view withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

-(void)showFromTabBar:(UITabBar *)view withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

-(void)showFromRect:(CGRect)rect
             inView:(UIView *)view
           animated:(BOOL)animated
withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

-(void)showFromBarButtonItem:(UIBarButtonItem *)item
                    animated:(BOOL)animated
       withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;
//

@end


/*使用方法
 UIImagePickerController *controller = [[[UIImagePickerController alloc] init] autorelease];
 controller.allowsEditing = YES;
 [controller presentFromController:self
 onPhontePicked:^(UIImage *chosenImage) {
 NSLog(@"%@",NSStringFromCGSize(chosenImage.size));
 } onCancel:^{
 NSLog(@"canceled");
 }];
 */
typedef void (^YSCancelBlock)();
typedef void (^YSPhotoPickedBlock)(UIImage *chosenImage);

@interface UIImagePickerController(YSBlock)<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

+ (void)photoPickerSelectTypeAndShowWithPresentVC:(UIViewController *)presentVC
                                   onPhontePicked:(YSPhotoPickedBlock)photoPicked
                                         onCancel:(YSCancelBlock)cancelled;
+ (UIImagePickerController *)photoPickerWithSourceType:(UIImagePickerControllerSourceType)type
                                             presentVC:(UIViewController *)presentVC
                                        onPhontePicked:(YSPhotoPickedBlock)photoPicked
                                              onCancel:(YSCancelBlock)cancelled;
- (void)presentFromController:(UIViewController *)presentVC
               onPhontePicked:(YSPhotoPickedBlock)photoPicked
                     onCancel:(YSCancelBlock)cancelled;


@property (nonatomic, copy) YSPhotoPickedBlock photoPickedBlock;
@property (nonatomic, copy) YSCancelBlock cancelBlock;

@end
