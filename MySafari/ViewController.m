//
//  ViewController.m
//  MySafari
//
//  Created by Chris Snyder on 7/23/14.
//  Copyright (c) 2014 Chris Snyder. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<UIWebViewDelegate, UITextFieldDelegate, UIScrollViewAccessibilityDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UITextField *myURLTextField;
@property(weak, nonatomic)NSURL *url;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
- (void)updateButtons;



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myWebView.scrollView.delegate = self;
    self.backButton.enabled = NO;
    self.backButton.alpha = .5;

    self.forwardButton.enabled = NO;
    self.forwardButton.alpha = .5;

}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([self.myWebView canGoBack]) {
        self.backButton.enabled = YES;
        self.backButton.alpha = 1;
    } else {
        self.backButton.enabled = NO;
        self.backButton.alpha = .5;
    }

    if ([self.myWebView canGoForward]) {
        self.forwardButton.enabled = YES;
        self.forwardButton.alpha = 1;
    } else {
        self.forwardButton.enabled = NO;
        self.forwardButton.alpha = .5;
    }

    NSURLRequest *currentRequest = [webView request];
    NSURL *currentURL = [currentRequest URL];
    self.myURLTextField.text = currentURL.absoluteString;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.myURLTextField.hidden = YES;


}
- (IBAction)onForwardButtonPressed:(id)sender {
    [self.myWebView goForward];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
    {
        NSString *urlString = textField.text;
        NSString *formattedUrlString = @"";
        if ([urlString hasPrefix:@"http://"]) {
            formattedUrlString = urlString;
        } else {
            formattedUrlString = [NSString stringWithFormat:@"http://%@", urlString];
        }
        NSURL *url = [NSURL URLWithString:formattedUrlString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [self.myWebView loadRequest:urlRequest];
        [textField resignFirstResponder];
        
        return YES;

}
- (IBAction)comingSoon:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.title= @"Coming Soon!!";
    [alertView addButtonWithTitle:@"Back to the App"];
    [alertView show];
}


- (void)updateButtons
{
    self.forwardButton.enabled = self.myWebView.canGoForward;
    self.backButton.enabled = self.myWebView.canGoBack;
 

}

- (IBAction)onBackButtonPressed:(id)sender {
    [self.myWebView goBack];


}
- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.myWebView stopLoading];
  

}

- (IBAction)onReloadButtonPressed:(id)sender {
    [self.myWebView reload];
    self.myURLTextField.hidden = NO;
}




@end
