//
//  LPDTableViewFactory.h
//  LPDTableViewKit
//
//  Created by foxsofter on 16/1/3.
//  Copyright © 2016年 eleme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LPDTableViewCell.h"
#import "LPDTableCellViewModel.h"
#import "LPDTableViewHeader.h"
#import "LPDTableHeaderViewModel.h"
#import "LPDTableViewFooter.h"
#import "LPDTableFooterViewModel.h"
#import "LPDTableViewProtocol.h"

@interface LPDTableViewFactory : NSObject

- (__kindof id<LPDTableBindingViewModelProtocol>)tableViewModel:(__kindof id<LPDTableViewModelProtocol>)tableViewModel
                            cellForTableView:(UITableView *)tableView
                                 atIndexPath:(NSIndexPath *)indexPath;

- (__kindof id<LPDTableBindingViewModelProtocol>)cellWithViewModel:(__kindof id<LPDTableBindingViewModelProtocol>)viewModel
                                      tableView:(UITableView *)tableView;

- (__kindof id<LPDTableBindingViewModelProtocol>)tableViewModel:(__kindof id<LPDTableViewModelProtocol>)tableViewModel
                            headerForTableView:(UITableView *)tableView
                                     atSection:(NSInteger)sectionIndex;

- (__kindof id<LPDTableBindingViewModelProtocol>)headerWithViewModel:(__kindof id<LPDTableBindingViewModelProtocol>)viewModel
                                          tableView:(UITableView *)tableView;

- (__kindof id<LPDTableBindingViewModelProtocol>)tableViewModel:(__kindof id<LPDTableBindingViewModelProtocol>)tableViewModel
                            footerForTableView:(UITableView *)tableView
                                     atSection:(NSInteger)sectionIndex;

- (__kindof id<LPDTableBindingViewModelProtocol>)footerWithViewModel:(__kindof id<LPDTableBindingViewModelProtocol>)viewModel
                                          tableView:(UITableView *)tableView;
@end
