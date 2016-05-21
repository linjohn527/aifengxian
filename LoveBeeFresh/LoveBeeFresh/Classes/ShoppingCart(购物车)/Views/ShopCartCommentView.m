//
//  ShopCartCommentView.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/29/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "ShopCartCommentView.h"

@interface ShopCartCommentView ()

/**  */
@property(nonatomic,strong)UITextField *textField;
/**  */
@property(nonatomic,strong)UILabel *signCommentLabel;

@end

@implementation ShopCartCommentView


- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self buildView];
    }
    
    return self;
}

- (void)buildView {

    
    UIView *lineView = [self lineViewWithFrame:CGRectMake(10, 0, self.width - 10, 0.5)];
    [self addSubview:lineView];
    
    
    //
    _signCommentLabel = [[UILabel alloc] init];
    _signCommentLabel.text = @"收货备注";
    _signCommentLabel.textColor = [UIColor blackColor];
    _signCommentLabel.font = [UIFont systemFontOfSize:15];
    [_signCommentLabel sizeToFit];
    _signCommentLabel.frame = CGRectMake(15, (ShopCartRowHeight - _signCommentLabel.height) * 0.5, _signCommentLabel.width, _signCommentLabel.height);
    [self addSubview:_signCommentLabel];
    
    //
    _textField = [[UITextField alloc] init];
    _textField.placeholder = @"可输入100字以内特殊要求内容";
    _textField.frame = CGRectMake(CGRectGetMaxX(_signCommentLabel.frame) + 10, 10, SCREEN_WIDTH - CGRectGetMaxX(_signCommentLabel.frame) - 10 - 20, ShopCartRowHeight - 20);
    
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self addSubview:_textField];
    
    //
    UIView *lineView2 = [self lineViewWithFrame:CGRectMake(0, ShopCartRowHeight - 0.5, SCREEN_WIDTH, 0.5)];
    [self addSubview:lineView2];
}

- (UIView *)lineViewWithFrame:(CGRect)frame {

    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    
    return lineView;
}

@end
