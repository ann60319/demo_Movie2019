//
//  movie_Data.m
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2018/12/22.
//  Copyright © 2018 Yi Hwei Huang. All rights reserved.
//

#import "Movie_Data.h"
#import "ViewController.h"
#import "ViewController_WebView.h"
#import "ViewController_Detail.h"
#import "TableViewController_Movie.h"



@implementation Movie_Data

@synthesize  arr_movies;

-(void) parseJson_MovieNowPlaying:(NSString *)Url{
    
    
    NSURL *url = [NSURL URLWithString:Url];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        
        NSError *err;
        NSDictionary *movieJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err){
            NSLog(@"failed to serialized into json : %@",err);
            return ;
        }
        
        NSArray *movieResults = [movieJson valueForKey:@"results"];
        NSLog(@"result: %@",movieResults);
        
//        if(self.arr_movies == nil){
            self.arr_movies = NSMutableArray.new;
//        }
        
        
        for(NSDictionary *movieDict in movieResults){
            NSString *title = movieDict[@"title"];
            NSString *movie_Id = movieDict[@"id"];
            NSNumber *vote_Average = movieDict[@"vote_average"];
            NSString *poster_Path = movieDict[@"poster_path"];
            NSString *overview = movieDict[@"overview"];
            NSString *release_Date = movieDict[@"release_date"];
            NSString *original_Language = movieDict[@"original_language"];
            
            
            Movie_Data *movie = Movie_Data.new;
            movie.title = title;
            
//            NSLog(@"movie.title: %@",movie.title);
            movie.movie_Id = movie_Id;
            movie.vote_Average = vote_Average;
            movie.overview = overview;
            movie.release_Date = release_Date;
            movie.original_Language = original_Language;
            
            
            NSString *urlstr_img = @"https://image.tmdb.org/t/p/w200";
            movie.poster_Path = [urlstr_img stringByAppendingString: poster_Path];
            
            
            [self.arr_movies addObject:movie];
            
            ViewController *VC1 = [[ViewController alloc]init];
            VC1.arr_passData = self.arr_movies;
            
            NSLog(@"arr_movies in movie data : %@",self.arr_movies);
            NSLog(@"arraypass to viewcontroller : %@",VC1.arr_passData);
            
//            ViewController *VC1 = [[ViewController alloc]init];
//            self.arr_movies = VC1.movies;
//
//            NSLog(@"VC1.movies: %@",VC1.movies);
            
//            [VC1.tableView reloadData];
           
//
            
            
        }
        
    }]resume];
    
}

@end
