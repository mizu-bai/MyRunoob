//
//  MZItemCell.h
//  Runoob
//
//  Created by mizu-bai on 2021/5/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MZItem;

@interface MZItemCell : UITableViewCell

@property (nonatomic, strong) MZItem *item;

+ (instancetype)itemCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
