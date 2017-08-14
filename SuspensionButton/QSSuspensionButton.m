//
//  QSSuspensionButton.m
//  悬浮按钮
//
//  Created by 乐停 on 2017/8/14.
//  Copyright © 2017年 MrPrograming. All rights reserved.
//

#import "QSSuspensionButton.h"
//点击后扩大的大小
#define SCALESIZE 5

typedef NS_ENUM (NSUInteger, QSLocation)
{
    QSLocationTag_top = 1,
    QSLocationTag_left,
    QSLocationTag_bottom,
    QSLocationTag_right
};

@implementation QSSuspensionButton{
    float _logoWidth;//浮标的宽度
    float _logoHeight;//浮标的高度
    
    QSLocation _location;
    float _width; //有效活动宽度
    float _height; //有效活动高度
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _logoWidth = frame.size.width;
        _logoHeight = frame.size.height;
        self.isMoving = YES;
        self.backgroundColor = [UIColor clearColor];
        self.suspensionButtonImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _logoWidth, _logoHeight)];
        //此处表示正常情况下父视图的有效范围, 其他尺寸自行更改
        _width = QSSCREEN_WIDTH;
        _height = QSSCREEN_HEIGHT-49-64;
        self.suspensionButtonImageView.layer.cornerRadius = 23.f;
        self.suspensionButtonImageView.layer.masksToBounds = YES;
        self.suspensionButtonImageView.backgroundColor = [UIColor orangeColor];
        self.suspensionButtonImageView.userInteractionEnabled = YES;
        self.suspensionButtonImageView.alpha = 0.8f;
        [self addSubview:self.suspensionButtonImageView];
        _location = QSLocationTag_right;
        _logoWidth = frame.size.width;
        _logoHeight = frame.size.height;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        tap.delegate = self;
        [self.suspensionButtonImageView addGestureRecognizer:tap];
    }
    return self;
}
- (void)tap{
    if ([self.delegate respondsToSelector:@selector(suspensionButtonEvent:)]) {
        [self.delegate suspensionButtonEvent:nil];
    }
}
#pragma mark - UIResponder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_isMoving) {
        return;
    }
    [self computeOfLocation:^
     {
     }];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_isMoving) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint move = [touch locationInView:[self superview]];
    
    if (
        move.x - self.frame.size.width/2 < 0.f
        ||
        move.x + self.frame.size.width/2 > _width
        ||
        move.y - self.frame.size.height/2 < 0.f
        ||
        move.y + self.frame.size.height/2 > _height
        )
    {
        return;
    }
    [self setCenter:move];
}
- (void)computeOfLocation:(void(^)())complete
{
    float x = self.center.x;
    float y = self.center.y;
    CGPoint m = CGPointZero;
    m.x = x;
    m.y = y;
    //取两边靠近--------------------------
    if (x < _width/2)
    {
        _location = QSLocationTag_left;
    }else
    {
        _location = QSLocationTag_right;
    }
    switch (_location)
    {
        case QSLocationTag_top:
            m.y = 0 + self.suspensionButtonImageView.frame.size.width/2;
            break;
        case QSLocationTag_left:
            m.x = 0 + self.suspensionButtonImageView.frame.size.height/2+12;
            break;
        case QSLocationTag_bottom:
            m.y = _height - self.suspensionButtonImageView.frame.size.height/2;
            break;
        case QSLocationTag_right:
            m.x = _width - self.suspensionButtonImageView.frame.size.width/2-12;
            break;
    }
    
    //这个是在旋转是微调浮标出界时
    if (m.x > _width - self.suspensionButtonImageView.frame.size.width/2)
        m.x = _width - self.suspensionButtonImageView.frame.size.width/2;
    if (m.y > _height - self.suspensionButtonImageView.frame.size.height/2)
        m.y = _height - self.suspensionButtonImageView.frame.size.height/2;
    
    [UIView animateWithDuration:0.1 animations:^
     {
         [self setCenter:m];
     } completion:^(BOOL finished)
     {
         complete();
     }];
}
@end
