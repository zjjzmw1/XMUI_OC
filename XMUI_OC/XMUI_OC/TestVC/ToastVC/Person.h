//
//  Person.h
//  XMUI_OC
//
//  Created by zhangmingwei6 on 2023/2/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, copy) void (^testBlock) (void);

@end

NS_ASSUME_NONNULL_END
