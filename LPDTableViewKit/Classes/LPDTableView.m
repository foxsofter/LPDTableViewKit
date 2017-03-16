//
//  LPDTableView.m
//  LPDTableViewKit
//
//  Created by foxsofter on 16/1/5.
//  Copyright © 2016年 eleme. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>
#import <Objc/runtime.h>
#import "LPDTableView.h"
#import "LPDTableViewModel+Private.h"

@interface LPDTableView ()

@property (nullable, nonatomic, weak, readwrite) __kindof id<LPDTableViewModelProtocol> viewModel;

@end

static inline void replaceMethod(Class oldClass, Class newClass, SEL anSelector);

@implementation LPDTableView

- (void)bindingTo:(__kindof id<LPDTableViewModelProtocol>)viewModel {
  NSParameterAssert(viewModel);
  
  self.sectionHeaderHeight = 0.1;
  self.sectionFooterHeight = 0.1;

  self.viewModel = viewModel;

  LPDTableViewModel *tableViewModel = (LPDTableViewModel*)self.viewModel;
  super.delegate = tableViewModel.delegate;
  super.dataSource = tableViewModel.dataSource;

  @weakify(self);
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
        NSIndexSet *indexSet = tuple.first;
        UITableViewRowAnimation removeAnimation = animation;
        if (animation == UITableViewRowAnimationRight) {
          removeAnimation = UITableViewRowAnimationLeft;
        } else if (animation == UITableViewRowAnimationLeft) {
          removeAnimation = UITableViewRowAnimationRight;
        } else if (animation == UITableViewRowAnimationTop) {
          removeAnimation = UITableViewRowAnimationBottom;
        } else if (animation == UITableViewRowAnimationBottom) {
          removeAnimation = UITableViewRowAnimationTop;
        }
        
        [self beginUpdates];
        [self deleteSections:indexSet withRowAnimation:removeAnimation];
        [self insertSections:indexSet withRowAnimation:animation];
        [self endUpdates];
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
    NSArray<NSIndexPath *> *indexPaths = tuple.first;
    if (indexPaths.count > 0) {
      UITableViewRowAnimation animation = [tuple.second integerValue];
      if (animation == UITableViewRowAnimationNone) {
        [self reloadData];
      } else {
        [self deleteRowsAtIndexPaths:tuple.first withRowAnimation:animation];
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
    UITableViewRowAnimation animation = [tuple.third integerValue];
    if (animation == UITableViewRowAnimationNone) {
      [self reloadData];
    } else {
      NSArray *oldIndexPaths = tuple.first;
      NSArray *newIndexPaths = tuple.second;
      UITableViewRowAnimation removeAnimation = animation;
      if (animation == UITableViewRowAnimationRight) {
        removeAnimation = UITableViewRowAnimationLeft;
      } else if (animation == UITableViewRowAnimationLeft) {
        removeAnimation = UITableViewRowAnimationRight;
      } else if (animation == UITableViewRowAnimationTop) {
        removeAnimation = UITableViewRowAnimationBottom;
      } else if (animation == UITableViewRowAnimationBottom) {
        removeAnimation = UITableViewRowAnimationTop;
      }
      
      [self beginUpdates];
      [self deleteRowsAtIndexPaths:oldIndexPaths withRowAnimation:removeAnimation];
      [self insertRowsAtIndexPaths:newIndexPaths withRowAnimation:animation];
      [self endUpdates];
    }
  }];
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
  LPDTableViewModel *tableViewModel = (LPDTableViewModel*)self.viewModel;
  SEL anSelector = @selector(scrollViewDidScroll:);
  if ([delegate respondsToSelector:anSelector]) {
    replaceMethod(tableViewModel.delegate.class, delegate.class, anSelector);
  }
  anSelector = @selector(scrollViewDidZoom:);
  if ([delegate respondsToSelector:anSelector]) {
    replaceMethod(tableViewModel.delegate.class, delegate.class, anSelector);
  }
  anSelector = @selector(scrollViewWillBeginDragging:);
  if ([delegate respondsToSelector:anSelector]) {
    replaceMethod(tableViewModel.delegate.class, delegate.class, anSelector);
  }
  anSelector = @selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:);
  if ([delegate respondsToSelector:anSelector]) {
    replaceMethod(tableViewModel.delegate.class, delegate.class, anSelector);
  }
  anSelector = @selector(scrollViewDidEndDragging:willDecelerate:);
  if ([delegate respondsToSelector:anSelector]) {
    replaceMethod(tableViewModel.delegate.class, delegate.class, anSelector);
  }
  anSelector = @selector(scrollViewWillBeginDecelerating:);
  if ([delegate respondsToSelector:anSelector]) {
    replaceMethod(tableViewModel.delegate.class, delegate.class, anSelector);
  }
  anSelector = @selector(scrollViewDidEndDecelerating:);
  if ([delegate respondsToSelector:anSelector]) {
    replaceMethod(tableViewModel.delegate.class, delegate.class, anSelector);
  }
  anSelector = @selector(scrollViewDidEndScrollingAnimation:);
  if ([delegate respondsToSelector:anSelector]) {
    replaceMethod(tableViewModel.delegate.class, delegate.class, anSelector);
  }
  anSelector = @selector(scrollViewWillBeginZooming:withView:);
  if ([delegate respondsToSelector:anSelector]) {
    replaceMethod(tableViewModel.delegate.class, delegate.class, anSelector);
  }
  anSelector = @selector(scrollViewDidEndZooming:withView:atScale:);
  if ([delegate respondsToSelector:anSelector]) {
    replaceMethod(tableViewModel.delegate.class, delegate.class, anSelector);
  }
  anSelector = @selector(scrollViewShouldScrollToTop:);
  if ([delegate respondsToSelector:anSelector]) {
    replaceMethod(tableViewModel.delegate.class, delegate.class, anSelector);
  }
  anSelector = @selector(scrollViewDidScrollToTop:);
  if ([delegate respondsToSelector:anSelector]) {
    replaceMethod(tableViewModel.delegate.class, delegate.class, anSelector);
  }
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
  // do nothing
}

@end

static inline void replaceMethod(Class oldClass, Class newClass, SEL anSelector) {
  Method keepMethod = class_getInstanceMethod(oldClass, anSelector);
  Method toReplaceMethod = class_getInstanceMethod(newClass, anSelector);
  method_exchangeImplementations(toReplaceMethod, keepMethod);
}
