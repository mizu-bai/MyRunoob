//
//  MZGroup.h
//  Runoob
//
//  Created by mizu-bai on 2021/5/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MZItem;

@interface MZGroup : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *items;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)groupWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
