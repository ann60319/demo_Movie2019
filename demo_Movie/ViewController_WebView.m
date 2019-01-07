//
//  ViewController_WebView.m
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2019/1/7.
//  Copyright © 2019 Yi Hwei Huang. All rights reserved.
//

#import "ViewController_WebView.h"
#import "ViewController_Detail.h"
#import "Movie_Data.h"



@interface ViewController_WebView ()



@end




@implementation ViewController_WebView

@synthesize strHomepage_Path;

- (void)viewDidLoad {
     [super viewDidLoad];

    
    strHomepage_Path=self.movie.homepage;
    
    NSLog(@"movie.homepage : %@",self.movie.homepage);
    NSLog(@"strHomepage_Path: %@",strHomepage_Path);
    
    NSURL *url_Homepage = [NSURL URLWithString:strHomepage_Path];
    NSURLRequest *requestUrl = [NSURLRequest requestWithURL:url_Homepage];
    [self.webView loadRequest:requestUrl];
   
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.act_Indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.act_Indicator stopAnimating];
    self.act_Indicator.hidesWhenStopped=YES;
}

@end
