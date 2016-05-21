//
//  CostDetailView.m
//  LoveBeeFresh
//
//  Created by linjohn on 5/14/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "CostDetailView.h"
#import "UserShopCartTool.h"

@implementation CostDetailView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {

    self.backgroundColor = [UIColor whiteColor];
    
    //
    [self buildLableWithFrame:CGRectMake(15, 0, 150, 30) text:@"费用明细" font:[UIFont systemFontOfSize:12] textColor:[UIColor lightGrayColor] alighment:NSTextAlignmentLeft];
    
    //
    UIView *lineView1 =[[UIView alloc] initWithFrame:CGRectMake(15, 30 -0.5, SCREEN_WIDTH - 15, 0.5)];
    lineView1.backgroundColor = [UIColor blackColor];
    lineView1.alpha = 0.1;
    [self addSubview:lineView1];
    
    //
    [self buildLableWithFrame:CGRectMake(15, 35, 100, 20) text:@"商品总额" font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] alighment:NSTextAlignmentLeft];
    [self buildLableWithFrame:CGRectMake(100, 35, SCREEN_WIDTH - 110, 20) text:[NSString stringWithFormat:@"$%@",[[UserShopCartTool sharedUserShopCart] getAllProductsPrice]] font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] alighment:NSTextAlignmentRight];
    [self buildLableWithFrame:CGRectMake(15, 60, 100, 20) text:@"配送费" font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] alighment:NSTextAlignmentLeft];
    
    NSString *distribution;
    
    NSString *totalPrice = [[UserShopCartTool sharedUserShopCart] getAllProductsPrice];
    
    if ([totalPrice floatValue] >= 30) {
        
        distribution = @"0";
    
    } else {
    
        distribution = @"8";
    }
    
    [self buildLableWithFrame:CGRectMake(100, 60, SCREEN_WIDTH - 110, 20) text:[NSString stringWithFormat:@"$%@",distribution] font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] alighment:NSTextAlignmentRight];
    
    [self buildLableWithFrame:CGRectMake(15, 85, 100, 20) text:@"服务费" font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] alighment:NSTextAlignmentLeft];
    [self buildLableWithFrame:CGRectMake(100, 85, SCREEN_WIDTH - 110, 20) text:[NSString stringWithFormat:@"$%@",@"0"] font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] alighment:NSTextAlignmentRight];
    
    [self buildLableWithFrame:CGRectMake(15, 110, 100, 20) text:@"优惠券" font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] alighment:NSTextAlignmentLeft];
    [self buildLableWithFrame:CGRectMake(100, 110, SCREEN_WIDTH - 110, 20) text:[NSString stringWithFormat:@"$%@",@"0"] font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] alighment:NSTextAlignmentRight];
    
    //
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 135 - 1, SCREEN_WIDTH, 1)];
    lineView2.backgroundColor = [UIColor blackColor];
    lineView2.alpha = 0.1;
    [self addSubview:lineView2];
    
}

- (void)buildLableWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor alighment:(NSTextAlignment)alighment {

    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = alighment;
    label.text = text;
    [self addSubview:label];
}
@end
