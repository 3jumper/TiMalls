//
//  ViewController.m
//  TiMalls
//
//  Created by hayato on 3/23/14.
//  Copyright (c) 2014 hayato miyoshi. All rights reserved.
//

#import "ViewController.h"
#import "MyAnnotation.h"

#define width self.view.bounds.size.width
#define height self.view.bounds.size.height
#define NAVBAR_H    44
#define TABBAR_H    50

@interface ViewController () {
    UIView* mallView;
    UITableView* mallTable;
    NSArray* mallArray;
    BOOL maBool;
    NSArray* masuArray;


}

@end

@implementation ViewController

@synthesize locationManager;
@synthesize myMapView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self defaults];

    self.navigationItem.title = @"World Map";
    
    myMapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, width, height)];

    // 表示位置を設定
    CLLocationCoordinate2D co;

    //アヤラの位置を設定
    // Geocodingを使うと緯度経度が分かる
    co.latitude = 10.317347; // 緯度
    co.longitude = 123.905759; //経度
    
    [myMapView setCenterCoordinate:co animated:NO];
    
    MKCoordinateRegion cr = myMapView.region;
    cr.center = co;
    cr.span.latitudeDelta = 50;
    cr.span.longitudeDelta = 50;
    [myMapView setRegion:cr animated:NO];
    
    self.myMapView.delegate = self;
    
    [self.view addSubview:myMapView];
    
    
    locationManager = [[CLLocationManager alloc] init];
    
    // 位置情報サービスが利用できるかどうかをチェック
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager.delegate = self; // ……【1】
        // 測位開始
        [locationManager startUpdatingLocation];
    } else {
        NSLog(@"Location services not available.");
    }
    
    mallArray = @[@"Ayala Malls",@"MARINE PIA KOBE",@"MINAMIOSAWA",@"KISARAZU",@"YOKOHAMA BAYSIDE"];
    masuArray = @[@"Cebu City (SM)",@"MITSUI OUTLET PARK(OM)",@"MITSUI OUTLET PARK(OM)",@"MITSUI OUTLET PARK(OM)",@"MITSUI OUTLET PARK(OM)"];
    
    
    [myMapView addAnnotation:
     [[MyAnnotation alloc]initWithLocationCoordinate:CLLocationCoordinate2DMake(10.317347, 123.905759)
                                                   title:@"Ayala Malls"
                                                subtitle:@"Cebu City (SM)"
      ]];
    [myMapView addAnnotation:
     [[MyAnnotation alloc]initWithLocationCoordinate:CLLocationCoordinate2DMake(34.626144, 135.047525)
                                               title:@"MARINE PIA KOBE"
                                            subtitle:@"MITSUI OUTLET PARK(OM)"
      ]];
    [myMapView addAnnotation:
     [[MyAnnotation alloc]initWithLocationCoordinate:CLLocationCoordinate2DMake(35.614188, 139.377316)
                                               title:@"MINAMIOSAWA"
                                            subtitle:@"MITSUI OUTLET PARK(OM)"
      ]];
    [myMapView addAnnotation:
     [[MyAnnotation alloc]initWithLocationCoordinate:CLLocationCoordinate2DMake(35.434671, 139.935293)
                                               title:@"KISARAZU"
                                            subtitle:@"MITSUI OUTLET PARK(OM)"
      ]];
    [myMapView addAnnotation:
     [[MyAnnotation alloc]initWithLocationCoordinate:CLLocationCoordinate2DMake(35.380347, 139.645334)
                                               title:@"YOKOHAMA BAYSIDE"
                                            subtitle:@"MITSUI OUTLET PARK(OM)"
      ]];
    
    mallView = [[UIView alloc] initWithFrame:CGRectMake( 0,  height, width , height - TABBAR_H - NAVBAR_H - 20)];
    mallView.backgroundColor = [UIColor clearColor];
    mallView.alpha = 0.0;
    [self.view addSubview:mallView];
    mallTable = [[UITableView alloc] initWithFrame:CGRectMake(0,  NAVBAR_H + 20, width , height - TABBAR_H - NAVBAR_H - 20)];
    
    
    mallTable.dataSource = self;
    mallTable.delegate = self;
    
    
    [mallView addSubview:mallTable];
    
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                              target:self
                                                                              action:@selector(listBtn:)];
    self.navigationItem.rightBarButtonItems = @[myButton];
    
    mallTable.rowHeight = 50;

}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    //緯度・経度を出力
    NSLog(@"didUpdateToLocation latitude=%f, longitude=%f",
          [newLocation coordinate].latitude,
          [newLocation coordinate].longitude);
    
    MKCoordinateRegion region = MKCoordinateRegionMake([newLocation coordinate], MKCoordinateSpanMake(50, 50));
    [myMapView setCenterCoordinate:[newLocation coordinate]];
    [locationManager stopUpdatingLocation];
    [myMapView setRegion:region];
    
}

// 測位失敗時や、5位置情報の利用をユーザーが「不許可」とした場合などに呼ばれる
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError");
    
}


-(void) onResume {
    if (nil == locationManager && [CLLocationManager locationServicesEnabled])
        [locationManager startUpdatingLocation]; //測位再開
}

-(void) onPause {
    if (nil == locationManager && [CLLocationManager locationServicesEnabled])
        [locationManager stopUpdatingLocation]; //測位停止
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    MallMapsViewController *mall = [self.storyboard instantiateViewControllerWithIdentifier:@"MallMapsViewController"];
    
    //    mall.mama = marker;
    mall.malna = view.annotation.title;
    
    [[self navigationController]pushViewController:mall animated:YES];

}

- (void)defaults {
    // UseDefaultsを作って初回起動時分岐処理実装
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // UseDefaultsでBoolを扱う場合
    BOOL isBool = [defaults boolForKey:@"KEY_BOOL"];
    if (!isBool) {
        self.tabBarController.selectedIndex = 1;

        // deraultsの値を変更して保存 最終的にsetBoolで保存している
        [defaults setBool:YES forKey:@"KEY_BOOL"];
        [defaults synchronize];
        
    }
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id )annotation
{
    static NSString* Identifier = @"PinAnnotationIdentifier";
    MKPinAnnotationView* pinView = (MKPinAnnotationView *)[mapView
                                                           dequeueReusableAnnotationViewWithIdentifier:Identifier];
    
    if (pinView == nil) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                  reuseIdentifier:Identifier];
        
        //  デスクロージャ追加
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        pinView.rightCalloutAccessoryView = rightButton;
        //コールアウト表示
        pinView.canShowCallout = YES;
        
        return pinView;
    }
    pinView.annotation = annotation;
    return pinView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mallArray.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"List";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // 定数でCellを用意
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"a"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.textLabel.text = [mallArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [masuArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MallMapsViewController *mallta = [self.storyboard instantiateViewControllerWithIdentifier:@"MallMapsViewController"];
    
    //    mall.mama = marker;
    mallta.malna = mallArray[indexPath.row];
    
    [[self navigationController]pushViewController:mallta animated:YES];
    
}
- (void)listBtn:(UIButton *)myButton {
    
    if (!maBool) {
        // Viewができコード
        NSLog(@"open=%d",maBool);
        mallView.alpha = 0.9;
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        mallView.frame = CGRectMake(0,  0, width ,height);
        [UIView commitAnimations];
        
    } else {
        //List
        NSLog(@"hide=%d",maBool);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        mallView.frame = CGRectMake( 0,  height, width ,height);
        [UIView commitAnimations];
        
    }
    NSLog(@"%d",maBool);
    
    maBool = 1 - maBool;
    
    // alphaの値を0と1で処理するなら　hiddenを代わりに使えば大丈夫YES:見えない
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
