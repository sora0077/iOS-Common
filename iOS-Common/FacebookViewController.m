//
//  FacebookViewController.m
//  iOS-Common
//
//  Created by 林 達也 on 2013/12/29.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import "FacebookViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <iOS-Common/FBUser.h>

@interface FacebookViewController ()

@end

@implementation FacebookViewController
{
    __weak IBOutlet FBLoginView *_loginView;

    __weak IBOutlet UITextField *textField;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _loginView.readPermissions = @[@"email"];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    [button setTitle:@"login" forState:UIControlStateNormal];

    [button sizeToFit];
    [button updateFrame:^CGRect(CGRect frame) {
        frame.origin.y = 100;
        return frame;
    }];
    [button addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)login:(id)sender
{
    [[FBUser activeUser] login:^(FBUser *user, NSError *error) {
        NSLog(@"%@", user.userInfo);
    }];
}

- (IBAction)publishAction:(id)sender
{
    FBRequest *request = [FBRequest requestForPostStatusUpdate:textField.text];
    [[FBUser activeUser] publish:request permissions:@[@"publish_actions"] audience:FBSessionDefaultAudienceFriends completion:^(id result, NSError *error) {
        NSLog(@"%@", result);
    }];
}

@end
