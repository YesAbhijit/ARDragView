//
//  ARDragView.h
//  Shenanigans
//
//  Created by ABHIJIT RANA on 12/12/15.
//  Copyright (c) 2015 Brainium. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    LIKE_SELECTED,
    DISLIKE_SELECTED,
    NONE_SELECTED,
} LikeDislikeState;


#import <UIKit/UIKit.h>
@protocol ARDragViewDelegate;
@interface ARDragView : UIView
{
    
}
@property (nonatomic, assign) CGPoint returnPosition;
@property (nonatomic, strong) NSMutableArray *dropTargets;
@property (nonatomic, assign) BOOL isDragging;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imgView;

@property (nonatomic, weak) UIView *activeDropTarget;

@property (nonatomic) UIImageView *floatingView;

@property (nonatomic, weak) id<ARDragViewDelegate> delegate;

@property (nonatomic, weak) UIView *dropTarget1;
@property (nonatomic, weak) UIView *dropTarget2;

@property (nonatomic, weak) UIButton *dropTargetBtn1;
@property (nonatomic, weak) UIButton *dropTargetBtn2;

@property (nonatomic) LikeDislikeState dragViewState;
// target managment
- (void)addDropTarget:(UIView*)target;

@end


@protocol ARDragViewDelegate  <NSObject>
// track dragging state
- (void)droppableViewBeganDragging:(ARDragView*)view;
- (void)droppableViewDidMove:(ARDragView*)view;
- (void)droppableViewEndedDragging:(ARDragView*)view onTarget:(UIView*)target;

// track target recognition
- (void)droppableView:(ARDragView*)view enteredTarget:(UIView*)target;
- (void)droppableView:(ARDragView*)view leftTarget:(UIView*)target;
- (BOOL)shouldAnimateDroppableViewBack:(ARDragView*)view wasDroppedOnTarget:(UIView*)target;

- (void)viewDroppedOnTarget: (int) itemIndx;

@end

