//
//  ViewController_WebView.h
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2019/1/7.
//  Copyright © 2019 Yi Hwei Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie_Data.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewController_WebView : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *act_Indicator;


@property(strong,nonatomic) NSString *strHomepage_Path;
@property (strong,nonatomic)Movie_Data *movie;



@end

NS_ASSUME_NONNULL_END
