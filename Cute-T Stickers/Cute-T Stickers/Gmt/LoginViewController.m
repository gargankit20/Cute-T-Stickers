//
//  LoginViewController.m
//  FunnyBirthCard
//
//  Created by Ankit Garg on 5/5/20.
//  Copyright © 2020 Yusri. All rights reserved.
//

#import "LoginViewController.h"
#import "AFHTTPRequestOperation.h"
#import "Toast+UIView.h"
#import "AFHTTPClient.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"Login";
    
    [self getTemporaryServers];
    
    UIView *paddingView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _usernameTxt.leftView=paddingView;
    _usernameTxt.leftViewMode=UITextFieldViewModeAlways;
}

-(void)getTemporaryServers
{
    NSString *urlString=@"http://cutetstickers.co/sticker_loader_test.php";
    NSURL *baseURL=[NSURL URLWithString:urlString];
    
    AFHTTPClient *httpClient=[[AFHTTPClient alloc] initWithBaseURL:baseURL];
    NSMutableURLRequest *request=[httpClient requestWithMethod:@"GET" path:urlString parameters:nil];
    
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        NSDictionary *responseDic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:responseDic[@"a1"] forKey:@"a1"];
        [[NSUserDefaults standardUserDefaults] setObject:responseDic[@"a2"] forKey:@"a2"];
    }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
        
    }];
    [operation start];
}

-(void)getTemporaryID
{
    NSString *urlString=[NSString stringWithFormat:@"%@/get_u_id.php", [[NSUserDefaults standardUserDefaults] stringForKey:@"a1"]];
    NSURL *baseURL=[NSURL URLWithString:urlString];
    
    AFHTTPClient *httpClient=[[AFHTTPClient alloc] initWithBaseURL:baseURL];
    NSMutableURLRequest *request=[httpClient requestWithMethod:@"GET" path:urlString parameters:nil];
    
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        NSDictionary *responseDic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:responseDic[@"id"] forKey:@"userID"];
    }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
        
    }];
    [operation start];
}

-(IBAction)getUserID
{
    [_usernameTxt resignFirstResponder];
    
    if(_usernameTxt.text.length<1)
    {
        [self createAlertView:@"Message" message:@"Please enter user name"];
    }
    else
    {
        [self.view makeToastActivity];
        
        NSString *urlString=[NSString stringWithFormat:@"https://www.instagram.com/%@/?__a=1", _usernameTxt.text];
        NSURL *baseURL=[NSURL URLWithString:urlString];
        
        AFHTTPClient *httpClient=[[AFHTTPClient alloc] initWithBaseURL:baseURL];
        NSMutableURLRequest *request=[httpClient requestWithMethod:@"GET" path:urlString parameters:nil];
        
        AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
            [self.view hideToastActivity];
            
            NSDictionary *responseDic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSString *userID=responseDic[@"graphql"][@"user"][@"id"];
            NSString *profilePicURL=responseDic[@"graphql"][@"user"][@"profile_pic_url_hd"];
            if(userID.length>0)
            {
                [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"userID"];
                [[NSUserDefaults standardUserDefaults] setObject:profilePicURL forKey:@"profilePicURL"];
                [[NSUserDefaults standardUserDefaults] setObject:self->_usernameTxt.text forKey:@"username"];
                [self dismissViewControllerAnimated:YES completion:NULL];
            }
        }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
            [self getTemporaryID];
        }];
        [operation start];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)createAlertView:(NSString *)title message:(NSString *)message
{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
