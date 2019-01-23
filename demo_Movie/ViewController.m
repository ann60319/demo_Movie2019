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
#import "Protocol.h"
#import "MovieTableViewModel.h"
#import "URLConst.h"


@interface ViewController () <MTableViewModelDelegate>  {
    MovieTableViewModel *viewModel;
    
}

@property (strong,nonatomic) NSMutableArray<Movie_Data *> *movies;


@end





@implementation ViewController

@synthesize movies,arr_passData;

NSString *cellid=@"cellid";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    viewModel = [[MovieTableViewModel alloc] initWithDelegate:self];
    [viewModel getMovieData:1];
    
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
    
    NSDictionary *p_dic = error.userInfo;
    NSString *errorDescprition = p_dic[@"NSLocalizedDescription"];
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Network Error"
                                 message:errorDescprition
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    NSLog(@"%@", p_dic.description);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    
    return  viewModel.arrayMovies.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    
    if(indexPath.row < viewModel.arrayMovies.count){
        
        Movie_Data *movie = viewModel.arrayMovies[indexPath.row];
        //get the object from VM to VC
        self.movie = movie;
        
        cell.textLabel.numberOfLines = 2;
        cell.textLabel.text = movie.title;
        
        NSString *cellDetail = [NSString stringWithFormat:@"%@\r%@",movie.release_Date,movie.overview];
        cell.detailTextLabel.text = cellDetail;
        cell.detailTextLabel.numberOfLines=4;
        
        if([movie.poster_Path isEqualToString:URLIMAGE]){
            [cell.imageView setImage: [UIImage imageNamed:@"no-image.png"]];
        }
        else{
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:movie.poster_Path] placeholderImage:[UIImage imageNamed:@"no-image.png"]];
        }
        
    }
    
//    cell.textLabel.text = movies.title;
//    cell.textLabel.numberOfLines=2;
//    NSString *cell_Detail= [NSString stringWithFormat:@"%@\r%@", movies.release_Date,movies.overview];;
//    cell.detailTextLabel.text=cell_Detail;
//    cell.detailTextLabel.numberOfLines=4;
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:movies.poster_Path] placeholderImage:[UIImage imageNamed:@"no-image.png"]];
//
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return cell;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height) {
        
        if(viewModel.page < viewModel.allPages){
            [viewModel loadMore];
        }
        
//        if(intPage<=allPages){
//
//            intPage++;
//            NSLog(@"intpage:%d",intPage);
//            urlStrDiscoveredMovie = [NSString stringWithFormat:@"https://api.themoviedb.org/3/discover/movie?api_key=b97a81e1fcf56b0268751c485866beae&language=en-US&include_adult=false&include_video=false&page=%d",intPage];
//            [self searchPastMovies:urlStrDiscoveredMovie];
//            //            NSLog(@"urlStrDiscoveredMovie:%@",urlStrDiscoveredMovie);
//
//        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self performSegueWithIdentifier:@"showDetail" sender:indexPath];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        
        NSIndexPath *index_Path = [self.tableView indexPathForSelectedRow];
        
        ViewController_Detail *VC_D = (ViewController_Detail *)[segue destinationViewController];
        
        Movie_Data *moviePicked =  viewModel.arrayMovies[index_Path.row];
        VC_D.movie_data = moviePicked;
        
        [VC_D setTitle:moviePicked.title];
        
    }
}







@end

