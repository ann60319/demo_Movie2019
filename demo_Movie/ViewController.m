//
//  ViewController.m
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2018/12/21.
//  Copyright © 2018 Yi Hwei Huang. All rights reserved.
//

#import "ViewController.h"
#import "Movie_Data.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "ViewController_Detail.h"


@interface ViewController ()

@property (strong,nonatomic) NSMutableArray<Movie_Data *> *movies;


@end





@implementation ViewController

NSString *cellid=@"cellid";

NSString *urlstr_movieNowPlaying;



- (void)viewDidLoad {
    [super viewDidLoad];

    urlstr_movieNowPlaying = @"https://api.themoviedb.org/3/movie/now_playing?api_key=b97a81e1fcf56b0268751c485866beae&language=en-US";
    
    [self setUpMovies];
    [self getJson_MovieNowPlaying:urlstr_movieNowPlaying];

    
    self.navigationItem.title = @"Now Playing";
    self.navigationController.navigationBar.prefersLargeTitles=YES;
    
    
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellid];
    
}


-(void) getJson_MovieNowPlaying:(NSString *)Url{
//    NSLog(@"getJson_MovieNowPlaying......");

    
    
    NSURL *url = [NSURL URLWithString:Url];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        

        
        NSError *err;
        NSDictionary *movieJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err){
            NSLog(@"failed to serialized into json : %@",err);
            return ;
        }
        
//        NSLog(@"json: %@",movieJson);
        
        NSArray *movieResults = [movieJson valueForKey:@"results"];
//        NSLog(@"result: %@",movieResults);
        

        NSMutableArray<Movie_Data *> *arr_movies = NSMutableArray.new;
        
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
            
            
            [arr_movies addObject:movie];
            self.movies = arr_movies;
            
            dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
            });
            
//            NSLog(@"%@", arr_movies);
//            NSLog(@"%@", title);
//            NSLog(@"%@", movie_Id);
//            NSLog(@"%@", vote_Average);
//            NSLog(@"%@", movie.poster_Path);
//            NSLog(@"%@", overview);
//            NSLog(@"%@", release_Date);
            
        }

    }]resume];
    
}

-(void)setUpMovies{
    
    self.movies = NSMutableArray.new;
    
    Movie_Data *movies = Movie_Data.new;
    movies.title = @"Spider Man";
    
    [self.movies addObject:movies];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
    (NSInteger)section{
        return self.movies.count;
    }

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [ tableView
//        dequeueReusableCellWithIdentifier:cellid
//        forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    
    Movie_Data *movies = self.movies[indexPath.row];
    
    cell.textLabel.text = movies.title;
    cell.textLabel.numberOfLines=2;
    
    cell.detailTextLabel.text=movies.overview;
    cell.detailTextLabel.numberOfLines=3;
    

   
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:movies.poster_Path] placeholderImage:[UIImage imageNamed:@"no-image.png"]];
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
   
    return cell;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    [self performSegueWithIdentifier:@"showDetail" sender:indexPath];
 
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        
        NSIndexPath *index_Path = [self.tableView indexPathForSelectedRow];
        
        ViewController_Detail *VC_D = (ViewController_Detail *)[segue destinationViewController];
        
        Movie_Data *movie_picked = self.movies[index_Path.row];
       
        VC_D.movie_data = movie_picked;
    
        [VC_D setTitle:movie_picked.title];

    }
}





@end

