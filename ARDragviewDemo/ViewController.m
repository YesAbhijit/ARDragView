//
//  ViewController.m
//  ARDragviewDemo
//
//  Created by AbhijitRana on 06/04/16.
//  Copyright © 2016 AbhijitRana. All rights reserved.
//

#import "ViewController.h"
#import "ARDragView.h"

@interface ViewController ()<ARDragViewDelegate>
{
     LikeDislikeState state;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    state=NONE_SELECTED;
    
    [self loadFriendsInScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)loadFriendsInScrollView
{
    
    int no_elements=12;
    
    float dropView_height=self.scrollview.frame.size.height*0.75;
    float label_height=self.scrollview.frame.size.height*0.25;
    
    for (int i=0; i<no_elements; i++) {
 
        ARDragView * dropview = [[ARDragView alloc] init];
        dropview.scrollView=self.scrollview;
        dropview.backgroundColor = [UIColor clearColor];
        dropview.layer.cornerRadius = 3.0;
        dropview.frame = CGRectMake(i*(dropView_height+5), 0, dropView_height, dropView_height);
        dropview.delegate=self;
//        dropview.dropTarget1= self.vLikeView;
//        dropview.dropTarget2= self.vDislikeView;
//        dropview.dropTargetBtn1= self.btnLike;
//        dropview.dropTargetBtn2= self.btnDislike;
        dropview.tag = i;
        
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, dropView_height, dropView_height)];
        img.layer.cornerRadius=dropView_height/2;
        img.clipsToBounds=YES;
        img.image=[UIImage imageNamed:@"man.png"];
        img.backgroundColor=[UIColor clearColor];
        [dropview addSubview:img];
        
        dropview.imgView=img;
        
        UILabel *lblName=[[UILabel alloc] initWithFrame:CGRectMake(0, dropView_height, dropView_height, label_height)];
        lblName.backgroundColor=[UIColor clearColor];
        lblName.font=[UIFont fontWithName:@"Arial" size:14];
        lblName.textColor=[UIColor colorWithWhite:0.5 alpha:1];
        lblName.textAlignment=NSTextAlignmentCenter;
        lblName.text=[NSString stringWithFormat:@"user %d",i];
 
        [dropview addSubview:lblName];
 
        [self.scrollview addSubview:dropview];
    }
    
    self.scrollview.contentSize=CGSizeMake((dropView_height+5)*no_elements, self.scrollview.frame.size.height);
    self.scrollview.userInteractionEnabled = YES;
    
    [self modifyDragViews:state];
}

- (IBAction)onDislike:(id)sender {
    
    self.btnLike.layer.borderColor=[[UIColor clearColor] CGColor];
    self.btnDislike.layer.borderColor=[[UIColor clearColor] CGColor];
    
    
    state=DISLIKE_SELECTED;
    [self modifyDragViews:state];
    [self changeLikeDislikeImage:state];
}

- (IBAction)onLike:(id)sender {
    
    self.btnLike.layer.borderColor=[[UIColor clearColor] CGColor];
    self.btnDislike.layer.borderColor=[[UIColor clearColor] CGColor];
    
    
    state=LIKE_SELECTED;
    [self modifyDragViews:state];
    [self changeLikeDislikeImage:state];
}

-(void)changeLikeDislikeImage:(LikeDislikeState)current_state
{
 
    
    
    switch (current_state) {
        case LIKE_SELECTED:
 
            [self.btnDislike setBackgroundImage:[UIImage imageNamed:@"disc.png"] forState:UIControlStateNormal];
            break;
            
        case DISLIKE_SELECTED:
            [self.btnLike setBackgroundImage:[UIImage imageNamed:@"disc.png"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

- (void)modifyDragViews:(LikeDislikeState) dragViewState
{
    
    for(UIView *v in self.scrollview.subviews){
        if([v isKindOfClass:[ARDragView class]]){
            ARDragView *ardv=(ARDragView *)v;
            ardv.dragViewState=state;
        }
    }
}

#pragma mark ARDragViewDelegate


- (void)droppableViewBeganDragging:(ARDragView*)view;
{
 
}

- (void)droppableViewEndedDragging:(ARDragView*)view onTarget:(UIView *)target
{
 
}

- (void)droppableView:(ARDragView*)view enteredTarget:(UIView*)target
{
    NSLog(@"------------------ENTERED");
    [UIView animateWithDuration:0.1 animations:^{
        target.transform = CGAffineTransformMakeScale(1.1, 1.1);
    }];
}

- (void)viewDroppedOnTarget: (int) itemIndx {
   // selectedFriendIndx=itemIndx;
}


@end
