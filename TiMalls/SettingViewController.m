//
//  SettingViewController.m
//  TiMalls
//
//  Created by hayato on 3/23/14.
//  Copyright (c) 2014 hayato miyoshi. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController () {
    UIButton* Button;
}
@end

@implementation SettingViewController

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
    
    Button = [[UIButton alloc] initWithFrame:CGRectMake(80, 330, 140, 40)];
    [Button setTitle:@"Share!!" forState:UIControlStateNormal];
    [Button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [Button addTarget:self action:@selector(tapBtn1:) forControlEvents:UIControlEventTouchUpInside];
    Button.layer.borderColor = [UIColor grayColor].CGColor;
    Button.layer.borderWidth = 1.0f;
    Button.layer.cornerRadius = 7.5f;
    [self.view addSubview:Button];
}
- (void)tapBtn1:(UIButton *)Button {
    NSString* text;
    NSString* text1;
    NSURL* url;
    UIImage* appimage;
    text = @"これはいち早くショッピングモールにある目的のお店を見つけ出すアプリです By TiMalls";
    text1 = @"This is application to find out the objective shop in the shopping mall quickly.";
    url = [NSURL URLWithString:@"https://itunes.apple.com/jp/app/timalls/id857597973?l=en&mt=8"];
    appimage = [UIImage imageNamed:[NSString stringWithFormat:@"120.png"]];
    NSArray *actItems = @[text,text1,url,appimage];
    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:actItems applicationActivities:nil];
    [self presentViewController:activityView animated:YES completion:nil];
    
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

@end
