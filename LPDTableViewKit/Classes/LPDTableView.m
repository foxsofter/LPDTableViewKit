//
//  LPDTableView.m
//  LPDTableViewKit
//
//  Created by foxsofter on 16/1/5.
//  Copyright © 2016年 eleme. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LPDTableView.h"
#import "LPDTableViewModel+Private.h"

@interface LPDTableView ()

@property (nullable, nonatomic, weak, readwrite) __kindof id<LPDTableViewModelProtocol> viewModel;

@end

@implementation LPDTableView

- (void)bindingTo:(__kindof id<LPDTableViewModelProtocol>)viewModel {
  NSParameterAssert(viewModel);

  self.viewModel = viewModel;

  @weakify(self);
  [[[self rac_signalForSelector:@selector(didMoveToSuperview)] takeUntil:[self rac_willDeallocSignal]]
   subscribeNext:^(id x) {
    @strongify(self);

    LPDTableViewModel *tableViewModel = (LPDTableViewModel*)self.viewModel;
    super.delegate = tableViewModel.delegate;
    super.dataSource = tableViewModel.dataSource;

    [[[tableViewModel.reloadDataSignal takeUntil:[self rac_signalForSelector:@selector(removeFromSuperview)]]
      deliverOnMainThread] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        [self reloadData];
      }];

    [[[tableViewModel.insertSectionsSignal takeUntil:[self rac_signalForSelector:@selector(removeFromSuperview)]]
      deliverOnMainThread] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        UITableViewRowAnimation animation = [tuple.second integerValue];
        if (animation == UITableViewRowAnimationNone) {
          [self reloadData];
        } else {
          [self insertSections:tuple.first withRowAnimation:animation];
        }
      }];

    [[[tableViewModel.deleteSectionsSignal takeUntil:[self rac_signalForSelector:@selector(removeFromSuperview)]]
      deliverOnMainThread] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        UITableViewRowAnimation animation = [tuple.second integerValue];
        if (animation == UITableViewRowAnimationNone) {
          [self reloadData];
        } else {
          [self deleteSections:tuple.first withRowAnimation:animation];
        }
      }];

    [[[tableViewModel.replaceSectionsSignal takeUntil:[self rac_signalForSelector:@selector(removeFromSuperview)]]
      deliverOnMainThread] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        UITableViewRowAnimation animation = [tuple.second integerValue];
        if (animation == UITableViewRowAnimationNone) {
          [self reloadData];
        } else {
          [self reloadSections:tuple.first withRowAnimation:animation];
        }
      }];

    [[[tableViewModel.reloadSectionsSignal takeUntil:[self rac_signalForSelector:@selector(removeFromSuperview)]]
      deliverOnMainThread] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        UITableViewRowAnimation animation = [tuple.second integerValue];
        if (animation == UITableViewRowAnimationNone) {
          [self reloadData];
        } else {
          [self reloadSections:tuple.first withRowAnimation:animation];
        }
      }];

    [[[tableViewModel.insertRowsAtIndexPathsSignal takeUntil:[self rac_signalForSelector:@selector(removeFromSuperview)]]
      deliverOnMainThread] subscribeNext:^(RACTuple *tuple) {
      @strongify(self);
      UITableViewRowAnimation animation = [tuple.second integerValue];
      if (animation == UITableViewRowAnimationNone) {
        [self reloadData];
      } else {
        [self insertRowsAtIndexPaths:tuple.first withRowAnimation:animation];
      }
    }];

    [[[tableViewModel.deleteRowsAtIndexPathsSignal takeUntil:[self rac_signalForSelector:@selector(removeFromSuperview)]]
      deliverOnMainThread] subscribeNext:^(RACTuple *tuple) {
      @strongify(self);
      NSMutableArray<NSIndexPath *> *indexPaths = [NSMutableArray arrayWithArray:tuple.first];
      for (NSInteger i = indexPaths.count - 1; i >= 0; i--) {
        NSIndexPath *indexPath = [indexPaths objectAtIndex:i];
        UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
        if (!cell) {
          [indexPaths removeObjectAtIndex:i];
        }
      }
      if (indexPaths.count > 0) {
        if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
          [self reloadData];
        } else {
          UITableViewRowAnimation animation = [tuple.second integerValue];
          if (animation == UITableViewRowAnimationNone) {
            [self reloadData];
          } else {
            [self deleteRowsAtIndexPaths:tuple.first withRowAnimation:animation];
          }
        }
      }
    }];

    [[[tableViewModel.reloadRowsAtIndexPathsSignal takeUntil:[self rac_signalForSelector:@selector(removeFromSuperview)]]
     deliverOnMainThread] subscribeNext:^(RACTuple *tuple) {
      @strongify(self);
      UITableViewRowAnimation animation = [tuple.second integerValue];
      if (animation == UITableViewRowAnimationNone) {
        [self reloadData];
      } else {
        [self reloadRowsAtIndexPaths:tuple.first withRowAnimation:animation];
      }
    }];

    [[[tableViewModel.replaceRowsAtIndexPathsSignal takeUntil:[self rac_signalForSelector:@selector(removeFromSuperview)]]
     deliverOnMainThread] subscribeNext:^(RACTuple *tuple) {
      @strongify(self);
      [self reloadData];
    }];
  }];
}

@end
