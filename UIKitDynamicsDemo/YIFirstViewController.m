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


-(void)demoGravity;

@end

@implementation YIFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    // Setup ball view
    
    self.orangeSpaceShip = [[UIView alloc] initWithFrame:CGRectMake(100.0f, 100.0f, 135.0f, 135.0f)];
    UIImage *orangeSpaceShipImage = [UIImage imageNamed:@"orangeShip.png"];
    UIImageView *orangeSpaceShipImageView = [[UIImageView alloc] initWithImage:orangeSpaceShipImage];
    [self.orangeSpaceShip addSubview:orangeSpaceShipImageView];
    self.orangeSpaceShip.layer.borderColor = [UIColor blackColor].CGColor;
    self.orangeSpaceShip.layer.borderWidth = 0.0;
    [self.view addSubview:self.orangeSpaceShip];
    
    // Initialize the animator
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    
    [self demoGravity];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)demoGravity
{
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.orangeSpaceShip]];
    [self.animator addBehavior:gravityBehavior];
    gravityBehavior.action = ^{
        NSLog(@"%f", self.orangeSpaceShip.center.y);
    };
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.orangeSpaceShip]];
    [collisionBehavior addBoundaryWithIdentifier:@"tabbar"
                                       fromPoint:self.tabBarController.tabBar.frame.origin
                                         toPoint:CGPointMake(self.tabBarController.tabBar.frame.origin.x + self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.origin.y)];
    [self.animator addBehavior:collisionBehavior];
    
    
}

@end
