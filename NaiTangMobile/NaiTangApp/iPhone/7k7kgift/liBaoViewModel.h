//
//  liBaoViewModel.h
//  libao
//
//  Created by wangxing on 14-3-3.
//  Copyright (c) 2014年 wangxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface liBaoViewModel : NSObject

/**
 * @brief 单例 获取礼包数据
 */
+ (liBaoViewModel *)shareLibaoViewModel;

/**
 * @brief 根据type获取对应的plist的文件地址
 * type的值有：
 *      list 礼包
 *      my   我的礼包
 */
+ (NSString *)dataFilePathWithType:(NSString *)type;

/**
 * @brief 根据type获取指定缓存的文件，type的取值同上
 */
+ (id) getCachedLibaoDataWithType:(NSString *)type;

/**
 * @brief 根据type往指定的plist文件里面写入array，type的取值同上
 */
+ (void) setPlistLibaoDataOfType:(NSString *)type withArray:(NSArray *)array;


/**
 * @brief 检测对应的列表是否有本地数据
 */
- (BOOL)checkDataWithType:(NSString *)type;

/**
 * @brief 把服务器器传递过来的列表数据映射为本地需要的格式
 */
- (NSMutableArray *)mappingRemoteListDataToLocal:(id)data;

/**
 * @brief 获取对应列表的id，生成一个列表
 */
-(NSArray *)getIdListWithType:(NSString *)type orArray:(NSMutableArray *)array;

/**
 * @brief 读取本地文件，更新数据
 */
- (void) updateDataFromPlistWithType:(NSString *)type;


/**
 * @brief 设置当前table中使用的数据源
 */
- (void) setTableListLibaoDataOfType:(NSString *)type withArray:(NSMutableArray *)array;

/**
 * @brief 获取当前table中使用的数据源
 */
- (NSMutableArray *) getTableListLibaoDataOfType:(NSString *)type;


/**
 * @brief 根据giftId和type返回对应的数据源
 */
- (id) getDataWithGiftId:(NSString *)giftId type:(NSString *)type;

/**
 * @brief 根据最新的总数和剩余数量 更新list
 */
- (void) updateListWithRealData:(NSArray *)realNum List:(NSMutableArray *)arr;
@end
