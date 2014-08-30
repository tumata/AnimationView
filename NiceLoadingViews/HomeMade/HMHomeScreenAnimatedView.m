//
//  HMHomeScreenAnimatedView.m
//  NiceLoadingViews
//
//  Created by Philippe Bertin on 8/29/14.
//  Copyright (c) 2014 Yeti LLC. All rights reserved.
//

#import "HMHomeScreenAnimatedView.h"
#import "HMLogoAnimatedView.h"
#import "YETIFadeLabel.h"

@interface HMHomeScreenAnimatedView ()

@property (nonatomic, weak) IBOutlet HMLogoAnimatedView *logoView;
@property (nonatomic, weak) IBOutlet YETIFadeLabel *label;

@end


@implementation HMHomeScreenAnimatedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)startAnimation
{
    [_label setTextColor:[UIColor colorWithRed: 0.187 green: 0.190 blue: 0.194 alpha: 1]];
    _label.font = [UIFont fontWithName:@"Avenir-Black" size:20];
    [_logoView startAnimation];
    [NSTimer scheduledTimerWithTimeInterval:0.80 target:self selector:@selector(setupText:) userInfo:nil repeats:NO];
}


-(void)setupText:(id)sender
{
    [_label setText:@"Home Made"];
}

@end
