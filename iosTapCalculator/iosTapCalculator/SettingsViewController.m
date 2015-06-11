//
//  SettingsViewController.m
//  iosTapCalculator
//
//  Created by Anson Ng on 6/11/15.
//  Copyright (c) 2015 Anson Ng. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (strong, nonatomic) IBOutlet UITextField *cacheTimeMinText;
@property (strong, nonatomic) IBOutlet UILabel *willExpriedMinText;

@property (strong, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (strong, nonatomic) NSString * cacheKey;
@end

@implementation SettingsViewController
- (instancetype) init
{
    self = [super init];
    self.cacheKey = @"tipCalculator";
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateFromCache];
}

- (void) updateFromCache
{
    self.willExpriedMinText.text  = [NSString stringWithFormat: @"%.0f min", [self getLeaveMin]];
    NSInteger nsi = (NSInteger) [self getCachePresentIndex];
    [self.tipControl setSelectedSegmentIndex:nsi];
 

}

- (int)getCachePresentIndex
{
    NSMutableDictionary *cacheData = [self getCacheDictionary];
    int cachePresentIndex = 0;
    
    CGFloat tipPresent =  [cacheData[@"tipPresent"] floatValue];
    NSLog(@"tipPresent::%f", tipPresent);
    if (tipPresent == 0.1f) {
        cachePresentIndex = 0;
    } 
    if (tipPresent == 0.15f) {
        cachePresentIndex = 1;
    }
    if (tipPresent == 0.2f) {
        cachePresentIndex = 2;
    }
    return cachePresentIndex;
}

- (CGFloat)getLeaveMin
{
    NSMutableDictionary *cacheData = [self getCacheDictionary];

    CGFloat cacheLeaveTime = ( [cacheData[@"expiredTime"] floatValue] - [self getCurrentTime])/ 60;
    NSLog(@"cacheLeaveTime::%f", cacheLeaveTime);
    CGFloat result = 0;
    if (cacheLeaveTime > 0) {
        result = cacheLeaveTime;
    }
    
    return result;
}


-(CGFloat)getCurrentTime
{
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];

    return timeStamp;
}


- (IBAction)saveData:(id)sender
{
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    //CGFloat tipPersentValue
    
    CGFloat tipPersentValue =
    [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    
    
    if ([self.cacheTimeMinText.text integerValue] > 0 && [self.cacheTimeMinText.text integerValue] < 11) {
        
        [self setTipPresentInCacahe:tipPersentValue mins:[self.cacheTimeMinText.text integerValue]];
    }
    
}

-(void) setTipPresentInCacahe:(CGFloat) persent mins:(CGFloat) mins
{

    CGFloat expiredTime = [self getCurrentTime] + (mins * 60);
    NSString *expiredTimeString = [NSString stringWithFormat: @"%.2f", expiredTime];
    NSString *tipPresentString = [NSString stringWithFormat: @"%.2f", persent];
    NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
    data = @{
             @"expiredTime": expiredTimeString,
             @"tipPresent": tipPresentString,
             };
    NSLog(@"data::%@", data);
    [self setCacheDictionary:data];
    
}
-(NSMutableDictionary *)getCacheDictionary
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [defaults objectForKey:self.cacheKey];
    return dic;
}

-(void)setCacheDictionary:(NSMutableDictionary *) dic
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: dic forKey:self.cacheKey];
    [defaults synchronize];
}



-(void)updateValues
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
