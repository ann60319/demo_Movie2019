//
//  ViewController.h
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2018/12/21.
//  Copyright © 2018 Yi Hwei Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie_Data.h"

@interface ViewController : UITableViewController
{
        NSMutableArray<Movie_Data *> *arr_movies;
}

@end

