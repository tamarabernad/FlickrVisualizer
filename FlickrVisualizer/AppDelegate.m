//
//  AppDelegate.m
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 19/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import "AppDelegate.h"
#import "FlickrKit.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FlickrKit sharedFlickrKit] initializeWithAPIKey:@"6aed94b5e51b7b8d33340dd6f670894c" sharedSecret:@"f5a8f66d07d6a5f4"];
    
    [self styleAppearance];
    return YES;
}

- (void)styleAppearance{
    NSDictionary *attributesTitle = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIColor whiteColor], NSForegroundColorAttributeName,
                                     [UIFont fontWithName:@"BebasNeue" size:20],NSFontAttributeName,
                                     nil];
    [[UINavigationBar appearance] setTitleTextAttributes:attributesTitle];
}

@end
