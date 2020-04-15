//
//  AppDelegate.m
//  printer.sdk.external.example
//
//  Created by Oleh Piskorskyj on 5/10/19.
//  Copyright © 2019 investbank. All rights reserved.
//

#import "AppDelegate.h"
#import "Views/Initial/Initial.h"

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    mWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [mWindow setBackgroundColor:[UIColor whiteColor]];
    
    mNavigationController = [[UINavigationController alloc] init];
    [mNavigationController.view setBackgroundColor:[UIColor whiteColor]];
    [mNavigationController setNavigationBarHidden:TRUE];
    
    [mWindow setRootViewController:mNavigationController];
    [mWindow makeKeyAndVisible];
    
    Initial *initial = [[Initial alloc] init];
    [mNavigationController pushViewController:initial animated:FALSE];
    [initial release];
    
    //[[UIApplication sharedApplication] setStatusBarHidden:FALSE];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    return TRUE;
}

-(void)applicationWillResignActive:(UIApplication *)application
{
}

-(void)applicationDidEnterBackground:(UIApplication *)application
{
}

-(void)applicationWillEnterForeground:(UIApplication *)application
{
}

-(void)applicationDidBecomeActive:(UIApplication *)application
{
}

-(void)applicationWillTerminate:(UIApplication *)application
{
}

#pragma mark - Public methods
-(UIWindow *)window
{
    return mWindow;
}

@end
