//
//  ViewController.m
//  BLEBeacon
//
//  Created by Eric McGary on 10/16/13.
//  Copyright (c) 2013 Eric McGary. All rights reserved.
//

#import "CentralViewController.h"
#import "AppDelegate.h"

@interface CentralViewController () <CLLocationManagerDelegate>

    @property (nonatomic,strong) CLLocationManager* manager;
    @property (nonatomic,strong) CLBeaconRegion* region;

@end

@implementation CentralViewController

-(id) initWithCoder:(NSCoder *)aDecoder
{
    
    if(self = [super initWithCoder:aDecoder]) {

        if([CLLocationManager isRangingAvailable]) {
            
            _manager = [[CLLocationManager alloc] init];
            _manager.delegate = self;

            NSUUID* UUID = [[NSUUID alloc] initWithUUIDString: @"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];
            _region = [[CLBeaconRegion alloc] initWithProximityUUID:UUID major:0 minor:0 identifier:@"co.rlab.region"];
            _region.notifyEntryStateOnDisplay = YES;
            _region.notifyOnEntry = YES;
            _region.notifyOnExit = YES;
            
        }
        
    }
    
    return self;
}

-(void) viewDidAppear:(BOOL)animated
{
    [_manager startMonitoringForRegion:_region];
    _monitoringLabel.alpha = 1.0;
    
    NSLog(@"%@",_manager.monitoredRegions);
}

#pragma mark - CLLocaationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    _rangingLabel.alpha = 1.0;
    [_manager startRangingBeaconsInRegion:_region];
    [[[UIAlertView alloc] initWithTitle:@"Alert"
                                message:@"Exiting Region"
                               delegate:Nil
                      cancelButtonTitle:@"Ok"
                      otherButtonTitles:nil] show];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    _rangingLabel.alpha = .15;
    [_manager stopRangingBeaconsInRegion:_region];
    [[[UIAlertView alloc] initWithTitle:@"Alert"
                                message:@"Exiting Region"
                               delegate:Nil
                      cancelButtonTitle:@"Ok"
                      otherButtonTitles:nil] show];
}

-(void) locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region
              withError:(NSError *)error
{
    NSLog(@"%@",error.localizedDescription);
    _monitoringLabel.alpha = .15;
}

-(void) locationManager:(CLLocationManager *)manager
rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region
              withError:(NSError *)error
{
    NSLog(@"%@",error.localizedDescription);
    _rangingLabel.alpha = .15;
}

-(void) locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region
{
    
    for (NSInteger i = 0; i<beacons.count; i++) {
        
        CLBeacon* beacon = [beacons objectAtIndex:i];
        
        if([beacon.major isEqual:@0] && [beacon.minor isEqual:@0]) {
            
            // reset labels
            
            _immediateLabel.alpha = .15;
        
            _nearLabel.alpha = .15;
            
            _farLabel.alpha = .15;
            
            _unknownLabel.alpha = .15;
            
            // update labels to shgw proximity
            
            if(beacon.proximity == CLProximityImmediate) {
                
                _immediateLabel.alpha = 1;
                
            } else if( beacon.proximity == CLProximityNear) {
                
                _nearLabel.alpha = 1;
                
            } else if(beacon.proximity == CLProximityFar) {
                
                _farLabel.alpha = 1;
                
            } else if (beacon.proximity == CLProximityUnknown) {
                
                _unknownLabel.alpha = 1;
                
            }
            
        }
        
    }

}

-(void) locationManager:(CLLocationManager *)manager
      didDetermineState:(CLRegionState)state
              forRegion:(CLRegion *)region
{
    NSLog(@"%@",region);
}

#pragma mark - IBActions

- (IBAction)startRanging:(id)sender
{
    
    _rangingLabel.alpha = 1;
    
    [_manager startRangingBeaconsInRegion:_region];
    
}

- (IBAction)stopRanging:(id)sender
{
    
    _rangingLabel.alpha = .15;
    
    [_manager stopRangingBeaconsInRegion:_region];
    
}

@end
