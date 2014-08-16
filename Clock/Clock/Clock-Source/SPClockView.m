//
//  SPClockView.m
//  Clock
//
//  Created by Suraj on 16/8/14.
//  Copyright (c) 2014 Su Media. All rights reserved.
//

#import "SPClockView.h"

#define borderWidth         2
#define borderAlpha         1.0
#define graduationOffset    10
#define graduationLength    5.0
#define graduationWidth     1.0
#define graduationColor     [UIColor blackColor]
#define digitFont           [UIFont systemFontOfSize:14.0]
#define digitOffset         0

@interface SPClockView()
@property (nonatomic, strong) UIColor *clockBackgroundColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIColor *digitColor;

@end

@implementation SPClockView

- (void)initOutlook{
    self.backgroundColor = [UIColor clearColor];
    _clockBackgroundColor = [UIColor blackColor];
    _borderColor = [UIColor whiteColor];
    _digitColor = [UIColor whiteColor];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initOutlook];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // CLOCK'S FACE
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColorWithColor(ctx, self.clockBackgroundColor.CGColor);
    CGContextSetAlpha(ctx, borderAlpha);
    CGContextFillPath(ctx);
    
    // CLOCK'S BORDER
    CGContextAddEllipseInRect(ctx, CGRectMake(rect.origin.x + borderWidth/2, rect.origin.y + borderWidth/2, rect.size.width - borderWidth, rect.size.height - borderWidth));
    CGContextSetStrokeColorWithColor(ctx, self.borderColor.CGColor);
    CGContextSetAlpha(ctx, borderAlpha);
    CGContextSetLineWidth(ctx,borderWidth);
    CGContextStrokePath(ctx);
    
    // CLOCK'S GRADUATION
        for (int i = 0; i<60; i++) {
            CGPoint P1 = CGPointMake((self.frame.size.width/2 + ((self.frame.size.width - borderWidth*2 - graduationOffset) / 2) * cos((6*i)*(M_PI/180)  - (M_PI/2))), (self.frame.size.width/2 + ((self.frame.size.width - borderWidth*2 - graduationOffset) / 2) * sin((6*i)*(M_PI/180)  - (M_PI/2))));
            CGPoint P2 = CGPointMake((self.frame.size.width/2 + ((self.frame.size.width - borderWidth*2 - graduationOffset - graduationLength) / 2) * cos((6*i)*(M_PI/180)  - (M_PI/2))), (self.frame.size.width/2 + ((self.frame.size.width - borderWidth*2 - graduationOffset - graduationLength) / 2) * sin((6*i)*(M_PI/180)  - (M_PI/2))));
            
            CAShapeLayer  *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path1 = [UIBezierPath bezierPath];
            shapeLayer.path = path1.CGPath;
            [path1 setLineWidth:graduationWidth];
            [path1 moveToPoint:P1];
            [path1 addLineToPoint:P2];
            path1.lineCapStyle = kCGLineCapSquare;
            [graduationColor set];
            
            [path1 strokeWithBlendMode:kCGBlendModeNormal alpha:borderAlpha];
        }
    
    // DIGIT DRAWING
    
        CGPoint center = CGPointMake(rect.size.width/2.0f, rect.size.height/2.0f);
        CGFloat markingDistanceFromCenter = rect.size.width/2.0f - digitFont.lineHeight/4.0f - 15 + digitOffset;
        NSInteger offset = 4;
        
        for(unsigned i = 0; i < 12; i ++){
            NSString *hourNumber = [NSString stringWithFormat:@"%@%d", [NSString stringWithFormat:@"%@", i+1<10 ? @" ": @""] , i + 1 ];
            CGFloat labelX = center.x + (markingDistanceFromCenter - digitFont.lineHeight/2.0f) * cos((M_PI/180)* (i+offset) * 30 + M_PI);
            CGFloat labelY = center.y + - 1 * (markingDistanceFromCenter - digitFont.lineHeight/2.0f) * sin((M_PI/180)*(i+offset) * 30);
            [hourNumber drawInRect:CGRectMake(labelX - digitFont.lineHeight/2.0f,labelY - digitFont.lineHeight/2.0f,digitFont.lineHeight,digitFont.lineHeight) withAttributes:@{NSForegroundColorAttributeName: self.digitColor, NSFontAttributeName: digitFont}];
        }
}

@end
