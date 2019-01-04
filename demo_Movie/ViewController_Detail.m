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
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

@interface ViewController_Detail ()

@end

@implementation ViewController_Detail

@synthesize lblTitle,strTitle,row,lblVote_Ave,lblReleaseDate,lblOriginal_Language,img_MoviePoster;

- (void)viewDidLoad {
    self.navigationController.navigationBar.prefersLargeTitles=NO;
    
    
    strTitle=self.movie_data.poster_Path;
//    [img_MoviePoster.image sd_setImageWithURL:[NSURL URLWithString:strTitle]];
    lblTitle.text = self.movie_data.overview;
    lblVote_Ave.text=[self.movie_data.vote_Average stringValue];
    lblReleaseDate.text=self.movie_data.release_Date;
    lblOriginal_Language.text=self.movie_data.original_Language;
    
    
    [super viewDidLoad];

}



@end
