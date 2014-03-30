UIKidDynamicsDemo
=================

A demo that demonstrates how the new Dynamics library works in UIKIT for iOS7 from a great tutorial at AppCoda.com

The new Dynamics library makes it very easy to create physics mased interaction between UIViews. Conveniently, most UI controls such as UILabels and UIButtons are sublasses of UIViews. 

The way everything ties together is very simple:
Create an UIDynamicAnimator, add behaviors to the animator. There are several types of behvaiors:

* UIGravityBehavior
* UICollisionBehavior
* UIPushBehavior
* UIAttachmentBehavior
* UISnapBehavior

This demo shows how to animate these behaviors through the UIDynamicAnimator class.
![ScreenShot](https://raw.githubusercontent.com/LunarFlash/UIKitDynamicsDemo/master/UIKitDynamicsDemo/ball.gif)
![ScreenShot](https://raw.githubusercontent.com/LunarFlash/UIKitDynamicsDemo/master/UIKitDynamicsDemo/menuGravity.gif)





Graphics can be found here: http://opengameart.org/content/space-ship-construction-kit
Tutorial can be found here: http://www.appcoda.com/intro-uikit-dynamics-tutorial/
