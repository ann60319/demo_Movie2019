//
//  TableViewController_Movie.m
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2019/1/8.
//  Copyright © 2019 Yi Hwei Huang. All rights reserved.
//

#import "TableViewController_Movie.h"
#import "ViewController.h"
#import "Movie_Data.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"


@interface TableViewController_Movie ()

@property (strong,nonatomic) NSMutableArray<Movie_Data *> *arraymoviesInThePast;

@end





@implementation TableViewController_Movie

int intSearchedYear=1995;

NSString *cell=@"cell";
NSString *urlStrDiscoveredMovie;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    [self addOnOneYear];
    
    urlStrDiscoveredMovie = [NSString stringWithFormat:@"https://api.themoviedb.org/3/discover/movie?api_key=b97a81e1fcf56b0268751c485866beae&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_year=%d",intSearchedYear];
    
   
//    NSLog(@"searchedYear: %d",intSearchedYear);
//    NSLog(@"addOnyear: %d",addOnYear);
    //load data
    [self searchPastMovies:urlStrDiscoveredMovie];
    
    
    //set up UIrefresh
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"pull to refresh"];
    [refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refresh;
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cell];
   
}


//-(NSInteger) addOnOneYear
//{
//    static int addOnYear=0;
//    if (addOnYear == 0){
//        intSearchedYear = 2000;
//    }
//    else{
//        addOnYear++;
//        intSearchedYear = intSearchedYear+addOnYear;
//    }
//
//
//    return intSearchedYear;
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arraymoviesInThePast.count;
}

-(void)refreshView:(UIRefreshControl *)refresh
{
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"refreshing data....."];
    NSLog(@"refreshing....");
    
    [self searchPastMovies:urlStrDiscoveredMovie];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMM d, h:mm a"];
    
    NSString *lastUpdated = [NSString stringWithFormat:@"Last update on %@",[dateFormatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    
    [self searchPastMovies:urlStrDiscoveredMovie];
    
    
    
    [refresh endRefreshing];
}

-(void) searchPastMovies:(NSString *)Url{
 
     NSURL *url = [NSURL URLWithString:Url];
 
     [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
 
 
 
     NSError *err;
     NSDictionary *movieJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
     if (err){
     NSLog(@"failed to serialized into json : %@",err);
     return ;
     }
 
//             NSLog(@"json: %@",movieJson);
 
     NSArray *movieResults = [movieJson valueForKey:@"results"];
//             NSLog(@"result: %@",movieResults);
 
 
     NSMutableArray<Movie_Data *> *arrayMoviedataPastMovies = NSMutableArray.new;
 
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
         movie.movie_Id = movie_Id;
         movie.vote_Average = vote_Average;
         movie.overview = overview;
         movie.release_Date = release_Date;
         movie.original_Language = original_Language;
 
 
         NSString *urlstr_img = @"https://image.tmdb.org/t/p/w200";
         movie.poster_Path = [urlstr_img stringByAppendingString: poster_Path];
 
 
         [arrayMoviedataPastMovies addObject:movie];
             
         if(intSearchedYear==1995){
             self.arraymoviesInThePast = arrayMoviedataPastMovies;
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.tableView reloadData];
             });
         }
         else{
             [self.arraymoviesInThePast addObjectsFromArray:arrayMoviedataPastMovies];
             NSLog(@"url: %@",urlStrDiscoveredMovie);
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.tableView reloadData];
             });
         }
         

         
         
         
         
 
     
     }
 
     }]resume];
    
    
 }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell];
    
    Movie_Data *pastMovieList = self.arraymoviesInThePast[indexPath.row];
    
    
    cell.textLabel.text = pastMovieList.title;
    
//    NSLog(@"past movie title: %@",pastMovieList.title);
    cell.textLabel.numberOfLines=2;
    
    cell.detailTextLabel.text=pastMovieList.overview;
    cell.detailTextLabel.numberOfLines=3;
    
    
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:pastMovieList.poster_Path] placeholderImage:[UIImage imageNamed:@"no-image.png"]];
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height) {
//        NSLog(@"At the bottom.....");
        if(intSearchedYear<2019){
            
            intSearchedYear++;
           
            urlStrDiscoveredMovie = [NSString stringWithFormat:@"https://api.themoviedb.org/3/discover/movie?api_key=b97a81e1fcf56b0268751c485866beae&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_year=%d",intSearchedYear];
            [self searchPastMovies:urlStrDiscoveredMovie];
            
            
            
                NSLog(@"searchyear-scrollbottom:%d",intSearchedYear);
        }
        
        
    }
}






@end
