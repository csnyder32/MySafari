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

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
- (void)updateButtons;



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myWebView.scrollView.delegate = self;

}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *urlString = textField.text;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:urlRequest];

    [textField resignFirstResponder];
    return  YES;

}


@end
