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

@synthesize movies;

NSString *cellid=@"cellid";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    viewModel = [[MovieTableViewModel alloc] initWithDelegate:self];
    [viewModel getMovieData:1];
    
    self.navigationItem.title = @"Now Playing";
    self.navigationController.navigationBar.prefersLargeTitles=YES;
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellid];
    
}

-(void)viewWillAppear:(BOOL)animated{
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"pull to refresh"];
    [refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refresh;
}




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
        
         cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return cell;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height) {
        
        if(viewModel.page < viewModel.allPages){
            [viewModel loadMore];
        }
    }
}
-(void)refreshView:(UIRefreshControl *)refresh
{
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"refreshing data....."];
    NSLog(@"refreshing....");
    
    [viewModel getMovieData:1];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMM d, h:mm a"];
    
    NSString *lastUpdated = [NSString stringWithFormat:@"Last update on %@",[dateFormatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    
    
    [refresh endRefreshing];
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

