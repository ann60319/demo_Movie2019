//
//  Movie_Data.m
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2019/1/22.
//  Copyright © 2019 Yi Hwei Huang. All rights reserved.
//

#import "Movie_Data.h"
#import "ViewController.h"
#import "ViewController_WebView.h"
#import "ViewController_Detail.h"
#import "TableViewController_Movie.h"
#import "Protocol.h"
#import "URLConst.h"

@implementation Movie_Data

@synthesize  arr_movies;

-(void)initWithDict:(NSDictionary *)dictionary{
    self.dictionary = dictionary;
    self.title = dictionary[@"title"];
    self.movie_Id = dictionary[@"id"];
    self.vote_Average = dictionary[@"vote_average"];
    self.poster_Path = [URLIMAGE stringByAppendingString:dictionary[@"poster_path"]];
    self.overview = dictionary[@"overview"];
    self.release_Date = dictionary[@"release_date"];
    self.original_Language = dictionary[@"original_language"];
}
@end
