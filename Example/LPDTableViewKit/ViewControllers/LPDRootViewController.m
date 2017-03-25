//
//  LPDRootViewController.m
//  LPDTableViewKit
//
//  Created by foxsofter on 12/04/2016.
//  Copyright (c) 2016 foxsofter. All rights reserved.
//

#import <LPDTableViewKit/LPDTableViewKit.h>
#import "LPDRootViewController.h"
#import "LPDPostModel.h"
#import "LPDTableViewPostCell.h"
#import "LPDTablePostCellViewModel.h"

@interface LPDRootViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet LPDTableView *tableView;
@property (nonatomic, strong) LPDTableViewModel *tableViewModel;

@end

@implementation LPDRootViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tableViewModel = [[LPDTableViewModel alloc] init];
  [self.tableView bindingTo:self.tableViewModel];
    //self.tableView.delegate = self;
  
  UIBarButtonItem *addCellBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"ac" style:UIBarButtonItemStylePlain target:self action:@selector(addCell)];
  
  UIBarButtonItem *addCellsBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"acs" style:UIBarButtonItemStylePlain target:self action:@selector(addCells)];
  
  UIBarButtonItem *insertCellBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"ic" style:UIBarButtonItemStylePlain target:self action:@selector(insertCell)];
  
  UIBarButtonItem *insertCellsBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"ics" style:UIBarButtonItemStylePlain target:self action:@selector(insertCells)];
  
  UIBarButtonItem *removeCellBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"rc" style:UIBarButtonItemStylePlain target:self action:@selector(removeCell)];
  
  UIBarButtonItem *removeCellsBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"rcs" style:UIBarButtonItemStylePlain target:self action:@selector(removeCells)];
  
  UIBarButtonItem *replaceCellsBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"rpcs" style:UIBarButtonItemStylePlain target:self action:@selector(replaceCells)];
  
  self.navigationController.toolbarHidden = NO;
  [self setToolbarItems:@[addCellBarButtonItem,
                          addCellsBarButtonItem,
                          insertCellBarButtonItem,
                          insertCellsBarButtonItem,
                          removeCellBarButtonItem,
                          removeCellsBarButtonItem,
                          replaceCellsBarButtonItem,]
               animated:YES];
}

#pragma mark - operations

- (void)addCell {
  LPDRootViewController *vc = [[LPDRootViewController alloc] initWithNibName:@"LPDRootViewController" bundle:nil];
  [self.navigationController pushViewController:vc animated:YES];
  
  LPDPostModel *model = [[LPDPostModel alloc]init];
  model.userId = 111111;
  model.identifier = 1003131;
  model.title = @"First Chapter";
  model.body = @"GitBook allows you to organize your book into chapters, each chapter is stored in a separate file like this one.";
  LPDTablePostCellViewModel *cellViewModel = [[LPDTablePostCellViewModel alloc]initWithViewModel:self.tableViewModel];
  cellViewModel.model = model;
  [self.tableViewModel addCellViewModel:cellViewModel];
}

- (void)addCells {
  NSMutableArray *cellViewModels = [NSMutableArray array];
  LPDTableDefaultCellViewModel *cellViewModel1 =
  [[LPDTableDefaultCellViewModel alloc] initWithViewModel:self.tableViewModel];
  cellViewModel1.text = @"芬兰无法";
  cellViewModel1.detail = @"蜂王浆发了";
  cellViewModel1.image = [UIImage imageNamed:@"01"];
  [cellViewModels addObject:cellViewModel1];
  LPDTableValue1CellViewModel *cellViewModel2 =
  [[LPDTableValue1CellViewModel alloc] initWithViewModel:self.tableViewModel];
  cellViewModel2.text = @"芬兰无法";
  cellViewModel2.detail = @"蜂王浆发了";
  cellViewModel2.image = [UIImage imageNamed:@"02"];
  [cellViewModels addObject:cellViewModel2];
  LPDTableValue2CellViewModel *cellViewModel3 =
  [[LPDTableValue2CellViewModel alloc] initWithViewModel:self.tableViewModel];
  cellViewModel3.text = @"芬兰无法";
  cellViewModel3.detail = @"蜂王浆发了";
  [cellViewModels addObject:cellViewModel3];
  LPDTableSubtitleCellViewModel *cellViewModel4 =
  [[LPDTableSubtitleCellViewModel alloc] initWithViewModel:self.tableViewModel];
  cellViewModel4.text = @"芬兰无法";
  cellViewModel4.detail = @"蜂王浆发了";
  cellViewModel4.image = [UIImage imageNamed:@"03"];
  [cellViewModels addObject:cellViewModel4];
  
  [self.tableViewModel addCellViewModels:cellViewModels withRowAnimation:UITableViewRowAnimationLeft];
}

- (void)insertCell {
  LPDPostModel *model = [[LPDPostModel alloc]init];
  model.userId = 111111;
  model.identifier = 1003131;
  model.title = @"First Chapter";
  model.body = @"GitBook allows you to organize your book into chapters, each chapter is stored in a separate file like this one.";
  LPDTablePostCellViewModel *cellViewModel = [[LPDTablePostCellViewModel alloc]initWithViewModel:self.tableViewModel];
  cellViewModel.model = model;
  [self.tableViewModel insertCellViewModel:cellViewModel atIndex:0 withRowAnimation:UITableViewRowAnimationLeft];
}

- (void)insertCells {
  NSMutableArray *cellViewModels = [NSMutableArray array];
  LPDTableDefaultCellViewModel *cellViewModel1 =
  [[LPDTableDefaultCellViewModel alloc] initWithViewModel:self.tableViewModel];
  cellViewModel1.text = @"芬兰无法";
  cellViewModel1.detail = @"蜂王浆发了";
  cellViewModel1.image = [UIImage imageNamed:@"01"];
  [cellViewModels addObject:cellViewModel1];
  LPDTableValue1CellViewModel *cellViewModel2 =
  [[LPDTableValue1CellViewModel alloc] initWithViewModel:self.tableViewModel];
  cellViewModel2.text = @"芬兰无法";
  cellViewModel2.detail = @"蜂王浆发了";
  cellViewModel2.image = [UIImage imageNamed:@"02"];
  [cellViewModels addObject:cellViewModel2];
  LPDTableValue2CellViewModel *cellViewModel3 =
  [[LPDTableValue2CellViewModel alloc] initWithViewModel:self.tableViewModel];
  cellViewModel3.text = @"芬兰无法";
  cellViewModel3.detail = @"蜂王浆发了";
  [cellViewModels addObject:cellViewModel3];
  LPDTableSubtitleCellViewModel *cellViewModel4 =
  [[LPDTableSubtitleCellViewModel alloc] initWithViewModel:self.tableViewModel];
  cellViewModel4.text = @"芬兰无法";
  cellViewModel4.detail = @"蜂王浆发了";
  cellViewModel4.image = [UIImage imageNamed:@"03"];
  [cellViewModels addObject:cellViewModel4];
  
  [self.tableViewModel insertCellViewModels:cellViewModels atIndex:0 withRowAnimation:UITableViewRowAnimationLeft];
}

- (void)removeCell {
  [self.navigationController popViewControllerAnimated:YES];
  [self.tableViewModel removeLastCellViewModelWithRowAnimation:UITableViewRowAnimationRight];
}

- (void)removeCells {
  [self.tableViewModel removeSectionAtIndex:0 withRowAnimation:UITableViewRowAnimationRight];
}

- (void)replaceCells {
  LPDTableValue2CellViewModel *cellViewModel1 =
  [[LPDTableValue2CellViewModel alloc] initWithViewModel:self.tableViewModel];
  cellViewModel1.text = @"芬兰无法";
  cellViewModel1.detail = @"蜂王浆发了";
  LPDTableValue2CellViewModel *cellViewModel2 =
  [[LPDTableValue2CellViewModel alloc] initWithViewModel:self.tableViewModel];
  cellViewModel2.text = @"分为两份绝望";
  cellViewModel2.detail = @"分为来访将为浪费金额未来房价未来房价来我房间来我房间额外福利晚饭";
  [self.tableViewModel replaceCellViewModels:@[ cellViewModel1, cellViewModel2 ] fromIndex:0 withRowAnimation:UITableViewRowAnimationLeft];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  NSLog(@"scrollViewDidScroll");
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  NSLog(@"scrollViewWillBeginDragging");

}


@end
