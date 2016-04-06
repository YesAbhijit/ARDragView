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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
   // [self modifyDragViews:state];
}


- (void)droppableViewEndedDragging:(ARDragView*)view onTarget:(UIView *)target
{
    [UIView animateWithDuration:0.33 animations:^{
        if (!target) {
            // view.backgroundColor = [UIColor whiteColor];
        } else {
            //  view.backgroundColor = [UIColor darkGrayColor];
        }
        view.alpha = 1.0;
    }];
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
