//
//  AnimationViewController.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/11/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()


@end

@implementation AnimationViewController

- (NSMutableArray<CALayer *> *)animationLayers {

    if (!_animationLayers) {
        
        _animationLayers = [NSMutableArray array];
    }
    
    return _animationLayers;
}

- (NSMutableArray<CALayer *> *)animationBigLayers {

    if (!_animationBigLayers) {
        
        _animationBigLayers = [NSMutableArray array];
    }
    
    return _animationBigLayers;
}

/**
 *  添加商品到购物车的动画
 *
 *  @param imageView 商品的图片
 */
- (void)addProductsAnimation:(UIImageView *)imageView {

    CGRect frame = [imageView convertRect:imageView.bounds toView:self.view];
    
    CALayer *transitionLayer = [CALayer layer];
    transitionLayer.frame = frame;
    transitionLayer.contents = imageView.layer.contents;
    
    [self.view.layer addSublayer:transitionLayer];
    [self.animationLayers addObject:transitionLayer];
    
    CGPoint p1 = transitionLayer.position;
    CGPoint p3 = CGPointMake(self.view.width - self.view.width / 4 - self.view.width / 8 - 6, self.view.height - 40);
    
    CAKeyframeAnimation *positonAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, p1.x, p1.y);
    CGPathAddCurveToPoint(path, nil, p1.x, p1.y - 30, p3.x, p1.y - 30, p3.x, p3.y);
    positonAnimation.path = path;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1.0);
    opacityAnimation.toValue = @(0.9);
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = YES;
    
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1.0)];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[positonAnimation,opacityAnimation,transformAnimation];
    groupAnimation.duration = 0.8;
    groupAnimation.delegate = self;
    
    [transitionLayer addAnimation:groupAnimation forKey:@"addProducts"];
    
}
- (void)addProductsToBigShopCartAnimation:(UIImageView *)imageView {

    CGRect frame = [imageView convertRect:imageView.bounds toView:self.view];
    
    CALayer *transitionLayer = [CALayer layer];
    transitionLayer.frame = frame;
    transitionLayer.contents = imageView.layer.contents;
    
    [self.view.layer addSublayer:transitionLayer];
    [self.animationBigLayers addObject:transitionLayer];
    
    CGPoint p1 = transitionLayer.position;
    CGPoint p3 = CGPointMake(self.view.width - self.view.width / 4 - self.view.width / 8 - 6, self.view.height - 40);
    
    CAKeyframeAnimation *positonAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, p1.x, p1.y);
    CGPathAddCurveToPoint(path, nil, p1.x, p1.y - 30, p3.x, p1.y - 30, p3.x, p3.y);
    positonAnimation.path = path;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1.0);
    opacityAnimation.toValue = @(0.9);
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = YES;
    
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1.0)];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[positonAnimation,opacityAnimation,transformAnimation];
    groupAnimation.duration = 0.8;
    groupAnimation.delegate = self;
    
    [transitionLayer addAnimation:groupAnimation forKey:@"addProducts"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

    if (self.animationLayers.count > 0) {
        
        CALayer *transitionLayer = [self.animationLayers lastObject];
        transitionLayer.hidden = YES;
        [transitionLayer removeFromSuperlayer];
        [self.animationLayers removeObject:transitionLayer];
        
        [self.view.layer removeAnimationForKey:@"addProducts"];
    }
    
    if (self.animationBigLayers.count > 0) {
        
        CALayer *transitionLayer = [self.animationBigLayers lastObject];
        transitionLayer.hidden = YES;
        [transitionLayer removeFromSuperlayer];
        [self.animationLayers removeObject:transitionLayer];
        
        [self.view.layer removeAnimationForKey:@"addProducts"];
    }
}

@end
