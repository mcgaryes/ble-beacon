//
//  PeripheralViewController.m
//  BLEBeacon
//
//  Created by Eric McGary on 10/22/13.
//  Copyright (c) 2013 Eric McGary. All rights reserved.
//

#import "PeripheralViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface PeripheralViewController()<CBPeripheralManagerDelegate>

@property (nonatomic, strong) CBPeripheralManager* manager;
@property (nonatomic, strong) NSDictionary* advertisment;
@property (nonatomic,strong) CLBeaconRegion* region;

@end


@interface PeripheralViewController ()

@end

@implementation PeripheralViewController

-(id) initWithCoder:(NSCoder *)aDecoder
{
    
    if(self = [super initWithCoder:aDecoder])
    {
        _manager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
        NSUUID* myUUID = [[NSUUID alloc] initWithUUIDString: @"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];
        _region = [[CLBeaconRegion alloc] initWithProximityUUID:myUUID major:0 minor:0 identifier:@"co.rlab.region"];
        _advertisment = [_region peripheralDataWithMeasuredPower:nil];
    }
    return self;
}


- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOff:
            _advertisingLabel.alpha = .15;
            [_manager stopAdvertising];
            break;
        case CBPeripheralManagerStatePoweredOn:
            [_manager startAdvertising:_advertisment];
            break;
        default:
            // ...
            break;
    }
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral
                                       error:(NSError *)error
{
    if(!error) _advertisingLabel.alpha = 1.0;
}

#pragma mark - IBActions

- (IBAction)startAdvertising:(id)sender
{
    [_manager startAdvertising:_advertisment];
}

- (IBAction)stopAdvertising:(id)sender
{
    [_manager stopAdvertising];
}


@end
