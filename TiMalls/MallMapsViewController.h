//
//  MallMapsViewController.h
//  TiMalls
//
//  Created by hayato on 3/23/14.
//  Copyright (c) 2014 hayato miyoshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopViewController.h"
#import "AppDelegate.h"

@interface MallMapsViewController : UIViewController <UIWebViewDelegate,
                                                      UITableViewDataSource,
                                                      UITableViewDelegate,
                                                      UIScrollViewDelegate,
                                                      UISearchDisplayDelegate,
                                                      UINavigationControllerDelegate> {
    UISearchDisplayController* _searchDisplay;
    NSMutableArray *_listArray;
    NSMutableArray* _searchResult;
}

//@property (nonatomic,retain)NSString *mama;
@property (nonatomic,retain)NSString *malna;

@end
