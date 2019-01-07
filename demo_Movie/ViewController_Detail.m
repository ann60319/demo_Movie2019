//
//  ViewController_Detail.m
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2019/1/2.
//  Copyright © 2019 Yi Hwei Huang. All rights reserved.
//

#import "ViewController_Detail.h"
#import "Movie_Data.h"
#import "ViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "ViewController_WebView.h"

@interface ViewController_Detail ()

@end

@implementation ViewController_Detail

@synthesize lblTitle,strPoster_path,row,lblVote_Ave,lblReleaseDate,lblOriginal_Language,img_MoviePoster,strHomepage,strMovie_id;

- (void)viewDidLoad {
    self.navigationController.navigationBar.prefersLargeTitles=NO;
    
    
    strPoster_path=self.movie_data.poster_Path;
//    NSLog(@"url_poster: %@",strPoster_path);
//    [img_MoviePoster.image sd_setImageWithURL:[NSURL URLWithString:strTitle]];
    lblTitle.text = self.movie_data.overview;
    lblVote_Ave.text=[self.movie_data.vote_Average stringValue];
    lblReleaseDate.text=self.movie_data.release_Date;
    lblOriginal_Language.text=self.movie_data.original_Language;
    
    strMovie_id=self.movie_data.movie_Id;

    NSLog(@"movie id: %@",strMovie_id);
    
    [self load_img];
    [self getJSON_Movie_Detail];
    [super viewDidLoad];

}

-(void)load_img
{
    if(strPoster_path!=nil)
    {
        
     img_MoviePoster.image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString:strPoster_path]]];
        
    }
    
}

-(void)getJSON_Movie_Detail{
    
    NSString *strUrlMov_Deatil = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=b97a81e1fcf56b0268751c485866beae&language=en-US",strMovie_id];
    
//    NSLog(@"url_Mov_Deatil : %@",urlMov_Deatil);
    NSURL *url_Mov_Detail = [NSURL URLWithString:strUrlMov_Deatil];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url_Mov_Detail completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"finished get json.....");

        NSString *dumbStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"dumbStr is : %@", dumbStr);
        
        if(dumbStr==nil){
            NSLog(@"look up your internet connection....");
        }
        NSError *err;
        
        NSDictionary *movieJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err){
            NSLog(@"failed to serialized into json : %@",err);
            return ;
        }
        
        
      

        NSArray *arr_homepage = [movieJson valueForKey:@"homepage"];

        self.strHomepage= [NSString stringWithFormat: @"%@", arr_homepage];
        
        NSLog(@"arr_homepage: %@",self.strHomepage);
     

        
        
    }]resume];
    
 
}


- (IBAction)btnHomepage:(id)sender {

    
}
@end
