//
//  LPDTableViewHeader.m
//  LPDTableViewKit
//
//  Created by foxsofter on 16/1/8.
//  Copyright © 2016年 eleme. All rights reserved.
//

#import "LPDTableViewHeader.h"

@interface LPDTableViewHeader ()

@property (nullable, nonatomic, weak, readwrite) __kindof id<LPDTableBindingViewModelProtocol> viewModel;

@end

@implementation LPDTableViewHeader

- (void)bindingTo:(__kindof id<LPDTableBindingViewModelProtocol>)viewModel {
  NSParameterAssert(viewModel);
  self.viewModel = viewModel;
}

@end
