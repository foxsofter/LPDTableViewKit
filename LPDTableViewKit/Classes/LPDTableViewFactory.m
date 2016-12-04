//
//  LPDTableViewFactory.m
//  LPDTableViewKit
//
//  Created by foxsofter on 16/1/3.
//  Copyright © 2016年 eleme. All rights reserved.
//

#import "LPDTableCellViewModel.h"
#import "LPDTableViewFactory.h"

@implementation LPDTableViewFactory

- (__kindof id<LPDTableViewBindingProtocol>)tableViewModel:(__kindof id<LPDTableViewModelProtocol>)tableViewModel
                                          cellForTableView:(UITableView *)tableView
                                               atIndexPath:(NSIndexPath *)indexPath {
  __kindof id<LPDTableBindingViewModelProtocol> cellViewModel = [tableViewModel cellViewModelFromIndexPath:indexPath];
  if (cellViewModel) {
    return [self cellWithViewModel:cellViewModel tableView:tableView];
  }

  return nil;
}

- (__kindof id<LPDTableViewBindingProtocol>)cellWithViewModel:(__kindof id<LPDTableBindingViewModelProtocol>)viewModel
                                                    tableView:(UITableView *)tableView {
  Class viewClass = NSClassFromString(viewModel.reuseViewClass);
  NSString *xibPath = [[NSBundle mainBundle] pathForResource:viewModel.reuseViewClass ofType:@"nib"];
  if (xibPath && xibPath.length > 0) {
    [tableView registerNib:[UINib nibWithNibName:viewModel.reuseViewClass bundle:nil]
      forCellReuseIdentifier:viewModel.reuseIdentifier];
  } else {
    [tableView registerClass:viewClass forCellReuseIdentifier:viewModel.reuseIdentifier];
  }

  id<LPDTableViewBindingProtocol> cell = [tableView dequeueReusableCellWithIdentifier:viewModel.reuseIdentifier];
  if (!cell) {
    cell = [[viewClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:viewModel.reuseIdentifier];
  }
  [cell bindingTo:viewModel];

  return cell;
}

- (__kindof id<LPDTableViewBindingProtocol>)tableViewModel:(__kindof id<LPDTableViewModelProtocol>)tableViewModel
                                        headerForTableView:(UITableView *)tableView
                                                 atSection:(NSInteger)sectionIndex {
  __kindof id<LPDTableBindingViewModelProtocol> headerViewModel =
    [tableViewModel headerViewModelFromSection:sectionIndex];
  if (headerViewModel) {
    return [self hfWithViewModel:headerViewModel tableView:tableView];
  }
  return nil;
}

- (__kindof id<LPDTableViewBindingProtocol>)tableViewModel:(__kindof id<LPDTableViewModelProtocol>)tableViewModel
                                        footerForTableView:(UITableView *)tableView
                                                 atSection:(NSInteger)sectionIndex {
  __kindof id<LPDTableBindingViewModelProtocol> footerViewModel =
    [tableViewModel footerViewModelFromSection:sectionIndex];
  if (footerViewModel) {
    return [self hfWithViewModel:footerViewModel tableView:tableView];
  }
  return nil;
}

- (__kindof id<LPDTableViewBindingProtocol>)hfWithViewModel:(__kindof id<LPDTableBindingViewModelProtocol>)viewModel
                                                  tableView:(UITableView *)tableView {
  Class viewClass = NSClassFromString(viewModel.reuseViewClass);
  [tableView registerClass:viewClass forHeaderFooterViewReuseIdentifier:viewModel.reuseIdentifier];
  
  id<LPDTableViewBindingProtocol> headerFooter =
  [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewModel.reuseIdentifier];
  if (!headerFooter) {
    headerFooter = [[viewClass alloc] initWithReuseIdentifier:viewModel.reuseIdentifier];
  }
  [headerFooter bindingTo:viewModel];
  return headerFooter;
}


@end
