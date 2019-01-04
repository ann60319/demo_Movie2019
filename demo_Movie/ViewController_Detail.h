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
@property(strong,nonatomic) NSString *strTitle;
@property NSInteger *row;

@property (strong,nonatomic)Movie_Data *movie_data;

@end

NS_ASSUME_NONNULL_END
