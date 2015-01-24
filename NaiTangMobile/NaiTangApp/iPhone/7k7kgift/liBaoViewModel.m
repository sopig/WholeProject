//
//  liBaoViewModel.m
//  libao
//
//  Created by wangxing on 14-3-3.
//  Copyright (c) 2014年 wangxing. All rights reserved.
//

#import "liBaoViewModel.h"

static liBaoViewModel * libaoViewModelData = nil;

@interface liBaoViewModel()
{
    
}

@property (nonatomic, strong) NSMutableArray * listLibaoData;
@property (nonatomic, strong) NSMutableArray * myLibaoData;


@end

@implementation liBaoViewModel

@synthesize listLibaoData;
@synthesize myLibaoData;


#pragma mark class method

+ (liBaoViewModel *)shareLibaoViewModel
{
    @synchronized (self)
    {
        if(libaoViewModelData == nil){
//            NSLog(@"init liBaoViewModel");
            libaoViewModelData = [[liBaoViewModel alloc] init];
        }
    }
    
    return libaoViewModelData;
}


+ (NSString *)dataFilePathWithType:(NSString *)type
{
    NSString * fileName = [NSString stringWithFormat:@"%@Libao.plist",type];
    

    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = paths[0];

    NSString * filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSError * error = nil;
    
    // 如果文件不存在，则创建到文件所需要的所有文件夹
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
//        NSLog(@"create file at that path:%@",documentsDirectory);
        [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    return filePath;
    
}



+ (id) getCachedLibaoDataWithType:(NSString *)type
{
//    NSLog(@"%s",__func__);
    
    NSString * filePath = [liBaoViewModel dataFilePathWithType:type];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        NSMutableArray * arr = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
//        NSLog(@"file exit！curr cached for type: %@ is %@",type,arr);
        return arr;
    }else{
//        NSLog(@"file isn't exit");
        return nil;
    }
}



+ (void) setPlistLibaoDataOfType:(NSString *)type withArray:(NSArray *)array
{
    NSString * filePath = [liBaoViewModel dataFilePathWithType:type];
    
    if (![array writeToFile:filePath atomically:YES]) {
//        NSLog(@"write plist fail for type: %@ with data: %@",type,array);
    }else{
//        NSLog(@"write file success for type: %@",type);
    }
    
}


#pragma mark instance method

- (id)init
{
    self = [super init];
    if(self){
        // 从myLibao.plist中读取用户数据
        myLibaoData = [[NSMutableArray alloc] initWithCapacity:0];
        [self updateDataFromPlistWithType:@"my"];
        listLibaoData = [[NSMutableArray alloc] initWithCapacity:0];
        
    }
    
    
    return self;
}

- (BOOL)checkDataWithType:(NSString *)type
{
    if([type  isEqual: @"list"]){
        if([listLibaoData count] == 0){
            return NO;
        }else{
            return YES;
        }
    }else{
        if([myLibaoData count] == 0){
            return NO;
        }else{
            return YES;
        }
    }
}



-(NSArray *)getIdListWithType:(NSString *)type orArray:(NSMutableArray *)array
{
    NSInteger i;
    NSInteger len;
    NSMutableArray * res = [[NSMutableArray alloc] initWithCapacity:0];
    NSString * giftId;
    NSDictionary * game;
    NSMutableArray * arr;
    
    if ([array count] != 0) {
        arr = array;
    }else{
        if ([type isEqualToString:@"list"]) {
            arr = listLibaoData;
        }else{
            arr = myLibaoData;
        }
    }
    

    
    len = [arr count];
    
    for(i = 0;i<len;i++){
        game = [arr objectAtIndex:i];
        giftId = [game objectForKey:@"giftId"];
        

        [res addObject:giftId];

    }

    NSLog(@"now the %@libaoIdlist is: %@",type,res);
    
    return res;
}


- (void)updateDataFromPlistWithType:(NSString *)type
{
    if([type isEqual:@"list"]){
        if([[NSFileManager defaultManager] fileExistsAtPath:[liBaoViewModel dataFilePathWithType:@"list"]]){
            listLibaoData = [liBaoViewModel getCachedLibaoDataWithType:@"list"];
        }else{
            listLibaoData = [NSMutableArray arrayWithCapacity:0];
        }
    }else{
        if([[NSFileManager defaultManager] fileExistsAtPath:[liBaoViewModel dataFilePathWithType:@"my"]]){
            myLibaoData = [liBaoViewModel getCachedLibaoDataWithType:@"my"];
        }else{
            myLibaoData = [NSMutableArray arrayWithCapacity:0];
        }
    }
}


- (NSMutableArray *)mappingRemoteListDataToLocal:(id)data
{
    NSArray * array = [[data objectForKey:@"main"] objectForKey:@"list"];
    NSMutableArray * emptyArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray * myLibaoIdList = [self getIdListWithType:@"my" orArray: emptyArr];
    NSUInteger i;
    NSInteger len = [array count];
    NSMutableArray * res = [[NSMutableArray alloc] initWithCapacity:0];
    NSDictionary * game;
    NSString * giftId;
    
    
    for(i=0; i<len; i++){
        NSMutableDictionary * obj = [[NSMutableDictionary alloc] initWithCapacity:0];
        game =[array objectAtIndex:i];
        giftId = [game objectForKey:@"giftId"];
        
        [obj setObject:giftId forKey:@"giftId"];
        [obj setObject:[game objectForKey:@"gameName"] forKey:@"gameName"];
        [obj setObject:[game objectForKey:@"icon"] forKey:@"gameIcon"];
        [obj setObject:[game objectForKey:@"url"] forKey:@"gameUrl"];
        [obj setObject:[game objectForKey:@"giftName"] forKey:@"libaoDescription"];
        [obj setObject:[game objectForKey:@"totalCount"] forKey:@"libaoTotal"];
        [obj setObject:[game objectForKey:@"restCount"] forKey:@"libaoResidue"];
        
        
        // 如果当前礼包已经被领取过
        if([myLibaoIdList containsObject:giftId]){
            [obj setObject:@"已领取" forKey:@"buttonWord"];
            
            // 已领取
            [obj setObject:@"1" forKey:@"buttonState"];
        }else{
            [obj setObject:@"立即领取" forKey:@"buttonWord"];
            if([[game objectForKey:@"restCount"] intValue] <= 0){
                
                // 可以领取，但是没有礼包了
                [obj setObject:@"2" forKey:@"buttonState"];
            }else{
                
                // 可以领取，礼包剩余数量足够
                [obj setObject:@"0" forKey:@"buttonState"];
            }
            
        }
        
        [res addObject:obj];
    }
    
//    NSLog(@"mappingRemoteListDataToLocal result is: %@",res);
    
    return res;
    
}

- (void) setTableListLibaoDataOfType:(NSString *)type withArray:(NSMutableArray *)array
{
    if([type isEqual:@"list"]){
        [listLibaoData addObjectsFromArray:array];
    }else{
        [myLibaoData addObjectsFromArray:array];
    }
}


- (NSMutableArray *) getTableListLibaoDataOfType:(NSString *)type
{
    if([type isEqual:@"list"]){
        return listLibaoData;
    }else
        return myLibaoData;
}

- (id) getDataWithGiftId:(NSString *)giftId type:(NSString *)type
{
    NSMutableArray * arr;
    int i,len;
    if([type isEqual:@"list"]){
        arr = listLibaoData;
    }else{
        arr = myLibaoData;
    }
    
//    NSLog(@"current source data is: %@, current giftId is: %@", arr, giftId);
    
    len = [arr count];
    for (i=0; i<len; i++) {
        NSMutableDictionary * dic = [arr objectAtIndex:i];
        if ( [[dic objectForKey:@"giftId"] isEqual:giftId] ) {
            return dic;
        }
        
    }
    
    return nil;
    
}


- (void) updateListWithRealData:(NSArray *)realNum List:(NSMutableArray *)arr
{
    

    int i,len;
    len = [realNum count];
    
    // 遍历，更新库存和总数
    for (i = 0; i<len; i++) {
        NSMutableDictionary * gameItemData = [arr objectAtIndex:i];
        NSDictionary * realData = [realNum objectAtIndex:i];
        
        [gameItemData setObject:[realData objectForKey:@"rest"] forKey:@"libaoResidue"];
        [gameItemData setObject:[realData objectForKey:@"total"] forKey:@"libaoTotal"];
        
        // 针对没有领取过的，进行按钮状态的更新
        if (![[gameItemData objectForKey:@"buttonState"] isEqualToString:@"1"]) {
            if ([[gameItemData objectForKey:@"libaoResidue"] intValue] <= 0) {
                // 可以领取，但是没有礼包了
                [gameItemData setObject:@"2" forKey:@"buttonState"];
            }else{
                // 可以领取
                [gameItemData setObject:@"0" forKey:@"buttonState"];
            }
        }
    }
    
    
    NSLog(@"after realNum : %@",arr);
    
//    return arr;
}

@end
