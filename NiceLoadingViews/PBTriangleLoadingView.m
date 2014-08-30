//
//  PBTriangleLoadingView.m
//  NiceLoadingViews
//
//  Created by Philippe Bertin on 8/29/14.
//  Copyright (c) 2014 Yeti LLC. All rights reserved.
//


#import "PBTriangleLoadingView.h"

@interface PBTriangleLoadingView (){
    
    int     _numberOfShapes;
    CGFloat _lineWidth;
    
    // Three angles defining triangle. Counter-Clockwise.
    CGFloat _angle1;
    CGFloat _angle2;
    CGFloat _angle3;
    
    // % space between each shape
    CGFloat _relativeGapBetweenShapes;
    
    // From outside to inside
    NSArray *_layers;
}



@end

@implementation PBTriangleLoadingView

// Replace layers by shapeLayers
+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialSetup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialSetup];
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setupLayers];
    [self setupAnimations];
    
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
}


-(void)startAnimation
{
    
}

-(void)stopAnimation
{
    
}


-(void)initialSetup
{
    _angle1 = 0.0;
    _angle2 = 120.0*M_PI/90;
    _angle3 = -120.0*M_PI/90;
    _numberOfShapes = 4;
    _lineWidth = 1;
    _relativeGapBetweenShapes = 20;
}


#pragma mark - Shape Logic

-(void)setupLayers
{
    
    CGRect frame = CGRectInset(self.layer.bounds, _lineWidth, _lineWidth);
    CGPoint center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    CGFloat maxRadius = frame.size.height/2;
    
    CGVector vec1 = CGVectorMake(cosf(_angle1), sinf(_angle1));
    CGVector vec2 = CGVectorMake(cosf(_angle2), sinf(_angle2));
    CGVector vec3 = CGVectorMake(cosf(_angle3), sinf(_angle3));
    
    
    NSMutableArray *bezierPaths = [[NSMutableArray alloc] init];
    
    for (int i=0; i<_numberOfShapes; i++)
    {
        CGFloat radius = maxRadius - i*(_relativeGapBetweenShapes*maxRadius/100);
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        CGPoint point1 = CGPointMake(center.x + vec1.dx*radius, center.y + vec1.dy*radius);
        CGPoint point2 = CGPointMake(center.x + vec2.dx*radius, center.y + vec2.dy*radius);
        CGPoint point3 = CGPointMake(center.x + vec3.dx*radius, center.y + vec3.dy*radius);
        
        
        [path moveToPoint: point1];
        [path addLineToPoint: point2];
        [path addLineToPoint: point3];
        [path addLineToPoint: point1];
        [path addLineToPoint: point2];
        [path addLineToPoint: point3];
        [path closePath];
        
        [bezierPaths addObject:path];
        
        
        //
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        
        
        CGPathRef outPath = path.CGPath;
        [layer setPath:outPath];
        [layer setStrokeColor:[UIColor blueColor].CGColor];
        [layer setLineWidth:_lineWidth];
        [layer setFillColor:nil];
        [layer setStrokeStart:0.0f];
        [layer setStrokeEnd:1.0f];
        
        [self.layer addSublayer:layer];
    }
    
}

-(void)setupAnimations
{
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CAShapeLayer *obj, NSUInteger idx, BOOL *stop) {
        
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




@end
