//
//  ViewController_Detail.m
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2019/1/2.
//  Copyright © 2019 Yi Hwei Huang. All rights reserved.
//

#import "ViewController_Detail.h"
#import "Movie_Data.h"
#import "ViewController.h"

@interface ViewController_Detail ()

@end

@implementation ViewController_Detail

@synthesize lblTitle,strTitle,row;

- (void)viewDidLoad {
    
    lblTitle.text = self.movie_data.title;
    
    
    
    
    [super viewDidLoad];

}



@end
