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

int intPage=1;

NSString *cell=@"cell";
NSString *urlStrDiscoveredMovie;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    

    urlStrDiscoveredMovie = [NSString stringWithFormat:@"https://api.themoviedb.org/3/discover/movie?api_key=b97a81e1fcf56b0268751c485866beae&language=en-US&include_adult=false&include_video=false&page=%d",intPage];
    
   

    //load data
    [self searchPastMovies:urlStrDiscoveredMovie];
    
    
    //set up UIrefresh
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"pull to refresh"];
    [refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refresh;
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cell];
   
}

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
           
            NSArray *movieResults = [movieJson valueForKey:@"results"];
            NSLog(@"movie-result:%@",movieResults);
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
                
                
            }
            
            if(intPage==1){
                self.arraymoviesInThePast = arrayMoviedataPastMovies;
                //             NSLog(@"1---self.arraymoviesInThePast :%lu",(unsigned long)self.arraymoviesInThePast.count);
            }
            
            else{
                [self.arraymoviesInThePast addObjectsFromArray:arrayMoviedataPastMovies];
                for(NSObject * a in  arrayMoviedataPastMovies){
                    NSLog(@"a: %@",a);
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                
            });
            
            
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
        if(intPage<200){
            
            intPage++;
//            isRequestData=false;
            
            urlStrDiscoveredMovie = [NSString stringWithFormat:@"https://api.themoviedb.org/3/discover/movie?api_key=b97a81e1fcf56b0268751c485866beae&language=en-US&include_adult=false&include_video=false&page=%d",intPage];
            [self searchPastMovies:urlStrDiscoveredMovie];
          
           
            NSLog(@"searchyear-scrollbottom:%d",intPage);
        }
        
        
    }
}






@end
