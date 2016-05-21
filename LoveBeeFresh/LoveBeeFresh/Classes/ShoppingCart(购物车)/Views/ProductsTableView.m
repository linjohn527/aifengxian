//
//  ProductsTableView.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/29/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "ProductsTableView.h"


@interface ProductsTableView ()

@end

@implementation ProductsTableView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self buildView];
    }
    
    return self;
}

- (void)buildView {

    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

@end
