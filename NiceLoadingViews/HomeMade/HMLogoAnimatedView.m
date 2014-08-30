//
//  HMLogoAnimatedView.m
//  NiceLoadingViews
//
//  Created by Philippe Bertin on 8/27/14.
//  Copyright (c) 2014 Yeti LLC. All rights reserved.
//

// Line Width for a 60pix width
#define LINE_WIDTH 7.5

#define ANIMATION_DURATION 1.5f

#import "HMLogoAnimatedView.h"

@interface HMLogoAnimatedView ()
{
    UIColor *_colorHomeMade;
    
    // This order is used for sub-layers :
    // 1. line
    // 2. leftArrow
    // 3. rightArrow
    UIBezierPath *_linePath;
    UIBezierPath *_arrowLeftPath;
    UIBezierPath *_arrowRightPath;
    
    CAShapeLayer *_lineLayer;
    CAShapeLayer *_arrowLeftLayer;
    CAShapeLayer *_arrowRightLayer;
}

@end

@implementation HMLogoAnimatedView

// Replace layers by shapeLayers
+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeThingsHappen];
    }
    return self;
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    [self makeThingsHappen];
}


/*!
 * 1. Layers
 * 2. Bezier paths
 * 3. CGPathRef link bezier to layers
 *
 */
-(void)makeThingsHappen
{
    [self initializeLayers];
    [self initializeBezierPaths];
    [self initializeBezierPathsWithSubLayers];
    
}

-(void)startAnimation
{
    [self initializeAnimations];
}

#pragma mark - Initializations

#pragma mark Layers

/*!
 * Initialize the main layer's sub-layers
 *
 */
-(void)initializeLayers
{
    // Initialize the three sub-layers
    _lineLayer = [[CAShapeLayer alloc] init];
    _arrowLeftLayer = [[CAShapeLayer alloc] init];
    _arrowRightLayer = [[CAShapeLayer alloc] init];
    
    // Make them sun-layers of main Layer
    [self.layer addSublayer:_lineLayer];
    [self.layer addSublayer:_arrowLeftLayer];
    [self.layer addSublayer:_arrowRightLayer];
}

#pragma mark - Bezier Paths

/*!
 * Initialize the bezier paths for the line, and both arrow-side.
 *
 */
-(void)initializeBezierPaths
{
    CGRect frame = self.layer.bounds;
    
    
    //------------------------------------------
    // Line path
    UIBezierPath* linePath = UIBezierPath.bezierPath;
    [linePath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50148 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51242 * CGRectGetHeight(frame))];
    [linePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50220 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65635 * CGRectGetHeight(frame))];
    [linePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50293 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.80067 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59581 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91864 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.50293 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.80067 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.48938 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91864 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.70017 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91864 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.63276 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91864 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.66882 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91864 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.80142 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91864 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.75914 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91864 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.80142 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91864 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.88923 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87052 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.80142 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91864 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.85317 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.90993 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.92333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77759 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.90852 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84945 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.92333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81959 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.92333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63075 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.92333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73343 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.92333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68032 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.92333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46985 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.92333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54501 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.92333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46985 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.86334 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34162 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.92333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46985 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.92623 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39291 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.75789 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25482 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.85687 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33633 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.80779 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29592 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.66065 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17471 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.73844 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23881 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.69925 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20651 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.55760 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.08979 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.60858 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.13180 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.55760 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.08979 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.43617 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09594 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.55760 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.08979 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.50099 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04927 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.34811 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16729 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.42222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10603 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.38825 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.13389 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.24816 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25087 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.31636 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19371 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.28075 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22359 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.14445 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33598 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.19858 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29237 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.15597 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32784 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.07673 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47036 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.06366 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39291 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.07673 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47036 * CGRectGetHeight(frame))];
    [linePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.07673 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63325 * CGRectGetHeight(frame))];
    [linePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.07673 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77964 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.10593 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.88083 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.07673 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77964 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.07168 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.83981 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.19670 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91812 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.12364 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.90204 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.15185 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91812 * CGRectGetHeight(frame))];
    [linePath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.27749 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91812 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.24895 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91812 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.27749 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91812 * CGRectGetHeight(frame))];

    _linePath = [linePath bezierPathByReversingPath];
    
    
    //------------------------------------------
    // Arrow left path
    _arrowLeftPath = UIBezierPath.bezierPath;
    [_arrowLeftPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49735 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41789 * CGRectGetHeight(frame))];
    [_arrowLeftPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.31352 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57433 * CGRectGetHeight(frame))];
    
    
    //------------------------------------------
    // Arrow right path
    _arrowRightPath = UIBezierPath.bezierPath;
    [_arrowRightPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49735 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41789 * CGRectGetHeight(frame))];
    [_arrowRightPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.68602 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57433 * CGRectGetHeight(frame))];
   
    
}

#pragma mark Link Paths with Layers

/*!
 * Link the beziers paths with sub-layers
 *
 */
-(void)initializeBezierPathsWithSubLayers
{
    // Line width is a multiple of the frame width (defined by LINE_WIDTH at a width of 60).
    CGFloat lineWidth = (self.layer.bounds.size.width * LINE_WIDTH)/60;
    
    // Official Color
    _colorHomeMade = [UIColor colorWithRed: 0.198 green: 0.923 blue: 0.682 alpha: 1];

    
    // For the line
    CAShapeLayer *layer = _lineLayer;
    CGPathRef linePath = _linePath.CGPath;
    
    [layer setPath:linePath];
    [layer setStrokeColor:_colorHomeMade.CGColor];
    [layer setLineWidth:lineWidth];
    [layer setMiterLimit:1];
    [layer setLineCap:kCALineCapRound];
    [layer setLineJoin:kCALineJoinRound];
    [layer setFillColor:nil];
    [layer setStrokeStart:0.0f];
    [layer setStrokeEnd:1.0f];
    CGPathRelease(linePath);
    
    // For the left arrow
    CAShapeLayer *layerLeftArrow = _arrowLeftLayer;
    CGPathRef leftArrowPath = _arrowLeftPath.CGPath;
    
    [layerLeftArrow setPath:leftArrowPath];
    [layerLeftArrow setStrokeColor:_colorHomeMade.CGColor];
    [layerLeftArrow setLineWidth:lineWidth];
    [layerLeftArrow setMiterLimit:1];
    [layerLeftArrow setLineCap:kCALineCapRound];
    [layerLeftArrow setLineJoin:kCALineJoinRound];
    [layerLeftArrow setFillColor:nil];
    [layerLeftArrow setStrokeStart:0.0f];
    [layerLeftArrow setStrokeEnd:1.0f];
    CGPathRelease(leftArrowPath);
    
    // For the right arrow
    CAShapeLayer *layerRightArrow = _arrowRightLayer;
    CGPathRef rightArrowPath = _arrowRightPath.CGPath;
    
    [layerRightArrow setPath:rightArrowPath];
    [layerRightArrow setStrokeColor:_colorHomeMade.CGColor];
    [layerRightArrow setLineWidth:lineWidth];
    [layerRightArrow setMiterLimit:1];
    [layerRightArrow setLineCap:kCALineCapRound];
    [layerRightArrow setLineJoin:kCALineJoinRound];
    [layerRightArrow setFillColor:nil];
    [layerRightArrow setStrokeStart:0.0f];
    [layerRightArrow setStrokeEnd:1.0f];
    CGPathRelease(rightArrowPath);

}

#pragma mark  Animations

/*!
 * Starts the Animations
 *
 */
-(void)initializeAnimations
{
    /*
    [CATransaction begin];
    {
        [self addAnimations];
        
        [CATransaction setCompletionBlock:^{
            ;
        }];
        
        
    }
    [CATransaction commit];
    //*/
        
    [self addAnimations];
}


/*!
 * Setup the Animations
 *
 */
-(void)addAnimations
{
    //*
    // Timing
    CGFloat lineStartValue = -0.307692f;
    CGFloat lineEndValue = 2.0f;
    CGFloat arrowStartValue = -16.5f;
    CGFloat arrowEndValue = 12.5f;
    CGFloat opacityStart = 0.0f;
    CGFloat opacityEnd = 1.0f;
    

    
    // Line Animation
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = ANIMATION_DURATION;
    pathAnimation.fromValue = [NSNumber numberWithFloat:lineStartValue];
    pathAnimation.toValue = [NSNumber numberWithFloat:lineEndValue];
    pathAnimation.repeatCount = 0;
    pathAnimation.autoreverses = NO;
    [_lineLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    // Line Animation
    CABasicAnimation *leftArrowAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    leftArrowAnimation.duration = ANIMATION_DURATION;
    leftArrowAnimation.fromValue = [NSNumber numberWithFloat:arrowStartValue];
    leftArrowAnimation.toValue = [NSNumber numberWithFloat:arrowEndValue];
    leftArrowAnimation.repeatCount = 0;
    leftArrowAnimation.autoreverses = NO;
    [_arrowLeftLayer addAnimation:leftArrowAnimation forKey:@"strokeEnd"];
    
    // Line Animation
    CABasicAnimation *rightArrowAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    rightArrowAnimation.duration = ANIMATION_DURATION;
    rightArrowAnimation.fromValue = [NSNumber numberWithFloat:arrowStartValue];
    rightArrowAnimation.toValue = [NSNumber numberWithFloat:arrowEndValue];
    rightArrowAnimation.repeatCount = 0;
    rightArrowAnimation.autoreverses = NO;
    [_arrowRightLayer addAnimation:rightArrowAnimation forKey:@"strokeEnd"];
    
    
    //*
    //Opacity Animation at the end of Layers Animation
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = ANIMATION_DURATION/2;
    opacityAnimation.fromValue = [NSNumber numberWithFloat:opacityStart];
    opacityAnimation.toValue = [NSNumber numberWithFloat:opacityEnd];
    opacityAnimation.repeatCount = 0;
    opacityAnimation.autoreverses = NO;
    [self.layer addAnimation:opacityAnimation forKey:@"opacity"];
    //*/
    

}


@end
