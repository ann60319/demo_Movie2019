//
//  ViewController.m
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2018/12/21.
//  Copyright © 2018 Yi Hwei Huang. All rights reserved.
//

#import "ViewController.h"
#import "MovieData.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "ViewController_Detail.h"
#import "Protocol.h"
#import "MovieTableViewModel.h"

@interface ViewController () <MTableViewModelDelegate>  {
    MovieTableViewModel *viewModel;
    
}

@property (strong,nonatomic) NSMutableArray<MovieData *> *movies;


@end





@implementation ViewController

@synthesize movies,arr_passData;

NSString *cellid=@"cellid";

NSString *urlstr_movieNowPlaying;



- (void)viewDidLoad {
    [super viewDidLoad];

    urlstr_movieNowPlaying = @"https://api.themoviedb.org/3/movie/now_playing?api_key=b97a81e1fcf56b0268751c485866beae&language=en-US";
    
    
    
    
//    [self setUpMovies];
    
//    Movie_Data *movieData = [[Movie_Data alloc]init];
//    
//    [movieData parseJson_MovieNowPlaying:urlstr_movieNowPlaying
//     
//         tableReloadData:^{
//     
//             NSLog(@"self.arr_passData: %@",self.arr_passData);
//             
//             dispatch_async(dispatch_get_main_queue(), ^{
//              [self.tableView reloadData];
//              NSLog(@"reload data now");
//                 
//             });
//     
//         }
//           cannotReload:^{
//     
//              NSLog(@"error cannot reload...");
//         }];
    

    self.navigationItem.title = @"Now Playing";
    self.navigationController.navigationBar.prefersLargeTitles=YES;
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellid];
    
}


//-(void) getJson_MovieNowPlaying:(NSString *)Url{
//
//
//    NSURL *url = [NSURL URLWithString:Url];
//
//    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//
//
//        NSError *err;
//        NSDictionary *movieJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
//        if (err){
//            NSLog(@"failed to serialized into json : %@",err);
//            return ;
//        }
//
//        NSArray *movieResults = [movieJson valueForKey:@"results"];
////        NSLog(@"result: %@",movieResults);
//
//
//        NSMutableArray<Movie_Data *> *arr_movies = NSMutableArray.new;
//
//        for(NSDictionary *movieDict in movieResults){
//            NSString *title = movieDict[@"title"];
//            NSString *movie_Id = movieDict[@"id"];
//            NSNumber *vote_Average = movieDict[@"vote_average"];
//            NSString *poster_Path = movieDict[@"poster_path"];
//            NSString *overview = movieDict[@"overview"];
//            NSString *release_Date = movieDict[@"release_date"];
//            NSString *original_Language = movieDict[@"original_language"];
//
//
//            Movie_Data *movie = Movie_Data.new;
//            movie.title = title;
//            movie.movie_Id = movie_Id;
//            movie.vote_Average = vote_Average;
//            movie.overview = overview;
//            movie.release_Date = release_Date;
//            movie.original_Language = original_Language;
//
//
//            NSString *urlstr_img = @"https://image.tmdb.org/t/p/w200";
//            movie.poster_Path = [urlstr_img stringByAppendingString: poster_Path];
//
//
//            [arr_movies addObject:movie];
//            self.movies = arr_movies;
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//             [self.tableView reloadData];
//            });
//
//
//
//        }
//
//    }]resume];
//
//}

- (void)dataDidLoad{
    [self.tableView reloadData];
}

- (void)getDataFail:(NSError *)error {
    <#code#>
}


-(void)setUpMovies{
    
    self.movies = NSMutableArray.new;
    
    MovieData *movies = MovieData.new;
    movies.title = @"Spider Man";
    
    [self.movies addObject:movies];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    //        return self.movies.count;
    //    NSLog(@"table cell count: %lu",(unsigned long)self.arr_passData.count);
    return  self.arr_passData.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    
    MovieData *movies = self.arr_passData[indexPath.row];
    //    self.movies[indexPath.row];
    
    
    
    cell.textLabel.text = movies.title;
    cell.textLabel.numberOfLines=2;
    
    NSString *cell_Detail= [NSString stringWithFormat:@"%@\r%@", movies.release_Date,movies.overview];;
    cell.detailTextLabel.text=cell_Detail;
    cell.detailTextLabel.numberOfLines=4;
    
    
    
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
        
        MovieData *movie_picked =  self.arr_passData[index_Path.row];
        //        self.movies[index_Path.row];
        
        VC_D.movie_data = movie_picked;
        
        [VC_D setTitle:movie_picked.title];
        
    }
}







@end

