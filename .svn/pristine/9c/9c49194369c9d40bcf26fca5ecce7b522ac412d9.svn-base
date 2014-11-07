//
//  UIView+Additions.m
//  WXHL_Weibo1.0
//
//  Created by JayWon on 13-7-1.
//  Copyright (c) 2013年
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

-(UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
    }
    
    return nil;
}

@end
