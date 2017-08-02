////
////  TutorialShapeLayer.m
////  RMExtensionKeyboard
////
////  Created by Radhouani Malek on 21/04/2017.
////  Copyright © 2017 RedMak. All rights reserved.
////
//
//#import "TutorialShapeLayer.h"
//// http://jslim.net/blog/2014/06/13/uiview-fill-with-color-and-leave-a-empty-square-in-center/
//
//#define RM_TutorialAlreadyChown @"RM_TutorialAlreadyChown"
//
//@implementation TutorialShapeLayer
//
//- (id) initWithFrame:(CGRect)frame emptyZoneRect:(CGRect)emptyRect addCorner:(BOOL) addCorner{
//    if (self = [super init]) {
//        
//        UIBezierPath *overlayPath = [UIBezierPath bezierPathWithRect:frame];
//        
//        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
//        CGPoint center = CGPointMake(emptyRect.origin.x + emptyRect.size.width/2, emptyRect.origin.y);
//        [bezierPath addArcWithCenter:center radius:emptyRect.size.width startAngle:0 endAngle:2 * M_PI clockwise:YES];
//
//        [overlayPath appendPath:bezierPath];
//        [overlayPath setUsesEvenOddFillRule:YES];
//        
//        self.path = overlayPath.CGPath;
//        self.fillRule = kCAFillRuleEvenOdd;
//        
//        if (addCorner) {
//            UIBezierPath *maskPath = [UIBezierPath
//                                      bezierPathWithRoundedRect:frame
//                                      byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerTopLeft)
//                                      cornerRadii:CGSizeMake(40, 40)
//                                      ];
//            
//            CAShapeLayer *maskLayer = [CAShapeLayer layer];
//            
//            maskLayer.frame = self.bounds;
//            maskLayer.path = maskPath.CGPath;
//            
//            self.mask = maskLayer;
//        }
//    }
//    return self;
//}
//
//+ (BOOL) tutorialNeeded{
//    BOOL needed = [[NSUserDefaults standardUserDefaults] boolForKey:RM_TutorialAlreadyChown];
//    return !needed;
//}
//
//+ (void) tutorialDone{
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:RM_TutorialAlreadyChown];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//@end
