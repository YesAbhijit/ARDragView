
//
//  ARDragView.m
//  Shenanigans
//
//  Created by ABHIJIT RANA on 12/12/15.
//  Copyright (c) 2015 Brainium. All rights reserved.
//

#import "ARDragView.h"

@implementation ARDragView

- (void)addDropTarget:(UIView*)target;
{
    // lazy initialization
    if (!self.dropTargets) {
        self.dropTargets = [NSMutableArray array];
    }
    
    // add target
    if ([target isKindOfClass:[UIView class]]) {
        [self.dropTargets addObject:target];
    }
}

#pragma mark UIResponder (touch handling)

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    [super touchesBegan:touches withEvent:event];
    [self beginDrag];
    [self dragAtPosition:[[touches anyObject] locationInView:self.superview]
                animated:YES];
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    [super touchesMoved:touches withEvent:event];
    [self dragAtPosition:[[touches anyObject] locationInView:self.superview]
                animated:NO];
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    [super touchesEnded:touches withEvent:event];
    [self endDrag];
}

- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event
{
    [super touchesCancelled:touches withEvent:event];
    [self endDrag];
}

#pragma mark dragging logic

- (void)beginDrag;
{
    NSLog(@"begin drag");
    
    self.floatingView=[[UIImageView alloc] init];
    self.floatingView.frame=CGRectMake(0, 0, self.imgView.frame.size.width*1.2, self.imgView.frame.size.height*1.2);
    self.floatingView.alpha=0.5;
    self.floatingView.backgroundColor=[UIColor blueColor];
    self.floatingView.image=self.imgView.image;
    self.floatingView.layer.cornerRadius=self.floatingView.frame.size.width/2;
    self.floatingView.clipsToBounds=YES;
    
    [self.superview.superview addSubview:self.floatingView];
    
    // don't do anything, if scrollview is actively tracking atm
    for (UIGestureRecognizer *recognizer in self.scrollView.gestureRecognizers) {
        if (recognizer.state == UIGestureRecognizerStateBegan || recognizer.state == UIGestureRecognizerStateChanged) {
            return;
        }
    }
    
    // remember state
    self.isDragging = YES;
    self.scrollView.scrollEnabled = NO;
    // inform delegate
    if ([self.delegate respondsToSelector: @selector(droppableViewBeganDragging:)]) {
        [self.delegate droppableViewBeganDragging: self];
    };
    
//    // update return position
//    if (!self.didInitalizeReturnPosition || self.shouldUpdateReturnPosition) {
//        self.returnPosition = self.center;
//        self.didInitalizeReturnPosition = YES;
//    }
    
    
}

- (void)dragAtPosition:(CGPoint)point animated:(BOOL)animated;
{
   // NSLog(@"dragging");
    
    
    CGPoint p=[self.scrollView convertPoint:point toView:self.superview.superview];
    
  //  NSLog(@"POINT: %@",NSStringFromCGPoint(p));
    
    self.floatingView.center=p;
    
  
    if (CGRectContainsPoint(self.dropTarget1.frame, p)) {
        if([self.delegate respondsToSelector: @selector(droppableViewEndedDragging:onTarget:)]) {
            [self.delegate droppableViewEndedDragging: self onTarget:self.activeDropTarget];
        }
    }
    if (CGRectContainsPoint(self.dropTarget2.frame, p)) {
        if([self.delegate respondsToSelector: @selector(droppableViewEndedDragging:onTarget:)]) {
            [self.delegate droppableViewEndedDragging: self onTarget:self.activeDropTarget];
        }
    }
}

- (void)endDrag
{
    NSLog(@"end ");
    
    
     [self.floatingView removeFromSuperview];
    
    
    if (!self.isDragging) return;
    self.scrollView.scrollEnabled = YES;
    
 
       if (CGRectContainsPoint(self.dropTarget2.frame, self.floatingView.center)) {
           if(self.dragViewState!=NONE_SELECTED && self.dragViewState==LIKE_SELECTED){
             [self.dropTargetBtn2 setBackgroundImage:self.floatingView.image forState:UIControlStateNormal];
               
               self.dropTargetBtn2.layer.borderWidth=3;
               self.dropTargetBtn2.layer.cornerRadius=self.dropTargetBtn1.frame.size.width/2;
               self.dropTargetBtn2.layer.borderColor=[[UIColor colorWithRed:253/255.0 green:201/255.0 blue:81/255.0 alpha:1] CGColor];
               
               
               self.dropTargetBtn1.layer.borderColor=[[UIColor clearColor] CGColor];
               
               
               if([self.delegate respondsToSelector: @selector(viewDroppedOnTarget:)]) {
                   [self.delegate viewDroppedOnTarget:(int)self.tag];
               }
           }
        }
    
       if (CGRectContainsPoint(self.dropTarget1.frame, self.floatingView.center)) {
            if(self.dragViewState!=NONE_SELECTED  && self.dragViewState==DISLIKE_SELECTED){
             [self.dropTargetBtn1 setBackgroundImage:self.floatingView.image forState:UIControlStateNormal];
                
                self.dropTargetBtn1.layer.borderWidth=3;
                self.dropTargetBtn1.layer.cornerRadius=self.dropTargetBtn1.frame.size.width/2;
                self.dropTargetBtn1.layer.borderColor=[[UIColor colorWithRed:6/255.0 green:198/255.0 blue:225/255.0 alpha:1] CGColor];
                
                 self.dropTargetBtn2.layer.borderColor=[[UIColor clearColor] CGColor];
                
                if([self.delegate respondsToSelector: @selector(viewDroppedOnTarget:)]) {
                    [self.delegate viewDroppedOnTarget: (int)self.tag];
                }
            }
        }
 
    // inform delegate
    if([self.delegate respondsToSelector: @selector(droppableViewEndedDragging:onTarget:)]) {
        [self.delegate droppableViewEndedDragging: self onTarget:self.activeDropTarget];
    }
}

@end
