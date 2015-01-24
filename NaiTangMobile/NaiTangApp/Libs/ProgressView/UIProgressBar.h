//
//  UIProgressBar.h
//  
//
//  Created by xiangwei.ma
//  
//

#import <UIKit/UIKit.h>


@interface UIProgressBar : UIView 
{
	float minValue, maxValue;
	float currentValue;
	UIColor *lineColor, *progressRemainingColor, *progressColor;
}

@property (readwrite) float minValue, maxValue, currentValue;
@property (nonatomic, retain) UIColor *lineColor, *progressRemainingColor, *progressColor;

-(void)setNewRect:(CGRect)newFrame;

@end
