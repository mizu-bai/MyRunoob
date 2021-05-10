//
//  MZItem.m
//  Runoob
//
//  Created by mizu-bai on 2021/5/9.
//
//

#import "MZItem.h"

@implementation MZItem

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (instancetype)itemWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}

- (UIImage *)image {
    NSRange range = [self.imageBase64 rangeOfString:@"data:image/png;base64,"];
    NSString *base64WithoutHead = [self.imageBase64 substringFromIndex:range.location + range.length];
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:base64WithoutHead options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *image = [UIImage imageWithData:imageData];
    return [self scaleImage:image ToSize:CGSizeMake(45, 45)];
}

- (UIImage *)scaleImage:(UIImage *)image ToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


@end
