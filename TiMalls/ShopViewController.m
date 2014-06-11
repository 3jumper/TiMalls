//
//  ShopViewController.m
//  TiMalls
//
//  Created by hayato on 3/23/14.
//  Copyright (c) 2014 hayato miyoshi. All rights reserved.
//

#import "ShopViewController.h"

@interface ShopViewController ()

@end

@implementation ShopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Info";
    NSLog(@"shop = %@",self._Name);
//    self.shopName.adjustsFontSizeToFitWidth = YES;
	self.shopName.text = self._Name;
    //改行モード（ここでは単語がおさまらなかったら単語毎改行）
    self.shopName.lineBreakMode  = NSLineBreakByWordWrapping;
    //行数　行数制限なしにする
    self.shopName.numberOfLines  = 0;
    [self.shopName sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)toBtn:(id)sender {
    NSLog(@"sho = %@",self.shopName.text);

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

//    AppDelegate *mallmaps = [self.storyboard instantiateViewControllerWithIdentifier:@"AppDelegate"];

    appDelegate.ToName = self.shopName.text;

    
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)fromBtn:(id)sender {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    //    AppDelegate *mallmaps = [self.storyboard instantiateViewControllerWithIdentifier:@"AppDelegate"];
    
    appDelegate.FromName = self.shopName.text;
    [self.navigationController popViewControllerAnimated:YES];

}

@end
