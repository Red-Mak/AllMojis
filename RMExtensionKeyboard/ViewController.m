//
//  ViewController.m
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 14/04/16.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "ViewController.h"
//@import QuickLook;
@import AVFoundation;

@interface ViewController () //<QLPreviewControllerDataSource, QLPreviewControllerDelegate>


@property (nonatomic, strong) NSURL *URL;

@property (weak, nonatomic) IBOutlet UIView *videoPlayerView;

@property (nonatomic, strong) AVPlayer *player;
@end

@implementation ViewController
@synthesize URL;
@synthesize player;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [RMUtils registerForDarwinNotificationWithName:@"com.UniversalCopyNotif.FileCopied.UTI=public.jpeg" observer:self action:@selector(copied:)];
}

- (void) copied:(NSNotification*)notif
{
//    NSString *str = notif.name;
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:str preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//    }]];
//    [self presentViewController:alert animated:YES completion:nil];
    
//    NSRange equaleSTRRange = [str rangeOfString:@"="];
//    NSRange finalRange = equaleSTRRange.location;
//    NSRange finalRange = NSMakeRange(equaleSTRRange.location, str.length-equaleSTRRange.length);
//    NSString *UTI = [str substringFromIndex:finalRange.location+1];
//    
//    NSString *ext = [RMUtils extensionFromUTI:UTI];
//    
//    NSData *data = [[UIPasteboard generalPasteboard] dataForPasteboardType:UTI];
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *basePath = paths.firstObject;
//
//    NSString *path = [[basePath stringByAppendingPathComponent:@"ssss"] stringByAppendingPathExtension:ext];
//    BOOL w = [data writeToFile:path atomically:YES];
//    
//    self.URL = [NSURL fileURLWithPath:path];
//    
//    QLPreviewController *previewController=[[QLPreviewController alloc]init];
//    previewController.delegate=self;
//    previewController.dataSource=self;
//    [self presentModalViewController:previewController animated:YES];
//    [previewController.navigationItem setRightBarButtonItem:nil];
    
    
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self playMedia];
    
}

#pragma mark - tuto video
- (IBAction)openSettings:(id)sender {
    [RMUtils openApplicationSettings];
}

- (void)playMedia
{
    
    DeviceModel model = [RMUtils getDeviceModel];
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:(model == DM_IPAD ? @"iPad_Mini_EN_edited" :  @"iphone6S_EN_edited") withExtension:@"mp4"];

    self.player = [[AVPlayer alloc] initWithURL:videoURL];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[player currentItem]];

    self.player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    [layer setBackgroundColor:[UIColor whiteColor].CGColor];
    [layer setFrame:CGRectMake(0, 0, self.videoPlayerView.frame.size.width, self.videoPlayerView.frame.size.height)];
    [layer setVideoGravity:AVLayerVideoGravityResize];
    [self.videoPlayerView.layer addSublayer:layer];
    [self.player setMuted:YES];
    [player play];
}


- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

#pragma mark - quicklook

//- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller
//{
//    return 1;
//}
//
//- (id <QLPreviewItem>)previewController: (QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
//{
//    return self.URL;
//}
//
//- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item
//{
//    return YES;
//}

@end
