//
//  PBMainView.m
//  NiceLoadingViews
//
//  Created by Philippe Bertin on 8/26/14.
//  Copyright (c) 2014 Yeti LLC. All rights reserved.
//

#import "PBMainView.h"
#import "PBLoadingView.h"
#import "HMLogoAnimatedView.h"
#import "HMHomeScreenAnimatedView.h"
#import "YETIFadeLabel.h"

@interface PBMainView ()

@property (weak, nonatomic) IBOutlet PBLoadingView *loadView1;
@property (weak, nonatomic) IBOutlet PBLoadingView *loadView2;

@property (weak, nonatomic) IBOutlet HMLogoAnimatedView *hmView;
@property (weak, nonatomic) IBOutlet HMHomeScreenAnimatedView *homeScreenView;

@property (weak, nonatomic) IBOutlet YETIFadeLabel *fadeLabel;
@end

@implementation PBMainView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    PBLoadingView *loadView = [[PBLoadingView alloc] initWithFrame:CGRectMake(20, 20, 50, 50) numberOfShapes:4];
    [loadView startAnimation];
    [self.view addSubview:loadView];
    
    loadView = [[PBLoadingView alloc] initWithFrame:CGRectMake(100, 100, 50, 50) numberOfShapes:5];
    [loadView startAnimation];
    [self.view addSubview:loadView];
    
    loadView = [[PBLoadingView alloc] initWithFrame:CGRectMake(200, 100, 50, 50) numberOfShapes:7];
    [loadView startAnimation];
    [self.view addSubview:loadView];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startAnimatingPressed:(id)sender
{
    [_loadView1 setNumberOfShapes:6];
    [_loadView1 setAlpha:0.5];
    [_loadView1 startAnimation];
    [_loadView2 startAnimation];
    
    [_hmView startAnimation];
    [_homeScreenView startAnimation];
}

- (IBAction)stopAnimatingPressed:(id)sender
{
    [_loadView1 stopAnimation];
    [_loadView2 stopAnimation];
    [_fadeLabel setText:@""];
}


@end
