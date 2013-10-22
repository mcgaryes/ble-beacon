//
//  ViewController.h
//  BLEBeacon
//
//  Created by Eric McGary on 10/16/13.
//  Copyright (c) 2013 Eric McGary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CentralViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *monitoringLabel;
@property (weak, nonatomic) IBOutlet UILabel *rangingLabel;

@property (weak, nonatomic) IBOutlet UILabel *unknownLabel;
@property (weak, nonatomic) IBOutlet UILabel *immediateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nearLabel;
@property (weak, nonatomic) IBOutlet UILabel *farLabel;

@end
