//
//  LTStackView.h
//  LTStackView
//
//  Created by ltebean on 14-8-26.
//  Copyright (c) 2014年 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LTStackViewDataSource <NSObject>
-(UIView*) nextView;
@end

@interface LTStackView : UIView
@property(nonatomic,weak) id<LTStackViewDataSource> dataSource;
-(void) next;
@end
