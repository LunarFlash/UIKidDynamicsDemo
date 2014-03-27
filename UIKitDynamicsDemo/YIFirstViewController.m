//
//  YIFirstViewController.m
//  UIKitDynamicsDemo
//
//  Created by Terry Wang on 3/27/14.
//  Copyright (c) 2014 ASHP. All rights reserved.
//

#import "YIFirstViewController.h"
@import QuartzCore;

@interface YIFirstViewController ()

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIView *orangeSpaceShip;

@end

@implementation YIFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    // Setup ball view
    
    self.orangeSpaceShip = [[UIView alloc] initWithFrame:CGRectMake(100.0f, 100.0f, 50.0f, 50.0f)];
    UIImage *orangeSpaceShipImage = [UIImage imageNamed:@"orangeShip.png"];
    self.orangeSpaceShip.backgroundColor = [UIColor colorWithPatternImage:orangeSpaceShipImage];
    self.orangeSpaceShip.layer.borderColor = [UIColor blackColor].CGColor;
    self.orangeSpaceShip.layer.borderWidth = 0.0;
    [self.view addSubview:self.orangeSpaceShip];
    
    // Initialize the animator
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
    
    
}

@end
