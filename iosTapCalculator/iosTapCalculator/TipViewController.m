//
//  TipViewController.m
//  iosTapCalculator
//
//  Created by Anson Ng on 6/11/15.
//  Copyright (c) 2015 Anson Ng. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()

@end

@implementation TipViewController

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"tip calculator";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateFromCache];
}
-(void) onSettingsButton
{
    NSLog(@"hi");
    //[self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
    SettingsViewController *settingsViewController = [[SettingsViewController alloc]init];
  //  MainView *nextView = [[MainView alloc] init];
    [UIView animateWithDuration:0.75
                     animations:^{
                         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                         [self.navigationController pushViewController:settingsViewController animated:NO];
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
                     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateFromCache
{

    SettingsViewController *settingsViewController = [[SettingsViewController alloc]init];

    NSInteger nsi = (NSInteger) [settingsViewController getCachePresentIndex];
    [self.tipControl setSelectedSegmentIndex:nsi];
    
}

- (IBAction)onTip:(id)sender {
    [self.view endEditing:YES];
    [self updateValue];
}
- (IBAction)selectTipPersent:(id)sender {
}

-(void) updateValue
{
    CGFloat billAmount = [self.billInputText.text floatValue];
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    CGFloat tipAmount = billAmount *
    [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    CGFloat totalAmount = billAmount + tipAmount;
    self.tipValueLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalValueLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
