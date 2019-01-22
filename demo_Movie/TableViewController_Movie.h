//
//  TableViewController_Movie.h
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2019/1/8.
//  Copyright © 2019 Yi Hwei Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "MovieData.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableViewController_Movie : UITableViewController
{
    NSMutableArray<MovieData *> *arrayMoviedataPastMovies;
}

-(void)refreshView:(UIRefreshControl *)refresh;

@end

NS_ASSUME_NONNULL_END
