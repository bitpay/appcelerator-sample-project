/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2019 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */
#ifdef USE_TI_UILISTVIEW

#import "TiUIListViewProxy.h"
#import "TiUIView.h"

@interface TiUIListView : TiUIView <UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching, UIScrollViewDelegate, UIGestureRecognizerDelegate, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate, TiScrolling, TiProxyObserver, TiUIListViewDelegateView>

#pragma mark - Private APIs

@property (nonatomic, readonly) UITableView *tableView;
@property (nonatomic, readonly) BOOL isSearchActive;

- (void)setDictTemplates_:(id)args;
- (void)setContentOffset_:(id)value withObject:(id)args;
- (void)setContentInsets_:(id)value withObject:(id)props;
- (void)deselectAll:(BOOL)animated;
- (void)updateIndicesForVisibleRows;
- (void)viewResignFocus;
- (void)viewGetFocus;

+ (UITableViewRowAnimation)animationStyleForProperties:(NSDictionary *)properties;
- (NSIndexPath *)pathForSearchPath:(NSIndexPath *)indexPath;

@end

#endif
