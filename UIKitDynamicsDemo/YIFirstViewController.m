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
@property (nonatomic, strong) UIView *soccerBall;
@property (nonatomic) BOOL isBallRolling;
@property (nonatomic, strong) UIView *paddle;
@property (nonatomic) CGPoint paddleCenterPoint;


-(void)demoGravity;
-(void)playWithBall;


@end

@implementation YIFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    // Setup ball view
    
    //self.soccerBall = [[UIView alloc] initWithFrame:CGRectMake(100.0f, 100.0f, 100.0f, 100.0f)];
    self.soccerBall = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 10.0f, 100.0f, 100.0f)];
    UIImage *soccerBallImage = [UIImage imageNamed:@"soccerBall.png"];
    UIImageView *soccerBallImageView = [[UIImageView alloc] initWithImage:soccerBallImage];
    [self.soccerBall addSubview:soccerBallImageView];
    self.soccerBall.layer.cornerRadius = 50.0f;
    self.soccerBall.layer.borderColor = [UIColor blackColor].CGColor;
    self.soccerBall.layer.borderWidth = 0.0;
    [self.view addSubview:self.soccerBall];
    
    // Initialize the animator
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    
    //[self demoGravity];
    [self playWithBall];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Add gravity and collision behaviors to the animator
-(void)demoGravity
{
    // Add gravity
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.soccerBall]];
    [self.animator addBehavior:gravityBehavior];
    gravityBehavior.action = ^{
        NSLog(@"%f", self.soccerBall.center.y);
    };
    
    
    // Add collision against tabbar
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.soccerBall]];
    [collisionBehavior addBoundaryWithIdentifier:@"tabbar"
                                       fromPoint:self.tabBarController.tabBar.frame.origin
                                         toPoint:CGPointMake(self.tabBarController.tabBar.frame.origin.x + self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.origin.y)];
    [self.animator addBehavior:collisionBehavior];
    collisionBehavior.collisionDelegate = self;
    
    
    // Add dynamic behavior
    UIDynamicItemBehavior *ballBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.soccerBall]];
    ballBehavior.elasticity = 0.75;  //ellasticity of collision (bouncyness)
    ballBehavior.resistance = 0.50;
    ballBehavior.friction = 1.0;
    [self.animator addBehavior:ballBehavior];
}

-(void)playWithBall {
    UIView *obstacle1 = [[UIView alloc] initWithFrame:CGRectMake(0, 120, 120, 20)];
    obstacle1.backgroundColor = [UIColor greenColor];
    UIView *obstacle2 = [[UIView alloc] initWithFrame:CGRectMake(170, 300, 150, 20)];
    obstacle2.backgroundColor = [UIColor greenColor];
    UIView *obstacle3 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 75,
                                                                 450.0,
                                                                 150.0,
                                                                 20.0)];
    obstacle3.backgroundColor = [UIColor blackColor];
    [self.view addSubview:obstacle1];
    [self.view addSubview:obstacle2];
    [self.view addSubview:obstacle3];
    
    
    self.paddle = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 75,
                                                           self.tabBarController.tabBar.frame.origin.y - 35.0,
                                                           150.0,
                                                           30.0)];
    self.paddle.backgroundColor = [UIColor redColor];
    self.paddle.layer.cornerRadius = 15.0;
    self.paddleCenterPoint = self.paddle.center;
    [self.view addSubview:self.paddle];
    
    
    
    // Add gravity behavior to the ball
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.soccerBall]];
    [self.animator addBehavior:gravityBehavior];
    
    // Add collision behavior
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.soccerBall, self.paddle,obstacle1, obstacle2, obstacle3]];
    // Main view’s bounds work as boundaries for the items that will collide.
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [collisionBehavior addBoundaryWithIdentifier:@"tabbar"
                                       fromPoint:self.tabBarController.tabBar.frame.origin
                                         toPoint:CGPointMake(self.tabBarController.tabBar.frame.origin.x + self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.origin.y)];
    // All edges of items that participate to a collision will have the desired behavior.
    collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    collisionBehavior.collisionDelegate = self;
    [self.animator addBehavior:collisionBehavior];
    
    
    // Add dynamic item behavior
    UIDynamicItemBehavior *ballBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.soccerBall]];
    ballBehavior.elasticity = 0.9;
    ballBehavior.resistance = 0.0;
    ballBehavior.friction = 0.0;
    ballBehavior.allowsRotation = NO;
    [self.animator addBehavior:ballBehavior];
    
    // Make the obstacles 1 and 2 super heavy
    UIDynamicItemBehavior *obstacles1And2Behavior = [[UIDynamicItemBehavior alloc] initWithItems:@[obstacle1, obstacle2]];
    obstacles1And2Behavior.allowsRotation = NO;
    obstacles1And2Behavior.density = 100000.0;
    [self.animator addBehavior:obstacles1And2Behavior];
    
    // 3rd obstacle
    UIDynamicItemBehavior *obstacle3Behavior = [[UIDynamicItemBehavior alloc] initWithItems:@[obstacle3]];
    obstacle3Behavior.allowsRotation = YES;
    [self.animator addBehavior:obstacle3Behavior];
    
    // Paddle
    UIDynamicItemBehavior *paddleBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.paddle]];
    paddleBehavior.allowsRotation = NO;
    paddleBehavior.density = 100000.0;
    [self.animator addBehavior:paddleBehavior];
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
     if (!self.isBallRolling) {
         UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.soccerBall] mode:UIPushBehaviorModeInstantaneous];
         pushBehavior.magnitude = 1.5;
         [self.animator addBehavior:pushBehavior];
         self.isBallRolling = YES;
     }
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    CGFloat yPoint = self.paddleCenterPoint.y;
    CGPoint paddleCenter = CGPointMake(touchLocation.x, yPoint);
    
    self.paddle.center = paddleCenter;
    [self.animator updateItemUsingCurrentState:self.paddle];
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id)item1 withItem:(id)item2 atPoint:(CGPoint)p{
    
    if (item1 == self.soccerBall && item2 == self.paddle) {
        UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.soccerBall] mode:UIPushBehaviorModeInstantaneous];
        pushBehavior.angle = 0.0;
        pushBehavior.magnitude = 0.75;
        [self.animator addBehavior:pushBehavior];
    }
}

#pragma mark CollisionDelegate
-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id)item withBoundaryIdentifier:(id)identifier atPoint:(CGPoint)p {
    self.soccerBall.backgroundColor = [UIColor grayColor];
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id)item withBoundaryIdentifier:(id)identifier{
    self.soccerBall.backgroundColor = [UIColor clearColor];
}




@end
