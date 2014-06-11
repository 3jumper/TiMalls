//
//  MallMapsViewController.m
//  TiMalls
//
//  Created by hayato on 3/23/14.
//  Copyright (c) 2014 hayato miyoshi. All rights reserved.
//

#import "MallMapsViewController.h"

#define width self.view.bounds.size.width
#define height self.view.bounds.size.height
#define NAVBAR_H    44
#define TABBAR_H    50
#define pageSize 6

@interface MallMapsViewController () {
    BOOL isBool;
    UIWebView* _myWebView;
    UIView* _allView;

    //List
    UIView* _listBack;
    UITableView* _tableView;
//    NSArray* _listArray;
    
    //Floor
    UIView* _scrBack;
    UIScrollView* _scrollView;
    UIButton* _FloorBtn;
    
    // フロアリスト
    NSArray* ayalaflArray;
    NSArray* yokohamaArray;
    NSArray* kobeArray;
    NSArray* tamaArray;
    NSArray* floorArray;
    
    NSString* From;
    NSString* To;
    
    // destination & present
    UILabel* fromLabel;
    UILabel* toLabel;
    UILabel* destination;
    UILabel* present;
    NSInteger* floorInt;
    UISearchBar* searchBar;
    
    UILabel* nowFloor;
    NSString* kisarazu;

}

@end

@implementation MallMapsViewController

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
    
    NSArray *array = @[[UIImage imageNamed:@"tuto1.png"],
                       [UIImage imageNamed:@"tuto2.png"],
                       [UIImage imageNamed:@"tuto3.png"],
                       [UIImage imageNamed:@"tuto4.png"]];
    NSLog(@"%@",array);
    
    self.navigationController.delegate = self;
    self.navigationItem.title = [NSString stringWithFormat:@"%@",_malna];
    NSLog(@"%@",_malna);

    
    _myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width , height)];
    _myWebView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:0.96];
    //UIScrollViewを取得後、bouncesをNOに変更
    for (id subview in _myWebView.subviews){
        if([[subview class] isSubclassOfClass: [UIScrollView class]]){
            ((UIScrollView *)subview).bounces = NO;
        }
    }
    [self.view addSubview:_myWebView];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bootstrap.min" ofType:@"js"];
    
    
    NSString *script = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    
    [_myWebView stringByEvaluatingJavaScriptFromString:script];
    
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"jquery.min" ofType:@"js"];
    
    
    NSString *script2 = [NSString stringWithContentsOfFile:filePath2 encoding:NSUTF8StringEncoding error:NULL];
    
    [_myWebView stringByEvaluatingJavaScriptFromString:script2];
    
    
    // Floorリスト
    NSString* Basement2 = [[NSBundle mainBundle] pathForResource: @"basement2" ofType: @"html"];
    NSString* Basement1 = [[NSBundle mainBundle] pathForResource: @"basement1" ofType: @"html"];
    NSString* GL = [[NSBundle mainBundle] pathForResource: @"level1" ofType: @"html"];
    NSString* Floor2 = [[NSBundle mainBundle] pathForResource: @"level2" ofType: @"html"];
    NSString* Floor3 = [[NSBundle mainBundle] pathForResource: @"level3" ofType: @"html"];
    NSString* Floor4 = [[NSBundle mainBundle] pathForResource: @"level4" ofType: @"html"];
    NSString* tama1f = [[NSBundle mainBundle] pathForResource: @"tama1f" ofType: @"html"];
    NSString* tama2f = [[NSBundle mainBundle] pathForResource: @"tama2f" ofType: @"html"];
    
    NSString* yokohama1f = [[NSBundle mainBundle] pathForResource: @"yokohama1f" ofType: @"html"];
    NSString* yokohama2f = [[NSBundle mainBundle] pathForResource: @"yokohama2f" ofType: @"html"];
    NSString* kobe1f = [[NSBundle mainBundle] pathForResource: @"kobe1f" ofType: @"html"];
    NSString* kobe2f = [[NSBundle mainBundle] pathForResource: @"kobe2f" ofType: @"html"];
    kisarazu = [[NSBundle mainBundle] pathForResource: @"kisarazu" ofType: @"html"];
    
    ayalaflArray = @[Basement2,Basement1,GL,Floor2,Floor3,Floor4];
    yokohamaArray = @[yokohama1f,yokohama2f];
    kobeArray = @[kobe1f,kobe2f];
    tamaArray = @[tama1f,tama2f];
    
    floorArray = @[@"Basement2",@"Basement1",@"GL",@"Floor2",@"Floor3",@"Floor4"];
    
    if ([_malna isEqualToString:@"Ayala Malls"]) {
        [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[2]]]];
    } else if ([_malna isEqualToString:@"MARINE PIA KOBE"]){
        [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: kobeArray[0]]]];
    } else if ([_malna isEqualToString:@"MINAMIOSAWA"]){
        [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: tamaArray[0]]]];
    } else if ([_malna isEqualToString:@"KISARAZU"]){
        [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: kisarazu]]];
    } else if ([_malna isEqualToString:@"YOKOHAMA BAYSIDE"]){
        [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: yokohamaArray[0]]]];
    }
    
    
    _myWebView.scalesPageToFit = YES;
    _myWebView.delegate = self;
    
    //目的地を示すモノ
    UILabel* fromcolor = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 10, 10)];
    fromcolor.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.55 alpha:1];
    [self.view addSubview:fromcolor];
    UILabel* tocolor = [[UILabel alloc] initWithFrame:CGRectMake(10, 85, 10, 10)];
    tocolor.backgroundColor = [UIColor colorWithRed:0.86 green:0.08 blue:0.24 alpha:1.0];
    [self.view addSubview:tocolor];
    fromLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 70, 30, 10)];
    fromLabel.font = [UIFont systemFontOfSize:8];
    fromLabel.textColor = [UIColor blackColor];
    fromLabel.textAlignment = UIControlContentHorizontalAlignmentRight;
    fromLabel.text = @"From:";
    [self.view addSubview:fromLabel];
    toLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 85, 30, 10)];
    toLabel.font = [UIFont systemFontOfSize:8];
    toLabel.textColor = [UIColor blackColor];
    toLabel.textAlignment = UIControlContentHorizontalAlignmentRight;
    toLabel.text = @"To:";
    [self.view addSubview:toLabel];
    destination = [[UILabel alloc] initWithFrame:CGRectMake(65, 70, 260, 10)];
    destination.font = [UIFont systemFontOfSize:8];
    destination.textColor = [UIColor blackColor];
    [self.view addSubview:destination];
    present = [[UILabel alloc] initWithFrame:CGRectMake(65, 85, 260, 10)];
    present.font = [UIFont systemFontOfSize:8];
    present.textColor = [UIColor blackColor];
    [self.view addSubview:present];
    
    nowFloor = [[UILabel alloc] initWithFrame:CGRectMake( 10 , height - 70, 100, 20)];
    nowFloor.text = @"GL";
    nowFloor.textColor = [UIColor lightGrayColor];
    nowFloor.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:nowFloor];
    
    _allView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _allView.backgroundColor = [UIColor darkGrayColor];
    _allView.alpha = 0.0;
    [self.view addSubview:_allView];
    
    
    _listBack = [[UIView alloc] initWithFrame:CGRectMake( 0,  height, width , height - TABBAR_H - NAVBAR_H - 20)];
    _listBack.backgroundColor = [UIColor clearColor];
    _listBack.alpha = 0.0;
    [self.view addSubview:_listBack];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  NAVBAR_H + 20, width , height - TABBAR_H - NAVBAR_H - 20)];
    
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    
    [_listBack addSubview:_tableView];
    
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, width, 0)];

    [searchBar sizeToFit];
    _tableView.tableHeaderView = searchBar;
    
    _searchDisplay =
    [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    _searchDisplay.delegate = self;
    _searchDisplay.searchResultsDataSource = self;
    _searchDisplay.searchResultsDelegate = self;
    
    // プログラミング言語の名前を持った配列を用意する
    
    //読み込むファイルパスを指定
    if ([_malna isEqualToString:@"Ayala Malls"]) {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"AyalaList" ofType:@"plist"];
        NSArray* array = [[NSArray alloc] initWithContentsOfFile:path];
        _listArray = [array mutableCopy];
    } else if ([_malna isEqualToString:@"MARINE PIA KOBE"]){
        NSString* path = [[NSBundle mainBundle] pathForResource:@"marinepiakobe" ofType:@"plist"];
        NSArray* array = [[NSArray alloc] initWithContentsOfFile:path];
        _listArray = [array mutableCopy];
    } else if ([_malna isEqualToString:@"MINAMIOSAWA"]){
        NSString* path = [[NSBundle mainBundle] pathForResource:@"tamaMinamiosawa" ofType:@"plist"];
        NSArray* array = [[NSArray alloc] initWithContentsOfFile:path];
        _listArray = [array mutableCopy];
    } else if ([_malna isEqualToString:@"KISARAZU"]){
        NSString* path = [[NSBundle mainBundle] pathForResource:@"kisarazu" ofType:@"plist"];
        NSArray* array = [[NSArray alloc] initWithContentsOfFile:path];
        _listArray = [array mutableCopy];
    } else if ([_malna isEqualToString:@"YOKOHAMA BAYSIDE"]){
        NSString* path = [[NSBundle mainBundle] pathForResource:@"yokohamaBayside" ofType:@"plist"];
        NSArray* array = [[NSArray alloc] initWithContentsOfFile:path];
        _listArray = [array mutableCopy];
    }


    
    _searchResult = [[NSMutableArray alloc] initWithCapacity:_listArray.count];
    
    _tableView.rowHeight = 50;
    _tableView.backgroundColor = [UIColor whiteColor];
    
    
    _scrBack = [[UIView alloc] initWithFrame:CGRectMake(0, height, pageSize * 200 + 5 * pageSize, 250)];
    _scrBack.backgroundColor = [UIColor colorWithRed:0.55 green:0.78 blue:0.13 alpha:1.0];
    _scrBack.alpha = 0.0;
    [self.view addSubview:_scrBack];
    
    
    // UIScrollViewのインスタンス化
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = self.view.bounds;
    
    // 横スクロールのインジケータを非表示にする
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    // ページングを有効にする
    _scrollView.pagingEnabled = NO;
    // スクロールを可能にするかどうか
    _scrollView.userInteractionEnabled = YES;
    _scrollView.delegate = self;
    
    // スクロールの範囲を設定
    
    if ([_malna isEqualToString:@"Ayala Malls"]) {
        [_scrollView setContentSize:CGSizeMake((5 + 6 * 200 + 5 * 6), 200)];
        [_scrBack addSubview:_scrollView];

        for (int i = 0; i < 6; i++) {
            _FloorBtn = [[UIButton alloc] initWithFrame:CGRectMake((i * 200 + 5 * i + 5), 5, 200, 200)];
            [_FloorBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i + 1]] forState:UIControlStateNormal];
            [_FloorBtn addTarget:self action:@selector(imageAction:) forControlEvents:UIControlEventTouchUpInside];
            _FloorBtn.tag = i;
            [_scrollView addSubview:_FloorBtn];
                UILabel* Basefloor = [[UILabel alloc] initWithFrame:CGRectMake(i * 200 + 5 * i + 5, 220, 200, 20)];
                Basefloor.text = floorArray[i];
                Basefloor.textColor = [UIColor whiteColor];
                Basefloor.textAlignment = NSTextAlignmentCenter;
                Basefloor.font = [UIFont systemFontOfSize:15];
                [_scrollView addSubview:Basefloor];
            NSLog(@"%@",floorArray[i]);
        }
    } else if
        ([_malna isEqualToString:@"MARINE PIA KOBE"]) {
        [_scrollView setContentSize:CGSizeMake((5 + 2 * 200 + 5 * 2), 200)];
            [_scrBack addSubview:_scrollView];

            for (int i = 0; i < 2; i++) {
                _FloorBtn = [[UIButton alloc] initWithFrame:CGRectMake((i * 200 + 5 * i + 5), 5, 200, 200)];
                [_FloorBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"kobe%df.png", i + 1]] forState:UIControlStateNormal];
                [_FloorBtn addTarget:self action:@selector(imageAction:) forControlEvents:UIControlEventTouchUpInside];
                _FloorBtn.tag = i;
                [_scrollView addSubview:_FloorBtn];
                UILabel* Basefloor = [[UILabel alloc] initWithFrame:CGRectMake(i * 200 + 5 * i + 5, 220, 200, 20)];
                Basefloor.text = floorArray[i + 2];
                Basefloor.textColor = [UIColor whiteColor];
                Basefloor.textAlignment = NSTextAlignmentCenter;
                Basefloor.font = [UIFont systemFontOfSize:15];
                [_scrollView addSubview:Basefloor];
    } 
        } else if ([_malna isEqualToString:@"MINAMIOSAWA"]){
            [_scrollView setContentSize:CGSizeMake((5 + 2 * 200 + 5 * 2), 200)];
            [_scrBack addSubview:_scrollView];
            
            for (int i = 0; i < 2; i++) {
                _FloorBtn = [[UIButton alloc] initWithFrame:CGRectMake((i * 200 + 5 * i + 5), 5, 200, 200)];
                [_FloorBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tama%df.png", i + 1]] forState:UIControlStateNormal];
                [_FloorBtn addTarget:self action:@selector(imageAction:) forControlEvents:UIControlEventTouchUpInside];
                _FloorBtn.tag = i;
                [_scrollView addSubview:_FloorBtn];
                UILabel* Basefloor = [[UILabel alloc] initWithFrame:CGRectMake(i * 200 + 5 * i + 5, 220, 200, 20)];
                Basefloor.text = floorArray[i + 2];
                Basefloor.textColor = [UIColor whiteColor];
                Basefloor.textAlignment = NSTextAlignmentCenter;
                Basefloor.font = [UIFont systemFontOfSize:15];
                [_scrollView addSubview:Basefloor];
            }
        } else if ([_malna isEqualToString:@"KISARAZU"]){
            [_scrollView setContentSize:CGSizeMake( 210, 200)];
            [_scrBack addSubview:_scrollView];
                _FloorBtn = [[UIButton alloc] initWithFrame:CGRectMake( 5, 5, 200, 200)];
                [_FloorBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"kisarazu.png"]] forState:UIControlStateNormal];
                [_FloorBtn addTarget:self action:@selector(imageAction:) forControlEvents:UIControlEventTouchUpInside];
                _FloorBtn.tag = 0;
                [_scrollView addSubview:_FloorBtn];
                UILabel* Basefloor = [[UILabel alloc] initWithFrame:CGRectMake( 5, 220, 200, 20)];
                Basefloor.text = floorArray[2];
                Basefloor.textColor = [UIColor whiteColor];
                Basefloor.textAlignment = NSTextAlignmentCenter;
                Basefloor.font = [UIFont systemFontOfSize:15];
                [_scrollView addSubview:Basefloor];
        } else if ([_malna isEqualToString:@"YOKOHAMA BAYSIDE"]){
            [_scrollView setContentSize:CGSizeMake((5 + 2 * 200 + 5 * 2), 200)];
            [_scrBack addSubview:_scrollView];
            
            for (int i = 0; i < 2; i++) {
                _FloorBtn = [[UIButton alloc] initWithFrame:CGRectMake((i * 200 + 5 * i + 5), 5, 200, 200)];
                [_FloorBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"yokohama%df.png", i + 1]] forState:UIControlStateNormal];
                [_FloorBtn addTarget:self action:@selector(imageAction:) forControlEvents:UIControlEventTouchUpInside];
                _FloorBtn.tag = i;
                [_scrollView addSubview:_FloorBtn];
                UILabel* Basefloor = [[UILabel alloc] initWithFrame:CGRectMake(i * 200 + 5 * i + 5, 220, 200, 20)];
                Basefloor.text = floorArray[i + 2];
                Basefloor.textColor = [UIColor whiteColor];
                Basefloor.textAlignment = NSTextAlignmentCenter;
                Basefloor.font = [UIFont systemFontOfSize:15];
                [_scrollView addSubview:Basefloor];
            }
        }

    
    
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                              target:self
                                                                              action:@selector(listBtn:)];
    
    
    UIBarButtonItem *scrButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks
                                                                               target:self
                                                                               action:@selector(floorBtn:)];
    self.navigationItem.rightBarButtonItems = @[myButton,scrButton];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [_allView addGestureRecognizer:tapGesture];
    

}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSLog(@"shopNamefrom = %@",appDelegate.fromName);
    
    From = @"From";
    
    NSString *command =[NSString stringWithFormat:@"setcolor('%@','%@')",From,appDelegate.fromName];
    [_myWebView stringByEvaluatingJavaScriptFromString:command];
    
    NSLog(@"shopNameto = %@",appDelegate.toName);
    
    To = @"To";
    
    NSString *command1 =[NSString stringWithFormat:@"setcolor('%@','%@')",To,appDelegate.toName];
    [_myWebView stringByEvaluatingJavaScriptFromString:command1];
    
    destination.text = appDelegate.fromName;
    present.text = appDelegate.toName;

    
}

- (void)filterContentForSearchText:(NSString*)searchString scope:(NSString*)scope {
    [_searchResult removeAllObjects];

    
    for(NSString *label in _listArray) {
        NSRange range = [label rangeOfString:searchString
                                     options:NSCaseInsensitiveSearch];
        if(range.length > 0)
            [_searchResult addObject:label];
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController*)controller
shouldReloadTableForSearchString:(NSString*)searchString
{

    [self filterContentForSearchText: searchString
                               scope: [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

- (void)imageAction:(UIButton*)button{
    
    present.text = nil;
    destination.text = nil;
    

    NSLog(@"%ld",(long)button.tag);
    
    if ([_malna isEqualToString:@"Ayala Malls"]) {
        switch (button.tag) {
            case 0:
                [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[0]]]];
                nowFloor.text = floorArray[0];
                break;
            case 1:
                [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[1]]]];
                nowFloor.text = floorArray[1];
                break;
            case 2:
                [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[2]]]];
                nowFloor.text = floorArray[2];
                break;
            case 3:
                [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[3]]]];
                nowFloor.text = floorArray[3];
                break;
            case 4:
                [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[4]]]];
                nowFloor.text = floorArray[4];
                break;
            case 5:
                [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[5]]]];
                nowFloor.text = floorArray[5];
            default:
                break;
        }

    } else if ([_malna isEqualToString:@"MARINE PIA KOBE"]){
        switch (button.tag) {
            case 0:
                [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: kobeArray[0]]]];
                nowFloor.text = floorArray[2];
                break;
            case 1:
                [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: kobeArray[1]]]];
                nowFloor.text = floorArray[3];
                break;
            default:
                break;
        }
    } else if ([_malna isEqualToString:@"MINAMIOSAWA"]){
        switch (button.tag) {
            case 0:
                [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: tamaArray[0]]]];
                nowFloor.text = floorArray[2];
                break;
            case 1:
                [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: tamaArray[1]]]];
                nowFloor.text = floorArray[3];
                break;
            default:
                break;
        }
    } else if ([_malna isEqualToString:@"KISARAZU"]){
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: kisarazu]]];
            nowFloor.text = floorArray[2];
    } else if ([_malna isEqualToString:@"YOKOHAMA BAYSIDE"]){
        switch (button.tag) {
            case 0:
                [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: yokohamaArray[0]]]];
                nowFloor.text = floorArray[2];
                break;
            case 1:
                [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: yokohamaArray[1]]]];
                nowFloor.text = floorArray[3];
                break;
            default:
                break;
        }
    }

}

- (void) handleTapGesture:(UITapGestureRecognizer*)sender {

    NSLog(@"tap");
    _allView.alpha = 0.0;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = NO;

    
    //Floor
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _scrBack.frame = CGRectMake(0, height, pageSize * 200, 250);
    [UIView commitAnimations];
}

// Floormapの処理
-(void)floorBtn:(UIButton *)scrButton {

    // [3-6] ボタン押した時にXCodeコンソールにコメント
    NSLog(@"FloorList");
            // Viewができコード
    _allView.alpha = 0.2;

        _scrBack.alpha = 1.0;
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        _scrBack.frame = CGRectMake(0, height - 250, pageSize * 200, 250);
        [UIView commitAnimations];
        
        //List
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        _listBack.frame = CGRectMake( 0,  height, width ,height);
        [UIView commitAnimations];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    
}
//ListのtableView処理
- (void)listBtn:(UIButton *)myButton {

    if (!isBool) {
        // Viewができコード
        _listBack.alpha = 0.9;
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        _listBack.frame = CGRectMake(0,  0, width ,height);
        [UIView commitAnimations];
        
    } else {
        //List
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        _listBack.frame = CGRectMake( 0,  height, width ,height);
        [UIView commitAnimations];
        
    }
    
    isBool = 1 - isBool;
    
    // alphaの値を0と1で処理するなら　hiddenを代わりに使えば大丈夫YES:見えない
}

//shopviewにリスト名を表示させる
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    //キャッシュを全て消去
    [[NSURLCache sharedURLCache] removeAllCachedResponses];

    
    //javascriptから値を受け取る
    NSURL *URL = [request URL];
    if ([[URL scheme] isEqualToString:@"webview"]) {
        NSLog(@"%@:",[URL query]);
        
        NSString *str = [URL query];
        
        
        NSString *str_After = [str stringByReplacingOccurrencesOfString:@"id=" withString:@""];
        
        
        NSUInteger formindex = [_listArray indexOfObject:str_After];
        // NavigationControllerを使ってpushで遷移
        if ([_malna isEqualToString:@"Ayala Malls"]) {
        if (formindex <= 9) {
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[0]]]];
            nowFloor.text = @"Basement2";
            
        } else if (formindex <= 23 && formindex >= 10) {
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[1]]]];
            nowFloor.text = @"Basement1";
            
        } else if (formindex <= 149 && formindex >= 24) {
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[2]]]];
            nowFloor.text = @"GL";
            
        } else if (formindex <= 316 && formindex >= 150) {
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[3]]]];
            nowFloor.text = @"Floor2";

        } else if (formindex <= 443 && formindex >= 317) {
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[4]]]];
            nowFloor.text = @"Floor3";

        } else if (formindex <= 493 && formindex >= 444) {
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[5]]]];
            nowFloor.text = @"Floor4";

        }
        } else if ([_malna isEqualToString:@"MARINE PIA KOBE"]){
            if (formindex <= 61) {
                [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: kobeArray[0]]]];
                nowFloor.text = @"GL";
                
            } else if (formindex <= 127 && formindex >= 62) {
                [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: kobeArray[1]]]];
                nowFloor.text = @"Floor2";
            }
        } else if ([_malna isEqualToString:@"MINAMIOSAWA"]){
            if (formindex <= 58) {
                [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: tamaArray[0]]]];
                nowFloor.text = @"GL";
                
            } else if (formindex <= 106 && formindex >= 59) {
                [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: tamaArray[1]]]];
                nowFloor.text = @"Floor2";
            }
        } else if ([_malna isEqualToString:@"KISARAZU"]){
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: kisarazu]]];
            nowFloor.text = @"GL";
        } else if ([_malna isEqualToString:@"YOKOHAMA BAYSIDE"]){
            if (formindex <= 39) {
                [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: yokohamaArray[0]]]];
                nowFloor.text = @"GL";
                
            } else if (formindex <= 69 && formindex >= 40) {
                [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: yokohamaArray[1]]]];
                nowFloor.text = @"Floor2";
            }
        }
        
        
        ShopViewController *shopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ShopViewController"];
        
        shopViewController._Name = str_After;

        [self.navigationController pushViewController:shopViewController animated:YES];

        
    }
    
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchDisplayController finalize];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ( tableView == self.searchDisplayController.searchResultsTableView ) {
        return [_searchResult count];
    } else {
        return [_listArray count];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    return @"List";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    // 定数でCellを用意
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if ( tableView == self.searchDisplayController.searchResultsTableView ) {
        cell.textLabel.text = [_searchResult objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [_listArray objectAtIndex:indexPath.row];
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"tap = %ld",(long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 選択状態の解除をします。
    
    ShopViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShopViewController"];
    
    // strプロパティにデータを渡す
    
    if ( tableView == self.searchDisplayController.searchResultsTableView ) {
        dvc._Name = _searchResult[indexPath.row];
    } else {
        dvc._Name = _listArray[indexPath.row];
    }
    NSUInteger index = [_listArray indexOfObject:dvc._Name];
    //List
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _listBack.frame = CGRectMake( 0,  height, width ,height);
    [UIView commitAnimations];
    
    // NavigationControllerを使ってpushで遷移
    [[self navigationController]pushViewController:dvc animated:YES];
    
    if ([_malna isEqualToString:@"Ayala Malls"]) {
        if (index <= 9) {
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[0]]]];
            nowFloor.text = @"Basement2";
            
        } else if (index <= 23 && index >= 10) {
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[1]]]];
            nowFloor.text = @"Basement1";
            
        } else if (index <= 149 && index >= 24) {
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[2]]]];
            nowFloor.text = @"GL";
            
        } else if (index <= 316 && index >= 150) {
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[3]]]];
            nowFloor.text = @"Floor2";
            
        } else if (index <= 443 && index >= 317) {
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[4]]]];
            nowFloor.text = @"Floor3";
            
        } else if (index <= 493 && index >= 444) {
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: ayalaflArray[5]]]];
            nowFloor.text = @"Floor4";
            
        }

    } else if ([_malna isEqualToString:@"MARINE PIA KOBE"]){
        if (index <= 61) {
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: kobeArray[0]]]];
            nowFloor.text = @"GL";
            
        } else if (index <= 127 && index >= 62) {
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: kobeArray[1]]]];
            nowFloor.text = @"Floor2";
        }
    } else if ([_malna isEqualToString:@"MINAMIOSAWA"]){
        if (index <= 58) {
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: tamaArray[0]]]];
            nowFloor.text = @"GL";
            
        } else if (index <= 106 && index >= 59) {
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: tamaArray[1]]]];
            nowFloor.text = @"Floor2";
        }
    } else if ([_malna isEqualToString:@"KISARAZU"]){
        [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: kisarazu]]];
        nowFloor.text = @"GL";
    } else if ([_malna isEqualToString:@"YOKOHAMA BAYSIDE"]){
        if (index <= 39) {
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: yokohamaArray[0]]]];
            nowFloor.text = @"GL";
            
        } else if (index <= 69 && index >= 40) {
            [_myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: yokohamaArray[1]]]];
            nowFloor.text = @"Floor2";
        }
    }
    NSLog(@"Searchbar");
    [self.searchDisplayController setActive:NO animated:YES];

    
}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        
        AppDelegate *appDelege = [[UIApplication sharedApplication] delegate];
        
        appDelege.fromName = nil;
        appDelege.toName = nil;

    }
    [super viewWillDisappear:animated];
}
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}


@end
