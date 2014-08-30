//
//  PBLoadingView.h
//  NiceLoadingViews
//
//  Created by Philippe Bertin on 8/26/14.
//  Copyright (c) 2014 Yeti LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PBLoadingView : UIView

// Number of shapes inside the view. Default : 3
@property (nonatomic) int numberOfShapes;

// True if View is currently animating its layers
@property (nonatomic, readonly, getter = isAnimating) BOOL animating;


// If frame is not square, drawings will be centered inside Frame.
-(id)initWithFrame:(CGRect)frame numberOfShapes:(int)number;



-(void)startAnimation;
-(void)stopAnimation;


@end
