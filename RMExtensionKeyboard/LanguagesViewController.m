//
//  ThemesViewController.m
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 06/05/16.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "LanguagesViewController.h"
#import <RMExtensionsFramework/RMExtensionsFramework.h>
@interface LanguagesViewController ()

@property (nonatomic, strong) NSArray *availableLanguagesInTheCloud;
@property (nonatomic, strong) NSArray *alreadyDownloadedLanguagesFromTheCloud;

@end

@implementation LanguagesViewController
@synthesize alreadyDownloadedLanguagesFromTheCloud;
@synthesize availableLanguagesInTheCloud;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    Language *language = [[Language alloc]init];
//    [language setName:@"dzdd"];
//    [language setIdentifier:@"eded"];
    
    self.availableLanguagesInTheCloud = [NSArray array];
    self.alreadyDownloadedLanguagesFromTheCloud = [NSArray array];
    [self.languagesTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
    [self.languagesTableView setBackgroundColor:[UIColor redColor]];
    
//    [[KeyBoardManager sharedManager] availableKeyboardLanguagesWithCompletion:^(NSArray<NSDictionary *> *languages, NSError *error) {
//        self.alreadyDownloadedLanguagesFromTheCloud = [NSArray arrayWithArray:languages];
//        [self.languagesTableView reloadData];
//    }];
    
//    [[RMCloudKitProvider sharedProvider] availableLanguagesWithCompletion:^(NSArray *languages, NSError *error) {
//        self.availableLanguagesInTheCloud = [NSArray arrayWithArray:languages];
//        [self.languagesTableView reloadData];
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - getters


#pragma mark - table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return @"local";
        }
            break;
        case 1:
        {
            return @"cloud";
        }
            break;
        default:
            break;
    }
    return 0;

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return [self.alreadyDownloadedLanguagesFromTheCloud count];
        }
            break;
        case 1:
        {
            return [self.availableLanguagesInTheCloud count];
        }
            break;
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  40.;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
//    switch (indexPath.section)
//    {
//        case 0:
//        {
//            Language *language = [self.alreadyDownloadedLanguagesFromTheCloud objectAtIndex:indexPath.row];
//            [cell.textLabel setText:language.displayName];
//        }
//            break;
//        case 1:
//        {
//            Language *language = [self.availableLanguagesInTheCloud objectAtIndex:indexPath.row];
//            [cell.textLabel setText:language.displayName];
//        }
//            break;
//        default:
//            break;
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    Language *language = [(indexPath.section == 0 ? self.alreadyDownloadedLanguagesFromTheCloud : self.availableLanguagesInTheCloud ) objectAtIndex:indexPath.row];
//    [[RMCloudKitProvider sharedProvider] downloadLanguage:language completion:^(CKRecord * record, NSError *error) {
//        [[KeyBoardManager sharedManager] availableKeyboardLanguagesWithCompletion:^(NSArray<NSDictionary *> *languages, NSError *error) {
//            self.availableLanguagesInTheCloud = [NSArray arrayWithArray:languages];
//            [self.languagesTableView reloadData];
//        }];
//    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
