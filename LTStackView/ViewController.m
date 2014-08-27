//
//  ViewController.m
//  LTStackView
//
//  Created by ltebean on 14-8-26.
//  Copyright (c) 2014年 ltebean. All rights reserved.
//

#import "ViewController.h"
#import "LTStackView.h"
@interface ViewController ()<LTStackViewDataSource>
@property (weak, nonatomic) IBOutlet LTStackView *stackView;
@property int counter;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.stackView.dataSource=self;
    self.counter=0;
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(UIView*) nextView
{
    if(self.counter++==20){
        return nil;
    }
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    view.backgroundColor= [UIColor colorWithRed:((10 * self.counter) / 255.0) green:((20 * self.counter)/255.0) blue:((30 * self.counter)/255.0) alpha:1.0f];

    UIView* overlay=[[UIView alloc]initWithFrame:CGRectMake(20 , 20, 50, 50)];
    overlay.backgroundColor=[UIColor whiteColor];
    
    [view addSubview:overlay];
    return view;
}


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.stackView next];
}

@end
