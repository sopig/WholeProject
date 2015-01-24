//
//  SwitchTableView.h
//  GAMENEWS
//
//  Created by 小远子 on 14-2-27.
//  Copyright (c) 2014年 Hua Wang. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SwitchTableView : NSObject


+ (SwitchTableView *)shareSwitchTableViewData;



@property (nonatomic, strong) NSString *segUrlStr;
@property (nonatomic, strong) NSString *monUrlStr;
@property (nonatomic, strong) NSString *magUrlStr;
@property (nonatomic, strong) NSString *sceUrlStr;
@property (nonatomic, strong) NSString *candyUrlStr;



- (BOOL)isConnectionAvailable;
- (NSString *)dealPicOrMovieUrl:(NSString *)url requestNum:(int)requestNum;
- (NSString *)dealPicUrl:(NSString *)url requestNum:(int)requestNum;

@end
