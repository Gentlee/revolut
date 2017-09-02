//
//  AppDelegate.m
//  revolut
//
//  Created by Alexander Danilov on 31/08/2017.
//  Copyright © 2017 Home. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
    
@synthesize apiService = _apiService;
@synthesize currencyManager = _currencyManager;
@synthesize userManager = _userManager;
    
+ (AppDelegate *)sharedInstance{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
    
- (instancetype)init {
    self = [super init];
    if (self) {
        _apiService = [ApiService new];
        _currencyManager = [[CurrencyManager alloc] initWithApiService: _apiService];
        _userManager = [UserManager new];
    }
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[NSNotificationCenter defaultCenter] addObserverForName:@"Error" object:nil queue:nil usingBlock:^(NSNotification *notificaion){
        NSError *error = [notificaion.userInfo valueForKey:@"error"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction: [UIAlertAction actionWithTitle:@"Dismiss" style:0 handler:nil]];
        [[self.window rootViewController] presentViewController:alert animated:true completion:nil];
    }];
    
    [_currencyManager startUpdatingRates];
    
    return YES;
}

@end
