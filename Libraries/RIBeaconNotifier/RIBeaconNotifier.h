//
//  BeaconNotifier.h
//  BeaconNotifier
//
//  Created by Eric McGary on 10/16/13.
//  Copyright (c) 2013 Eric McGary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <CoreLocation/CLBeaconRegion.h>

@protocol RIBeaconNotifierDelegate;

@interface RIBeaconNotifier : NSObject <CLLocationManagerDelegate>

@property (nonatomic,strong) id<RIBeaconNotifierDelegate> delegate;

-(id) initWithUUID:(NSString *)uuid andWithIdentifier:(NSString*)identifier;

-(void) startRanging;
-(void) stopRanging;

@end

@protocol RIBeaconNotifierDelegate <NSObject>

-(void) beaconNotifier:(RIBeaconNotifier*)beaconNotifer didRangeBeacons:(NSArray*)beacons inRegion:(CLBeaconRegion*)region;

-(void) beaconNotifier:(RIBeaconNotifier *)beaconNotifer didEncounterError:(NSError*)error;

@end