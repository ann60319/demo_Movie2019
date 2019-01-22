//
//  TableViewController_Movie.m
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2019/1/8.
//  Copyright © 2019 Yi Hwei Huang. All rights reserved.
//

#import "TableViewController_Movie.h"
#import "ViewController.h"
#import "MovieData.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"


@interface TableViewController_Movie ()

@property (strong,nonatomic) NSMutableArray<MovieData *> *arraymoviesInThePast;

@end





@implementation TableViewController_Movie

int intPage=1;
int allPages;
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
    
    intPage=1;
    urlStrDiscoveredMovie=[NSString stringWithFormat:@"https://api.themoviedb.org/3/discover/movie?api_key=b97a81e1fcf56b0268751c485866beae&language=en-US&include_adult=false&include_video=false&page=%d",intPage];
    
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
          
            
            if(intPage==1)
            {
                NSArray *all_Pages = [movieJson valueForKey:@"total_pages"];
                allPages = [[NSString stringWithFormat:@"%@", all_Pages] intValue];
            }
            

            
            NSMutableArray<MovieData *> *arrayMoviedataPastMovies = NSMutableArray.new;
            
            for(NSDictionary *movieDict in movieResults){
                NSString *title = movieDict[@"title"];
//                NSString *movie_Id = movieDict[@"id"];
//                NSNumber *vote_Average = movieDict[@"vote_average"];
                NSString *poster_Path = movieDict[@"poster_path"];
                NSString *overview = movieDict[@"overview"];
                NSString *release_Date = movieDict[@"release_date"];
//                NSString *original_Language = movieDict[@"original_language"];
                
                
                MovieData *movie = MovieData.new;
                
                if(title== (id)[NSNull null])
                {
                    title=@"No movie title";
                    movie.title=title;
                    
                }
                else{
                    movie.title = title;
                }
                
                if(overview == (id)[NSNull null]){
                    overview = @"No overview";
                    movie.overview = overview;
                }
                else{
                    movie.overview = overview;
                }
                
                if(release_Date == (id)[NSNull null]){
                   movie.release_Date=@"No release date available";
                   movie.release_Date = release_Date;
                }
                
                else{
                    movie.release_Date = release_Date;
                }
//                movie.movie_Id = movie_Id;
//                movie.vote_Average = vote_Average;
//                movie.overview = overview;
//                movie.release_Date = release_Date;
//                movie.original_Language = original_Language;
                
                if (poster_Path == (id)[NSNull null]){
                     movie.poster_Path = @"1";

                   
                }
                
                else{
                    NSString *urlstr_img = @"https://image.tmdb.org/t/p/w200";
                    movie.poster_Path = [urlstr_img stringByAppendingString: poster_Path];

                }
                
                [arrayMoviedataPastMovies addObject:movie];
                
            }
            
            if(intPage==1){
                self.arraymoviesInThePast = arrayMoviedataPastMovies;
                
            }
            
            else{
                [self.arraymoviesInThePast addObjectsFromArray:arrayMoviedataPastMovies];
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                
            });
            
        }]resume];
 }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell];
    
    MovieData *pastMovieList = self.arraymoviesInThePast[indexPath.row];
    
    
    cell.textLabel.text = pastMovieList.title;
    cell.textLabel.numberOfLines=2;
    
    NSString *cell_Detail= [NSString stringWithFormat:@"%@\r%@", pastMovieList.release_Date,pastMovieList.overview];;
    
    if(cell_Detail==nil){
        cell.detailTextLabel.text=@"No overview";
    }
    else{
        cell.detailTextLabel.text=cell_Detail;
    }
    
    cell.detailTextLabel.numberOfLines=4;
    

    if ([pastMovieList.poster_Path isEqualToString:@"1"]){

         [cell.imageView setImage: [UIImage imageNamed:@"no-image.png"]];
      
    }
    else{
       [cell.imageView sd_setImageWithURL:[NSURL URLWithString:pastMovieList.poster_Path] placeholderImage:[UIImage imageNamed:@"no-image.png"]];

    }
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height) {
       
        if(intPage<=allPages){
            
            intPage++;
            NSLog(@"intpage:%d",intPage);
            urlStrDiscoveredMovie = [NSString stringWithFormat:@"https://api.themoviedb.org/3/discover/movie?api_key=b97a81e1fcf56b0268751c485866beae&language=en-US&include_adult=false&include_video=false&page=%d",intPage];
            [self searchPastMovies:urlStrDiscoveredMovie];
//            NSLog(@"urlStrDiscoveredMovie:%@",urlStrDiscoveredMovie);
          
        }
    }
}


@end
