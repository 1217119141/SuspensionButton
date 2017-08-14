//
//  QSSuspensionButton.h
//  悬浮按钮
//
//  Created by 乐停 on 2017/8/14.
//  Copyright © 2017年 MrPrograming. All rights reserved.
//

#import <UIKit/UIKit.h>
#define QSSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define QSSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)

@class QSSuspensionButton;
@protocol QSSuspensionButtonDeldgate <NSObject>

@required

- (void)suspensionButtonEvent:(QSSuspensionButton *)sender;

@end


@interface QSSuspensionButton : UIView<UIGestureRecognizerDelegate>

/** QSSuspensionButtonDeldgate对象 */
@property (nonatomic, weak) id<QSSuspensionButtonDeldgate> delegate;
/** 悬浮按钮的图片 */
@property (nonatomic, strong) UIImageView *suspensionButtonImageView;
/** 是否可移动 */
@property (nonatomic, assign) BOOL isMoving;
@end
