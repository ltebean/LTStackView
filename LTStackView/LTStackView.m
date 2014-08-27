//
//  LTStackView.m
//  LTStackView
//
//  Created by ltebean on 14-8-26.
//  Copyright (c) 2014年 ltebean. All rights reserved.
//

#import "LTStackView.h"
#import "POP/POP.h"

@interface LTStackView()
@property (nonatomic) CGRect pullBackArea;
@property (nonatomic,strong) UIView* nextView;
@end

@implementation LTStackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void) next
{
    self.pullBackArea= CGRectMake(self.frame.size.width/4, self.frame.size.height/4, self.frame.size.width/2, self.frame.size.height/2);
    
    if(!self.nextView){
        self.nextView=[self.dataSource nextView];
    }
    [self showView:self.nextView];
    self.nextView=[self.dataSource nextView];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self];
    
    UIView *view = recognizer.view;
    view.center = CGPointMake(view.center.x + translation.x,
                                         view.center.y + translation.y);
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self];
    
    if(recognizer.state == UIGestureRecognizerStateEnded) {
        if(CGRectContainsPoint(self.pullBackArea, recognizer.view.center) || !self.nextView){
            POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
            positionAnimation.springBounciness=10;
            positionAnimation.toValue = [NSValue valueWithCGPoint:self.center];
            [recognizer.view pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
        }else{
            CGPoint velocity = [recognizer velocityInView:recognizer.view];

            POPDecayAnimation *positionAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
            positionAnimation.delegate = self;
            positionAnimation.velocity =[NSValue valueWithCGPoint:velocity];
            
            POPBasicAnimation *fadeOutAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
            fadeOutAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            fadeOutAnimation.toValue=@(0.0);
            
            [fadeOutAnimation setCompletionBlock:^(POPAnimation * anim , BOOL finished) {
                [view removeFromSuperview];
            }];

            
            [recognizer.view.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
            
            [recognizer.view pop_addAnimation:fadeOutAnimation forKey:@"fadeOutAnimation"];
            
            [self next];
        }
    }
}

-(void) showView:(UIView*) view
{
    CGRect frame=view.frame;

    view.frame=CGRectZero;
    view.center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [view addGestureRecognizer:recognizer];

    [self addSubview:view];

    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
    animation.fromValue=[NSValue valueWithCGSize:CGSizeMake(0, 0)];

    animation.toValue=[NSValue valueWithCGSize:frame.size];
    animation.springBounciness=10;
    [view.layer pop_addAnimation:animation forKey:@"zoomInAnimation"];

}

@end
