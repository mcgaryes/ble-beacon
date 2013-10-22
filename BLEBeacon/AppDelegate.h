//
//  AppDelegate.h
//  BLEBeacon
//
//  Created by Eric McGary on 10/16/13.
//  Copyright (c) 2013 Eric McGary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocationManager* manager;

@end
