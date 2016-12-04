//
//  LPDTableSectionViewModel+Private.h
//  LPDTableViewKit
//
//  Created by foxsofter on 16/1/8.
//  Copyright © 2016年 eleme. All rights reserved.
//

#import "LPDTableSectionViewModel.h"

@protocol LPDTableBindingViewModelProtocol;

@interface LPDTableSectionViewModel ()

@property (nonatomic, strong) NSMutableArray<__kindof id<LPDTableBindingViewModelProtocol>> *mutableRows;

@end
