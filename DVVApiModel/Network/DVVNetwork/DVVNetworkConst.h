//
//  DVVNetworkConst.h
//  DVVApiModel
//
//  Created by 大威 on 16/9/10.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <Foundation/Foundation.h>

// NSLog
#ifdef DEBUG

#define DVVNWLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#else

#define DVVNWLog( s, ... )

#endif

@interface DVVNetworkConst : NSObject

@end
