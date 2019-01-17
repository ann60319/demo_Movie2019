//
//  movie_Data.h
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2018/12/22.
//  Copyright © 2018 Yi Hwei Huang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Movie_Data : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *overview;
@property (strong, nonatomic) NSString *homepage;
@property (strong, nonatomic) NSString *original_Language;

@property (strong, nonatomic) NSString *movie_Id;
@property (strong, nonatomic) NSString *poster_Path;
@property (strong, nonatomic) NSString *release_Date;
@property (strong,nonatomic) NSNumber *vote_Average;
@property (strong,nonatomic) NSMutableArray *arr_movies;

-(void) parseJson_MovieNowPlaying:(NSString *)Url;



@end


