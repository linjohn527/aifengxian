//
//  CategoryCell.m
//  LoveBeeFresh
//
//  Created by linjohn on 5/19/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "CategoryCell.h"
#import "Category.h"

@interface CategoryCell()

/**  */
@property(nonatomic,strong)UILabel *nameLabel;
/**  */
@property(nonatomic,strong)UIImageView *backImageView;
/**  */
@property(nonatomic,strong)UIView *yellowView;
/**  */
@property(nonatomic,strong)UIView *lineView;


@end

@implementation CategoryCell

- (UILabel *)nameLabel {

    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = TEXT_GRAY_COLOR;
        _nameLabel.highlightedTextColor = [UIColor blackColor];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    
    return _nameLabel;
}

- (UIImageView *)backImageView {

    if (!_backImageView) {
        
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"llll"];
        _backImageView.highlightedImage = [UIImage imageNamed:@"kkkkkkk"];
        
    }
    return _backImageView;
}

- (UIView *)yellowView {

    if (!_yellowView) {
        
        _yellowView = [[UIView alloc] init];
        _yellowView.backgroundColor = NAVIGATION_YELLOW_COLOR;
    }
    
    return _yellowView;
}

- (UIView *)lineView {

    if (!_lineView) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(225, 225, 225);
    }
    
    return _lineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {

    [self.contentView addSubview:self.backImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.yellowView];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {

    static NSString *identifier = @"CategoryCell";
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

- (void)setCategories:(Category2 *)categories {

    _categories = categories;
    
    self.nameLabel.text = categories.name;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.nameLabel.highlighted = selected;
    self.backImageView.highlighted = selected;
    self.yellowView.hidden = !selected;
    

}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    
    self.nameLabel.frame = self.bounds;
    self.backImageView.frame = CGRectMake(0, 0, self.width, self.height);
    self.yellowView.frame = CGRectMake(0, self.height * 0.1, 5, self.height * 0.8);
    self.lineView.frame = CGRectMake(0, self.height - 1, self.width, 1);
    
}

@end
