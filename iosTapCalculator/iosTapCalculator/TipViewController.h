//
//  TipViewController.h
//  iosTapCalculator
//
//  Created by Anson Ng on 6/11/15.
//  Copyright (c) 2015 Anson Ng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"
@interface TipViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *billInputText;
@property (strong, nonatomic) IBOutlet UILabel *tipValueLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *tipControl;

@property (strong, nonatomic) IBOutlet UILabel *totalValueLabel;
@end
