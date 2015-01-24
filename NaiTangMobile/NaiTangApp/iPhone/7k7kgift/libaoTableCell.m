//
//  libaoTableCell.m
//  libao
//
//  Created by wangxing on 14-2-27.
//  Copyright (c) 2014年 wangxing. All rights reserved.
//

#import "libaoTableCell.h"

@implementation libaoTableCell

@synthesize gameIcon;
@synthesize gameName;
@synthesize libaoDescription;
@synthesize libaoInfo;
@synthesize libaoActionButton;
@synthesize libaoIcon;
@synthesize libaoNumRest;
@synthesize libaoNumTotal;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        gameIcon = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"place-hold-img-icon.png"]];
        gameIcon.frame = CGRectMake(10, 10, 65, 65);
        gameIcon.layer.cornerRadius = 15.0;
        gameIcon.layer.borderWidth = 0;
        gameIcon.layer.masksToBounds = YES;
        gameIcon.contentMode = UIViewContentModeScaleAspectFill;
        gameIcon.backgroundColor = [UIColor clearColor];
        [self addSubview:gameIcon];
        
        
        gameName = [[UILabel alloc]initWithFrame:CGRectMake(80, 12, 190, 24)];
        gameName.textColor = [[UIColor alloc] initWithRed:80.0f/250.0f green:90.0f/250.0f blue:95.0f/250.0f alpha:1];
        gameName.textAlignment = NSTextAlignmentLeft;
        gameName.adjustsFontSizeToFitWidth = NO;
        gameName.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:15.0f];
        [self addSubview:gameName];
        
        libaoIcon = [[UIImageView alloc] initWithFrame:CGRectMake(84, 41, 8, 10)];
        libaoIcon.image = [UIImage imageNamed:@"icon-blue-gift.png"];
        libaoIcon.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:libaoIcon];
        
        libaoDescription = [[UILabel alloc]initWithFrame:CGRectMake(95, 36, 190, 24)];
        libaoDescription.textColor = [[UIColor alloc] initWithRed:140.0f/250.0f green:149.0f/250.0f blue:153.0f/250.0f alpha:1];
        libaoDescription.textAlignment = NSTextAlignmentLeft;
        libaoDescription.adjustsFontSizeToFitWidth = NO;
        libaoDescription.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12.0f];
        [self addSubview:libaoDescription];

        
        libaoInfo = [[UILabel alloc]initWithFrame:CGRectMake(84, 52, 190, 24)];
        libaoInfo.textColor = [[UIColor alloc] initWithRed:140.0f/250.0f green:149.0f/250.0f blue:153.0f/250.0f alpha:1];
        libaoInfo.textAlignment = NSTextAlignmentLeft;
        libaoInfo.adjustsFontSizeToFitWidth = NO;
        libaoInfo.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12.0f];
        libaoInfo.text = @"库存：";
        [self addSubview:libaoInfo];
        
        libaoNumRest = [[UILabel alloc] initWithFrame:CGRectMake(120, 59, 20, 24)];
        libaoNumRest.textColor = [UIColor colorWithRed:30.0f/250.0 green:181.0f/250.0 blue:247.0f/250.0 alpha:1];
        libaoNumRest.textAlignment = NSTextAlignmentRight;
        libaoNumRest.adjustsFontSizeToFitWidth = NO;
        libaoNumRest.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12.0f];
        libaoNumRest.hidden = YES;
        [self addSubview:libaoNumRest];
        
        libaoNumTotal = [[UILabel alloc] initWithFrame:CGRectMake(140, 59, 30, 24)];
        libaoNumTotal.textColor = [UIColor colorWithRed:30.0f/250.0 green:181.0f/250.0 blue:247.0f/250.0 alpha:1];
        libaoNumTotal.textAlignment = NSTextAlignmentLeft;
        libaoNumTotal.adjustsFontSizeToFitWidth = NO;
        libaoNumTotal.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12.0f];
        libaoNumTotal.hidden = YES;
        [self addSubview:libaoNumTotal];
    
        
        libaoActionButton = [[UIButton alloc]initWithFrame:CGRectMake(240, 28, 67, 29)];
        libaoActionButton.layer.cornerRadius = 5.0;
        libaoActionButton.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:12.0f];
//        libaoActionButton.backgroundColor = [UIColor greenColor];
        [self addSubview:libaoActionButton];
        
        self.frame = CGRectMake(0, 0, 320, 85);
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    // superView不存在的时候，取消正在下载的图片
    if (!newSuperview) {
        [self.gameIcon cancelImageLoad];
    }
}
- (void)setImageURL:(NSString *)imageURL
{
//    NSLog(@"%@",imageURL);
    self.gameIcon.imageURL = [NSURL URLWithString:imageURL];
}
- (void)setImageURL:(NSString *)imageURL strTemp:(NSString *)temp
{
    [self.gameIcon imageUrl:[NSURL URLWithString:imageURL] tempSTR:temp];
}


- (void)renderCellWithData:(NSDictionary *) data andType:(NSString *)type
{
    if ([type isEqualToString:@"list"]) {
        // 根据giftId标识button，方便后面点击事件的响应
        self.libaoActionButton.tag = [[data objectForKey:@"giftId"] intValue];
        
        // 渲染库存数和总数
        self.libaoNumRest.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"libaoResidue"]];
        [self.libaoNumRest sizeToFit];
        self.libaoNumRest.hidden = NO;
        self.libaoNumTotal.text = [NSString stringWithFormat:@"/%@", [data objectForKey:@"libaoTotal"]];
        [self.libaoNumTotal sizeToFit];
        self.libaoNumTotal.hidden = NO;
        
        CGRect restFrame = self.libaoNumRest.frame;
        CGRect totalFrame = self.libaoNumTotal.frame;
        totalFrame.origin.x = restFrame.origin.x + restFrame.size.width;
        self.libaoNumTotal.frame = totalFrame;
      
        
        
        self.libaoDescription.text = [data objectForKey:@"libaoDescription"];
        self.gameName.text = [data objectForKey:@"gameName"];
        [self.libaoActionButton setTitle:[data objectForKey:@"buttonWord"] forState:UIControlStateNormal];
        
        // 游戏图标
        [self setImageURL:[data objectForKey:@"gameIcon"]];
        
        
        
        
        UIEdgeInsets inset = UIEdgeInsetsMake(8, 8, 8, 8);
        
        // 判断领取按钮的状态
        if ([[data objectForKey:@"buttonState"] isEqual:@"0"]) {
            // 可以领取
            UIImage * btnGreen = [UIImage imageNamed:@"btn-green-stretchable.png"];
            UIImage * btnGreenHover = [UIImage imageNamed:@"btn-green-hover-stretchable.png"];
            UIImage * btnGreenStretchable = [btnGreen resizableImageWithCapInsets:inset];
            UIImage * btnGreenHoverStretchable = [btnGreenHover resizableImageWithCapInsets:inset];
            [self.libaoActionButton setBackgroundImage:btnGreenStretchable forState:UIControlStateNormal];
            [self.libaoActionButton setBackgroundImage:btnGreenHoverStretchable forState:UIControlStateHighlighted];
        }else{
            // 已领取/领取完了
            UIImage * btnGray = [UIImage imageNamed:@"btn-gray-stretchable.png"];
            UIImage * btnGrayHover = [UIImage imageNamed:@"btn-gray-hover-stretchable.png"];
            UIImage * btnGrayStretchable = [btnGray resizableImageWithCapInsets:inset];
            UIImage * btnGrayHoverStretchable = [btnGrayHover resizableImageWithCapInsets:inset];
            [self.libaoActionButton setBackgroundImage:btnGrayStretchable forState:UIControlStateNormal];
            [self.libaoActionButton setBackgroundImage:btnGrayHoverStretchable forState:UIControlStateHighlighted];
        }

    }else{
        // 我的礼包
        
        
        
        // 根据giftId标识button，方便后面点击事件的响应
        self.libaoActionButton.tag = [[data objectForKey:@"giftId"] intValue];
        self.libaoInfo.text = [data objectForKey:@"libaoKey"];
        self.libaoInfo.textColor = [UIColor blueColor];
        self.libaoDescription.text = [data objectForKey:@"libaoDescription"];
        self.gameName.text = [data objectForKey:@"gameName"];
        [self setImageURL:[data objectForKey:@"gameIcon"]];
        
        
        UIImage * btnBlue = [UIImage imageNamed:@"btn-blue-stretchable.png"];
        UIImage * btnBlueHover = [UIImage imageNamed:@"btn-blue-hover-stretchable.png"];
        UIEdgeInsets inset = UIEdgeInsetsMake(8, 8, 8, 8);
        UIImage * btnBlueStretchable = [btnBlue resizableImageWithCapInsets:inset];
        UIImage * btnBlueHoverStretchable = [btnBlueHover resizableImageWithCapInsets:inset];
        [self.libaoActionButton setBackgroundImage:btnBlueStretchable forState:UIControlStateNormal];
        [self.libaoActionButton setBackgroundImage:btnBlueHoverStretchable forState:UIControlStateHighlighted];
        
        
    }
}



@end
