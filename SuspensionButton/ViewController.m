//
//  ViewController.m
//  SuspensionButton
//
//  Created by 乐停 on 2017/8/14.
//  Copyright © 2017年 MrPrograming. All rights reserved.
//

#import "ViewController.h"
#import "QSSuspensionButton.h"

@interface ViewController ()<QSSuspensionButtonDeldgate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    QSSuspensionButton * suspensionBtn = [[QSSuspensionButton alloc]initWithFrame:CGRectMake(QSSCREEN_WIDTH-60, QSSCREEN_HEIGHT-176, 46, 46)];
    suspensionBtn.delegate = self;
    suspensionBtn.suspensionButtonImageView.image = [UIImage imageNamed:@"publishAdd"];
    [self.view addSubview:suspensionBtn];
    [self.view bringSubviewToFront:suspensionBtn];
}
- (void)suspensionButtonEvent:(QSSuspensionButton *)sender{
    NSLog(@"111");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
