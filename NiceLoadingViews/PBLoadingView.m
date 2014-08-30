//
//  PBLoadingView.m
//  NiceLoadingViews
//
//  Created by Philippe Bertin on 8/26/14.
//  Copyright (c) 2014 Yeti LLC. All rights reserved.
//

#import "PBLoadingView.h"

// The bigger the closer
#define SPACE_BETWEEN_LAYERS 12

// Percentage of the lenght of the shape that should be displayed at once
#define LENGTH_PER_CENT 90

// LineWidth
#define LINE_WIDTH 0.7f

@interface PBLoadingView (){
    NSMutableArray *_layers;
    NSMutableArray *_bezierPaths;
    
    CGRect  _outsideLayerBouds;
    CGPoint _layerPosition;
}

@property (nonatomic, getter = isAnimating) BOOL animating;

@end

@implementation PBLoadingView

// Replace layers by shapeLayers
+ (Class)layerClass {
    return [CAShapeLayer class];
}


#pragma mark - Inits methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfShapes = 3;
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame numberOfShapes:(int)number
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self initialFrameSetup];
        _numberOfShapes = number;
    }
    return self;
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    _numberOfShapes = 3;
}



#pragma mark - Animation get/set


-(void)startAnimation
{
    if (_animating)
        return;
    
    // Initialize the frames
    [self initialFrameSetup];
    
    // Setup the layers
    [self setupLayers];
    
    // Setup the animations
    [self setupAnimations];
}

-(void)stopAnimation
{
    if (!_animating)
        return;
    
    // Remove animations
    [self setupStopAnimations];
    
    // Remove all Layers
    [self setupRemoveLayers];
}

#pragma mark - Getters / Setters

-(void)setNumberOfShapes:(int)numberOfShapes
{
    NSAssert(numberOfShapes>0, @"%s : numberOfShapes must be positive", __func__);
    
    _numberOfShapes = numberOfShapes;
    
    if (_animating)
    {
        [self stopAnimation];
        [self startAnimation];
    }
}

-(void)setAlpha:(CGFloat)alpha
{
    
}

#pragma mark - Setups

#pragma mark Frames

-(void)initialFrameSetup
{
    // Making a square inside the rectangle bounds
    CGRect superLayerBounds = self.layer.bounds;
    CGSize superLayerSize = superLayerBounds.size;
    
    // Wanted bounds of outside Layer
    CGFloat size = MIN(superLayerSize.height, superLayerSize.width) - 2*ceilf(LINE_WIDTH);
    _outsideLayerBouds = CGRectMake(0, 0, size, size);
    
    // Position of the future layers
    CGFloat layerPositionX = (superLayerSize.width - size)/2;
    CGFloat layerPositionY = (superLayerSize.height - size)/2;
    _layerPosition = CGPointMake(layerPositionX, layerPositionY);
}

-(void)setupLayers
{
    _layers = [[NSMutableArray alloc] initWithCapacity:_numberOfShapes];
    _bezierPaths = [[NSMutableArray alloc] initWithCapacity:_numberOfShapes];
    
    for (int i=0; i<_numberOfShapes; i++)
    {
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        [_layers addObject:layer];
        
        [_bezierPaths addObject:[UIBezierPath bezierPath]];
    }
    
    
    // Add all layers from array as subLayers of View
    for (CAShapeLayer *layer in _layers){
        [self.layer addSublayer:layer];
    }

    // Set up the BezierPath for each layer
    [self setupBezierPathsAndLayers];

}

-(void)setupRemoveLayers
{
    self.layer.sublayers = nil;
    _layers = nil;
    _bezierPaths = nil;
}

-(void)setupBezierPathsAndLayers
{
    CGRect squareFrame = _outsideLayerBouds;
    
    // Space between each Layer
    CGFloat decreasePercentage = squareFrame.size.width/SPACE_BETWEEN_LAYERS;
    
    // Center for the Shape
    CGPoint center = CGPointMake(_outsideLayerBouds.size.height/2, _outsideLayerBouds.size.width/2);
    
    
    CGFloat inverseCount =2.0/_layers.count;
    
    for (int i=0; i<_bezierPaths.count; i++){
        
        CGFloat startAngle = - M_PI_2 + inverseCount*M_PI*i;
        CGFloat endAngle = (M_PI + M_PI_2 + inverseCount*M_PI*i)+2*M_PI;
        
        _bezierPaths[i] = [UIBezierPath bezierPathWithArcCenter:center
                                                         radius:center.x - i*decreasePercentage
                                                     startAngle:(i%2)?startAngle:endAngle
                                                       endAngle:(i%2)?endAngle:startAngle
                                                      clockwise:(i%2)?1:0];
        squareFrame = CGRectInset(squareFrame, decreasePercentage, decreasePercentage);
    }
    
    
    // Set Layers for each bezierPath
    for (int i=0; i<_layers.count; i++)
    {
        UIBezierPath *bezierPath = _bezierPaths[i];
        CAShapeLayer *layer = _layers[i];
        
        CGPathRef outPath = bezierPath.CGPath;
        [layer setPath:outPath];
        [layer setStrokeColor:[UIColor blueColor].CGColor];
        [layer setLineWidth:LINE_WIDTH];
        [layer setFillColor:nil];
        [layer setStrokeStart:0.0f];
        [layer setStrokeEnd:1.0f];
        //CGPathRelease(outPath);
        
        layer.position = _layerPosition;
    }
    
    //Set Background Layer
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CGPathRef circle = CGPathCreateWithEllipseInRect(_outsideLayerBouds, NULL);
    [layer setPath:circle];
    [layer setStrokeColor:[UIColor whiteColor].CGColor];
    [layer setFillColor:[UIColor whiteColor].CGColor];
    CGPathRelease(circle);
    layer.zPosition = -1;
    layer.position = _layerPosition;
    
    [self.layer addSublayer:layer];
    

}

#pragma mark Animations

-(void)setupAnimations
{
    _animating = true;
    
    if (!_layers)
        return;
    
    [_layers enumerateObjectsUsingBlock:^(CAShapeLayer *obj, NSUInteger idx, BOOL *stop) {
        
        CGFloat duration = 2.0f + ((idx>0)?(1.0f/idx):0);
        
        //Stroke start
        CABasicAnimation * path2Animation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        path2Animation.duration = duration;
        path2Animation.fromValue = [NSNumber numberWithFloat:0.0f];
        path2Animation.toValue = [NSNumber numberWithFloat:0.5f];
        path2Animation.repeatCount = HUGE_VALF;
        path2Animation.autoreverses = NO;
        [obj addAnimation:path2Animation forKey:@"strokeStart"];
    
        //Stroke End
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = duration;
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.45f];
        pathAnimation.toValue = [NSNumber numberWithFloat:0.95f];
        pathAnimation.repeatCount = HUGE_VALF;
        pathAnimation.autoreverses = NO;
        [obj addAnimation:pathAnimation forKey:@"strokeEnd"];
    }];
    
}

-(void)setupStopAnimations
{
    _animating = false;
    
    if (!_layers)
        return;
    
    [_layers enumerateObjectsUsingBlock:^(CAShapeLayer *obj, NSUInteger idx, BOOL *stop) {
        [obj removeAllAnimations];
    }];
    
    
}




@end
