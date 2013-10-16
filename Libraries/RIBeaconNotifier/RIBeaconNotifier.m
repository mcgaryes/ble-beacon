//
//  BeaconNotifier.m
//  BeaconNotifier
//
//  Created by Eric McGary on 10/16/13.
//  Copyright (c) 2013 Eric McGary. All rights reserved.
//


#import "RIBeaconNotifier.h"

@interface RIBeaconNotifier()

@property (nonatomic,strong) CLLocationManager* manager;
@property (nonatomic,strong) CLBeaconRegion* region;
@property (nonatomic) BOOL isRanging;

@end

@implementation RIBeaconNotifier

#pragma mark - Init Methods

-(id) initWithUUID:(NSString *)uuid
 andWithIdentifier:(NSString*)identifier
{
    
    if(self = [super init])
    {
        
        _manager = [[CLLocationManager alloc] init];
        
        if([CLLocationManager isRangingAvailable])
        {
            NSUUID* myUUID = [[NSUUID alloc] initWithUUIDString: uuid];
            
            
            _region = [[CLBeaconRegion alloc] initWithProximityUUID:myUUID
                                                              major:0
                                                              minor:0
                                                         identifier:identifier];
            _region.notifyEntryStateOnDisplay = YES;
            _manager.delegate = self;
        }
        else
        {
            if(_delegate) [_delegate beaconNotifier:self
                                  didEncounterError:[NSError errorWithDomain:@"BeaconNotifier" code:0 userInfo:@{NSLocalizedDescriptionKey:@"Ranging not available"}]];
        }
        
    }
    return self;
}

#pragma mark - Public Methods

-(void) startRanging
{
    if(!_isRanging && [CLLocationManager isRangingAvailable])
    {
        _isRanging = YES;
        [_manager startRangingBeaconsInRegion:_region];
    }
}

-(void) stopRanging
{
    if(_isRanging && [CLLocationManager isRangingAvailable])
    {
        _isRanging = NO;
        [_manager stopRangingBeaconsInRegion:_region];
    }
}

#pragma mark - CLLocaationManagerDelegate Methods

/**
 * Tells the delegate that one or more beacons are in range. (required)
 */
-(void) locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region
{
    if(_delegate) [_delegate beaconNotifier:self didRangeBeacons:beacons inRegion:region];
}

-(void) locationManager:(CLLocationManager *)manager
rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region
              withError:(NSError *)error
{
    if(_delegate) [_delegate beaconNotifier:self didEncounterError:error];
}

@end