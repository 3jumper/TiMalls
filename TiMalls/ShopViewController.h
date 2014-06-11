//
//  ShopViewController.h
//  TiMalls
//
//  Created by hayato on 3/23/14.
//  Copyright (c) 2014 hayato miyoshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MallMapsViewController.h"
#import "AppDelegate.h"

@interface ShopViewController : UIViewController

@property (nonatomic, assign)NSString *_Name;

@property (weak, nonatomic) IBOutlet UILabel *shopName;
- (IBAction)toBtn:(id)sender;
- (IBAction)fromBtn:(id)sender;

@end
