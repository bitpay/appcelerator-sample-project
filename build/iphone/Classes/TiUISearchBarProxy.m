/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2019 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */
#if defined(USE_TI_UITABLEVIEW) || defined(USE_TI_UILISTVIEW)
#ifndef USE_TI_UISEARCHBAR
#define USE_TI_UISEARCHBAR
#endif
#endif

#ifdef USE_TI_UISEARCHBAR

#import "TiUISearchBarProxy.h"
#import "TiUISearchBar.h"

@implementation TiUISearchBarProxy
@synthesize showsCancelButton;

#pragma mark Method forwarding

- (NSString *)apiName
{
  return @"Ti.UI.SearchBar";
}

- (void)blur:(id)args
{
  [self makeViewPerformSelector:@selector(blur:) withObject:args createIfNeeded:YES waitUntilDone:NO];
}

- (void)focus:(id)args
{
  [self makeViewPerformSelector:@selector(focus:) withObject:args createIfNeeded:YES waitUntilDone:NO];
}

- (void)windowWillClose
{
  if ([self viewInitialized]) {
    [self makeViewPerformSelector:@selector(blur:) withObject:nil createIfNeeded:NO waitUntilDone:YES];
  }
  [super windowWillClose];
}

- (void)setShowCancel:(id)value withObject:(id)object
{
  BOOL boolValue = [TiUtils boolValue:value];
  BOOL animated = [TiUtils boolValue:@"animated" properties:object def:NO];
  //TODO: Value checking and exception generation, if necessary.

  [self replaceValue:value forKey:@"showCancel" notification:NO];
  showsCancelButton = boolValue;

  //ViewAttached gives a false negative when not attached to a window.
  TiThreadPerformOnMainThread(^{
    UISearchBar *search = [self searchBar];
    [search setShowsCancelButton:showsCancelButton animated:animated];
    [search sizeToFit];
  },
      NO);
}

- (void)setDelegate:(id<UISearchBarDelegate>)delegate
{
  [self makeViewPerformSelector:@selector(setDelegate:) withObject:delegate createIfNeeded:(delegate != nil) waitUntilDone:YES];
}

- (UISearchBar *)searchBar
{
  return [(TiUISearchBar *)[self view] searchBar];
}

- (void)setSearchBar:(UISearchBar *)searchBar
{
  // In UISearchController searchbar is readonly. We have to replace that search bar with existing search bar of proxy.
  [(TiUISearchBar *)[self view] setSearchBar:searchBar];

  // Set search bar properties to new search bar
  NSDictionary *properties = [self allProperties];
  for (NSString *key in properties.allKeys) {
    SEL selector = SetterForKrollProperty(key);
    if ([(TiUISearchBar *)[self view] respondsToSelector:selector]) {
      [(TiUISearchBar *)[self view] performSelector:selector withObject:[properties objectForKey:key]];
    }
  }
}

- (void)ensureSearchBarHierarchy
{
  WARN_IF_BACKGROUND_THREAD;
  if ([self viewAttached]) {
    UISearchBar *searchBar = [self searchBar];
    if ([searchBar superview] != view) {
      [view addSubview:searchBar];
    }
    [searchBar setFrame:[view bounds]];
  }
}

- (NSMutableDictionary *)langConversionTable
{
  return [NSMutableDictionary dictionaryWithObjectsAndKeys:@"prompt", @"promptid", @"hintText", @"hinttextid", nil];
}

- (TiDimension)defaultAutoHeightBehavior:(id)unused
{
  return TiDimensionAutoSize;
}

#pragma mark getters

- (NSString *)value
{
  return [[self searchBar] text];
}

- (NSNumber *)showBookmark
{
  return NUMBOOL([[self searchBar] showsBookmarkButton]);
}

- (NSNumber *)showCancel
{
  return NUMBOOL([[self searchBar] showsCancelButton]);
}

- (NSString *)hintText
{
  return [[self searchBar] placeholder];
}

- (id)hintTextColor
{
  return [self valueForUndefinedKey:@"hintTextColor"];
}

- (id)color
{
  return [self valueForUndefinedKey:@"color"];
}

- (NSNumber *)keyboardType
{
  return NUMINT([[self searchBar] keyboardType]);
}

- (NSNumber *)keyboardAppearance
{
  return NUMINT([[self searchBar] keyboardAppearance]);
}

- (NSString *)prompt
{
  return [[self searchBar] prompt];
}

- (NSNumber *)autocorrect
{
  UITextAutocorrectionType autocorrectionType = [[self searchBar] autocorrectionType];
  if (autocorrectionType == UITextAutocorrectionTypeYes) {
    return NUMBOOL(YES);
  } else if (autocorrectionType == UITextAutocorrectionTypeNo) {
    return NUMBOOL(NO);
  } else {
    return nil;
  }
}

- (NSNumber *)autocapitalization
{
  return NUMINT([[self searchBar] autocapitalizationType]);
}

- (id)tintColor
{
  return [self valueForUndefinedKey:@"tintColor"];
}

- (id)barColor
{
  return [self valueForUndefinedKey:@"barColor"];
}

- (NSNumber *)style
{
  return NUMINT([[self searchBar] searchBarStyle]);
}

USE_VIEW_FOR_CONTENT_HEIGHT
@end

#endif
