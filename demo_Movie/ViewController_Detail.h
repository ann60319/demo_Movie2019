//
//  ViewController_Detail.h
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2019/1/2.
//  Copyright © 2019 Yi Hwei Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie_Data.h"
NS_ASSUME_NONNULL_BEGIN

@interface ViewController_Detail : UIViewController

@property(strong,nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblVote_Ave;
@property (weak, nonatomic) IBOutlet UILabel *lblReleaseDate;
@property (weak, nonatomic) IBOutlet UILabel *lblOriginal_Language;
@property (weak, nonatomic) IBOutlet UIImageView *img_MoviePoster;

- (IBAction)btnHomepage:(id)sender;

@property(strong,nonatomic) NSString *strPoster_path;
@property(strong,nonatomic) NSString *strHomepage;
@property(strong,nonatomic) NSString *strMovie_id;

@property NSInteger *row;
@property (strong,nonatomic)Movie_Data *movie_data;

@end

NS_ASSUME_NONNULL_END
