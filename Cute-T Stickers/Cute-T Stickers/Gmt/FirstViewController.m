//
//  FirstViewController.m
//  FunnyBirthCard
//
//  Created by Ankit Garg on 5/5/20.
//  Copyright © 2020 Yusri. All rights reserved.
//

#import "FirstViewController.h"
#import "ImagesViewController.h"
#import "Cute_T_Stickers-Swift.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(IBAction)useStickers
{
    HomeViewController *vc=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(IBAction)clickGetLikes
{
    ImagesViewController *VC=[[ImagesViewController alloc] initWithNibName:@"ImagesViewController" bundle:nil];
    
    UINavigationController *navigationController=[[UINavigationController alloc] initWithRootViewController:VC];
    navigationController.modalPresentationStyle=UIModalPresentationFullScreen;
    [navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

@end
