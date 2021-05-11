//
// Created by mizu-bai on 2021/5/11.
//

#import "NSString+Sandbox.h"


@implementation NSString (Sandbox)

- (instancetype)appendCache {
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[self lastPathComponent]];
}

- (instancetype)appendTemp {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:[self lastPathComponent]];
}

- (instancetype)appendDocument {
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[self lastPathComponent]];
}


@end