//
//  LPDTableViewHeader.h
//  LPDTableViewKit
//
//  Created by foxsofter on 16/1/8.
//  Copyright © 2016年 eleme. All rights reserved.
//

#import "LPDTableViewBindingProtocol.h"
#import <UIKit/UIKit.h>

@interface LPDTableViewHeader : UITableViewHeaderFooterView <LPDTableViewBindingProtocol>
+ (instancetype) new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
@end
