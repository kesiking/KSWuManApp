//
//  TBLoadingView.m
//  Taobao2013
//
//  Created by 香象 on 1/31/13.
//  Copyright (c) 2013 Taobao.com. All rights reserved.
//

#import "WeAppLoadingView.h"

@implementation WeAppLoadingView


- (void) spinWithOptions: (UIViewAnimationOptions) options {
    // this spin completes 360 degrees every 2 seconds
    [UIView animateWithDuration: 0.1f
                          delay: 0.0f
                        options: options
                     animations: ^{
                         self.transform = CGAffineTransformRotate(self.transform, M_PI / 2);
                     }
                     completion: ^(BOOL finished) {
                         if (finished) {
                             if (animating) {
                                 // if flag still set, keep spinning with constant speed
                                 [self spinWithOptions: UIViewAnimationOptionCurveLinear];
                             } else if (options != UIViewAnimationOptionCurveEaseOut) {
                                 // one last spin, with deceleration
                                 [self spinWithOptions: UIViewAnimationOptionCurveEaseOut];
                             }
                         }
                     }];
}

- (void) startSpin {
    if (!animating) {
        animating = YES;
        [self spinWithOptions: UIViewAnimationOptionCurveEaseIn];
    }
}

- (void) stopSpin {
    // set the flag to stop spinning after one last 90 degree increment
    animating = NO;
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

-(void)config{
    NSArray* imagesArray = [NSArray arrayWithObjects:
                            [UIImage imageNamed:@"loading_view_1.png"],
                            [UIImage imageNamed:@"loading_view_2.png"],
                            [UIImage imageNamed:@"loading_view_3.png"],
                            [UIImage imageNamed:@"loading_view_4.png"],
                            [UIImage imageNamed:@"loading_view_5.png"],
                            [UIImage imageNamed:@"loading_view_6.png"],
                            [UIImage imageNamed:@"loading_view_7.png"],
                            [UIImage imageNamed:@"loading_view_8.png"],
                            nil];
    self.animationImages = imagesArray;
    self.animationDuration = 0.5;
    self.animationRepeatCount = 0;
    
}



@end
