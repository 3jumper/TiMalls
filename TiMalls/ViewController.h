//
//  ViewController.h
//  TiMalls
//
//  Created by hayato on 3/23/14.
//  Copyright (c) 2014 hayato miyoshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MallMapsViewController.h"

@interface ViewController : UIViewController <MKMapViewDelegate ,CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    //MKMapView *myMapView;
    CLLocationManager *locationManager;
    //__strong CLLocationManager *_locationManager;
    
}
@property (nonatomic, retain) CLLocationManager *locationManager;
-(void) onResume;
-(void) onPause;
@property (nonatomic, strong) MKMapView *myMapView;
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;

@end