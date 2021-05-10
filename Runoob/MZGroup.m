//
//  MZGroup.m
//  Runoob
//
//  Created by mizu-bai on 2021/5/9.
//

#import "MZGroup.h"
#import "MZItem.h"

@implementation MZGroup
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
        // dict -> model
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dictItem in dictionary[@"items"]) {
            MZItem *item = [MZItem itemWithDictionary:dictItem];
            [arrayModels addObject:item];
        }
        self.items = arrayModels;
    }
    return self;
}

+ (instancetype)groupWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}

@end
