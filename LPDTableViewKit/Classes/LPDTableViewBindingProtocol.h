//
//  LPDTableViewBindingProtocol.h
//  LPDTableViewKit
//
//  Created by foxsofter on 16/1/3.
//  Copyright © 2016年 eleme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LPDTableBindingViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LPDTableViewBindingProtocol <NSObject>
@required

@property (nullable, nonatomic, weak, readonly) __kindof id<LPDTableBindingViewModelProtocol> viewModel;

- (void)bindingTo:(__kindof id<LPDTableBindingViewModelProtocol>)viewModel;

@end

NS_ASSUME_NONNULL_END
