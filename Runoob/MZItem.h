//
//  MZItem.h
//  Runoob
//
//  Created by mizu-bai on 2021/5/9.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MZItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *imageBase64;
@property (nonatomic, copy) NSString *detail;

@property (nonatomic, readonly) UIImage *image;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)itemWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
