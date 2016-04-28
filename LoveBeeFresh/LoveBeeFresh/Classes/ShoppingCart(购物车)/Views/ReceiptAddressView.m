//
//  ReceiptAddressView.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/28/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "ReceiptAddressView.h"
#import "Address.h"

#define LEFT_MARGIN 15

@interface ReceiptAddressView()

/**  */
@property(nonatomic,strong)UIImageView *topImageView;
/**  */
@property(nonatomic,strong)UIImageView *bottomImageView;
/**  */
@property(nonatomic,strong)UILabel *consigeeLabel;
/**  */
@property(nonatomic,strong)UILabel *consigeeTextLabel;
/**  */
@property(nonatomic,strong)UILabel *phoneNumberLabel;
/**  */
@property(nonatomic,strong)UILabel *phoneNumberTextLabel;
/**  */
@property(nonatomic,strong)UILabel *receiptAddressLabel;
/**  */
@property(nonatomic,strong)UILabel *receiptAddressTextLabel;
/**  */
@property(nonatomic,strong)UIImageView *arrowImageView;
/**  */
@property(nonatomic,strong)UIButton *modifyButton;

@end

@implementation ReceiptAddressView



- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self buildView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame ModifyButtonClick:(ModifyButtonClickCallBack)callback {

    self = [self initWithFrame:frame];
    _callback = callback;
    
    return self;
}

- (void)buildView {

    //
    self.backgroundColor = [UIColor whiteColor];
    
    //
     _topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"v2_shoprail"]];
    [self addSubview:_topImageView];
    
    //
     _bottomImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"v2_shoprail"]];
    [self addSubview:_bottomImageView];
    
    //
    _consigeeLabel = [[UILabel alloc] init];
    [self initLabel:_consigeeLabel text:@"收 件 人"];
    _consigeeTextLabel = [[UILabel alloc] init];
    [self initLabel:_consigeeTextLabel text:@""];
    _phoneNumberLabel = [[UILabel alloc] init];
    [self initLabel:_phoneNumberLabel text:@"电  话"];
    _phoneNumberTextLabel = [[UILabel alloc] init];
    [self initLabel:_phoneNumberTextLabel text:@""];
    _receiptAddressLabel = [[UILabel alloc] init];
    [self initLabel:self.receiptAddressLabel text:@"收货地址"];
    _receiptAddressTextLabel = [[UILabel alloc] init];
    [self initLabel:_receiptAddressTextLabel text:@""];
    
    //
    _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_go"]];
    [self addSubview:_arrowImageView];
    
    //
    _modifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_modifyButton setTitle:@"修改" forState:UIControlStateNormal];
    [_modifyButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _modifyButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_modifyButton addTarget:self action:@selector(modifyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_modifyButton];
    
}

- (void)modifyButtonClick {

    !_callback?:_callback();
}

- (void)initLabel:(UILabel *)label text:(NSString *)text {

    label.text = text;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    [self addSubview:label];
}

- (void)setAddress:(Address *)address {

    _address = address;
    
    _receiptAddressTextLabel.text = address.address;
    _phoneNumberTextLabel.text = address.telphone;
    NSString *gender = ([address.gender isEqualToString:@"1"]?@"先生":@"女士");
    _consigeeTextLabel.text = [NSString stringWithFormat:@"%@ %@",address.accept_name,gender];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    //
    _topImageView.frame = CGRectMake(0, 0, self.width, 2);
    _bottomImageView.frame = CGRectMake(0, self.height - 2, self.width, 2);
    
    _consigeeLabel.frame = CGRectMake(LEFT_MARGIN, 10, _consigeeLabel.width, _consigeeLabel.height);
    _consigeeTextLabel.frame = CGRectMake(CGRectGetMaxX(_consigeeLabel.frame), _consigeeLabel.y, 150, _consigeeLabel.height);
    
    _phoneNumberLabel.frame = CGRectMake(LEFT_MARGIN, CGRectGetMaxY(_consigeeLabel.frame) + 5, _phoneNumberLabel.width, _phoneNumberLabel.height);
    _phoneNumberTextLabel.frame = CGRectMake(CGRectGetMaxX(_phoneNumberLabel.frame) + 5, _phoneNumberLabel.y, 150, _phoneNumberLabel.height);
    
    _receiptAddressLabel.frame = CGRectMake(LEFT_MARGIN, CGRectGetMaxY(_phoneNumberLabel.frame) + 5, _receiptAddressLabel.width, _receiptAddressLabel.height);
    _receiptAddressTextLabel.frame = CGRectMake(CGRectGetMaxX(_phoneNumberLabel.frame) + 5, _receiptAddressLabel.y, 150, _receiptAddressLabel.height);
    
    _modifyButton.frame = CGRectMake(self.width - 60, 0, 30, self.height);
    _arrowImageView.frame = CGRectMake(self.width - 15, (self.height - _arrowImageView.height) * 0.5, _arrowImageView.width, _arrowImageView.height);
}

@end
