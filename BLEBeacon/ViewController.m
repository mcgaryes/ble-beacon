//
//  ViewController.m
//  BLEBeacon
//
//  Created by Eric McGary on 10/16/13.
//  Copyright (c) 2013 Eric McGary. All rights reserved.
//

#import "ViewController.h"
#import "RIBeaconNotifier.h"

@interface ViewController () <RIBeaconNotifierDelegate>

@property (nonatomic,strong) RIBeaconNotifier* notifier;

@end

@implementation ViewController

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) {
        _notifier = [[RIBeaconNotifier alloc] initWithUUID:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"
                                               andWithIdentifier:@"rlab-beacon"];
        _notifier.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)startRanging:(id)sender
{
    [_notifier startRanging];
}

- (IBAction)stopRanging:(id)sender
{
    _immediateLabel.alpha = .15;
    _nearLabel.alpha = .15;
    _farLabel.alpha = .15;
    _unknownLabel.alpha = 1;
    [_notifier stopRanging];
}


#pragma mark - RIBeaconNotifierDelegate Methods

-(void) beaconNotifier:(RIBeaconNotifier *)beaconNotifer didEncounterError:(NSError *)error
{
    NSLog(@"%@",error.localizedDescription);
}

-(void) beaconNotifier:(RIBeaconNotifier *)beaconNotifer didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    for (NSInteger i = 0; i<beacons.count; i++) {
        CLBeacon* beacon = [beacons objectAtIndex:i];
        if([beacon.major isEqual:@0] && [beacon.minor isEqual:@0]) {
            
            _immediateLabel.alpha = .15;
            _nearLabel.alpha = .15;
            _farLabel.alpha = .15;
            _unknownLabel.alpha = .15;
            
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

@end
