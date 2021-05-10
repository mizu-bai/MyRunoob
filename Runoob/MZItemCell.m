//
//  MZItemCell.m
//  Runoob
//
//  Created by mizu-bai on 2021/5/10.
//

#import "MZItemCell.h"
#import "MZItem.h"

@implementation MZItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(MZItem *)item {
    _item = item;
    self.textLabel.text = item.title;
    self.detailTextLabel.numberOfLines = 0;
    self.detailTextLabel.text = item.detail;
    self.imageView.image = item.image;
}

+ (instancetype)itemCellWithTableView:(UITableView *)tableView {
    static NSString *reuseID = @"items";
    MZItemCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[MZItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}


@end
