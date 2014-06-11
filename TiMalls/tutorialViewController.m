//
//  tutorialViewController.m
//  TiMalls
//
//  Created by hayato on 4/5/14.
//  Copyright (c) 2014 hayato miyoshi. All rights reserved.
//

#import "tutorialViewController.h"

@interface tutorialViewController () {
    NSArray* tutoArray;
}

@end

@implementation tutorialViewController

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
    NSInteger pageSize = 6; // ページ数
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.6 green:0.98 blue:0.6 alpha:1.0];
    self.view.alpha = 1.0;
    
    // プログラミング言語の名前を持った配列を用意する
    tutoArray = @[@"1.ピンを押し、吹き出しを押すとモールの地図が表示！\nYou tap the white balloon after tapping the red balloon.And then the map in hall is displayed.",
                  @"2.お探しのお店を見つける方法は地図からお店を押し、吹き出しのinformationを押す！\nA method to find a shop is to tap it from the map in hall.",
                  @"3.もう一つは右上の検索ボタンからお店を探せる！\nYou can look for another method from a search button of the top right corner.",
                  @"4.現在地の場合「From」\n目的地の場合「To」を押す\nIn the case of the current location, you tap [From]. In the case of a destination, you tap [To].",
                  @"5.右上にあるbookのマークを押すと各フロアを選択可能に！\nYou can choose each floor when you tap the mark of the book in the top right corner.",
                  @"6.「From」の場合色は「青」に！\n「To」の場合色は「赤」に変わります！右下にある「Share」を押すとみんなに共有が可能に！いつでもこの説明は下の真ん中ボタンを押して確認が可能！さぁここからスタートです。下にある「Let's start!!」を押してこのアプリが始まる！\n\nIn the case of [From] , the color turns into [blue], and, in the case of [To] , the color turns into [red]!You can share someone when you tap [Share] in the lower right.You can confirm this explanation anytime by tapping the button of the middle below.It is a start from here. The application begins after you tap [Let's start!!] in the bottom."];
    
    
    // UIScrollViewのインスタンス化
    tutoScroView = [[UIScrollView alloc]init];
    tutoScroView.frame = self.view.bounds;
    
    // 横スクロールのインジケータを非表示にする
    tutoScroView.showsHorizontalScrollIndicator = NO;
    
    // ページングを有効にする
    tutoScroView.pagingEnabled = YES;
    // スクロールを可能にするかどうか
    tutoScroView.userInteractionEnabled = YES;
    tutoScroView.delegate = self;
    tutoScroView.scrollsToTop = YES;
    
    // スクロールの範囲を設定
    [tutoScroView setContentSize:CGSizeMake((pageSize * width), height)];
    
    // スクロールビューを貼付ける
    [self.view addSubview:tutoScroView];
    
    // スクロールビューにラベルを貼付ける
    for (int i = 0; i < pageSize - 2; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"tuto%d.png", i + 1]];
        UIImageView *page = [[UIImageView alloc] initWithImage:img];
        page.frame = CGRectMake(30 + i * width, 90, 260 , 323 );
        page.alpha = 1;
        page.contentMode = UIViewContentModeScaleAspectFit;
        [tutoScroView addSubview:page];
    }
    for (int it = 0; it <  5; it++) {
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(it * width + 10, 20, width - 20, 100)];
        textView.text = [NSString stringWithFormat:@"%@", tutoArray[it]];
        textView.font = [UIFont fontWithName:@"Arial" size:12];
        textView.layer.borderColor = [[UIColor grayColor] CGColor];
        textView.backgroundColor = [UIColor clearColor];
        textView.alpha = 1.0;
        textView.textAlignment = NSTextAlignmentCenter;
        textView.editable = NO;
        
        [tutoScroView addSubview:textView];
    }
    
    UIImage *tu51 = [UIImage imageNamed:[NSString stringWithFormat:@"tuto51.png"]];
    UIImageView *pagetuto1 = [[UIImageView alloc] initWithImage:tu51];
    pagetuto1.frame = CGRectMake( 1310, 90, 260 , 35 );
    pagetuto1.alpha = 1;
    pagetuto1.contentMode = UIViewContentModeScaleAspectFit;
    [tutoScroView addSubview:pagetuto1];
    
    UIImage *tu52 = [UIImage imageNamed:[NSString stringWithFormat:@"tuto52.png"]];
    UIImageView *pagetuto2 = [[UIImageView alloc] initWithImage:tu52];
    pagetuto2.frame = CGRectMake( 1310, 150, 260 , 261 );
    pagetuto2.alpha = 1;
    pagetuto2.contentMode = UIViewContentModeScaleAspectFit;
    [tutoScroView addSubview:pagetuto2];
    
    UITextView *textView6 = [[UITextView alloc]initWithFrame:CGRectMake(1610, 100, 300, 200)];
    textView6.text = [NSString stringWithFormat:@"%@", tutoArray[5]];
    textView6.font = [UIFont fontWithName:@"Arial" size:12];
    textView6.layer.borderColor = [[UIColor grayColor] CGColor];
    textView6.backgroundColor = [UIColor clearColor];
    textView6.alpha = 1.0;
    textView6.textAlignment = NSTextAlignmentCenter;
    textView6.editable = NO;
    
    [tutoScroView addSubview:textView6];
    
    // ページコントロールのインスタンス化
    CGFloat x = (width - 300) / 2;
    tutoPageView = [[UIPageControl alloc]initWithFrame:CGRectMake(x, height - 65, 300, 20)];
    
    // 背景色を設定
    tutoPageView.backgroundColor = [UIColor clearColor];
    // 表示してないドットの色
    tutoPageView.pageIndicatorTintColor = [UIColor grayColor];
    // 表示しているドットの色
    tutoPageView.currentPageIndicatorTintColor = [UIColor whiteColor];
    tutoPageView.alpha = 1.0;
    
    // ページ数を設定
    tutoPageView.numberOfPages = pageSize;
    
    // 現在のページを設定
    tutoPageView.currentPage = 0;
    
    // ページコントロールをタップされたときに呼ばれるメソッドを設定
    tutoPageView.userInteractionEnabled = YES;
    [tutoPageView addTarget:self
                    action:@selector(pageControl_Tapped:)
          forControlEvents:UIControlEventValueChanged];
    
    // ページコントロールを貼付ける
    [self.view addSubview:tutoPageView];
    
    UIButton *Btn = [[UIButton alloc] initWithFrame:CGRectMake(pageSize * width - width/2 -50, 390 , 100, 30)];
    
    [Btn setTitle:@"Let's start!!" forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    Btn.layer.borderColor = [UIColor grayColor].CGColor;
    Btn.layer.borderWidth = 1.0f;
    Btn.layer.cornerRadius = 7.5f;
    
    [Btn addTarget:self action:@selector(modal:) forControlEvents:UIControlEventTouchUpInside];
    [tutoScroView addSubview:Btn];
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    CGFloat pageWidth = tutoScroView.frame.size.width;
    if ((NSInteger)fmod(tutoScroView.contentOffset.x , pageWidth) == 0) {
        // ページコントロールに現在のページを設定
        tutoPageView.currentPage = tutoScroView.contentOffset.x / pageWidth;
    }
}

- (void)pageControl_Tapped:(id)sender
{
    CGRect frame = tutoScroView.frame;
    frame.origin.x = frame.size.width * tutoPageView.currentPage;
    [tutoScroView scrollRectToVisible:frame animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)modal:(UIButton *)Btn {
    // TODO: 遷移するコードを書く
    UITabBarController *controller = self.tabBarController;
    controller.selectedViewController = [controller.viewControllers objectAtIndex: 0];
    
    [tutoScroView setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];

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
