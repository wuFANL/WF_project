//
//  ViewController2.h
//  wf
//
//  Created by wf on 2017/7/18.
//  Copyright © 2017年 wf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController2;
@protocol ViewController2delegate<NSObject>
-(void)viewcontroller1:(ViewController2 *)vc diddisapear:(NSString *)str;
@end


@interface ViewController2 : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (nonatomic,weak)id<ViewController2delegate> deleget;
@end
