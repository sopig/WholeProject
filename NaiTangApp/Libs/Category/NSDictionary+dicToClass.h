#import <Foundation/Foundation.h>

@interface NSDictionary (TurnToCustomClass)

- (void)turnToClassName:(NSString *)className;
- (NSString *)interfaceCodesForName:(NSString *)className;
- (NSString *)implementCodesForName:(NSString *)className;

@end

