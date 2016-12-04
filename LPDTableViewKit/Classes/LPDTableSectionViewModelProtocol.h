//
//  LPDTableSectionViewModelProtocol.h
//  LPDTableViewKit
//
//  Created by foxsofter on 16/1/8.
//  Copyright © 2016年 eleme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LPDTableBindingViewModelProtocol.h"

@protocol LPDTableSectionViewModelProtocol <NSObject>
@required

@property (nonatomic, copy) NSArray<__kindof id<LPDTableBindingViewModelProtocol>> *rows;

@optional

@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *footerTitle;

@property (nonatomic, strong) id<LPDTableBindingViewModelProtocol> headerViewModel;
@property (nonatomic, strong) id<LPDTableBindingViewModelProtocol> footerViewModel;

@end
