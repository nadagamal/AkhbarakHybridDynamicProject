/*
 * Copyright 2012 Inomera Research
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "NMPushInboxViewController.h"
#import "NMRichPushViewController.h"
#import "NMPushInboxCell.h"

@interface NMPushInboxViewController()

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIBarButtonItem *selectAllItem;
@property (nonatomic, strong) UIBarButtonItem *deselectAllItem;
@property (nonatomic, strong) UIBarButtonItem *closeItem;
@property (nonatomic, strong) NMUIViewControllerBlock richPushControllerPushingBlock;

@property (nonatomic, strong) UINavigationController *navController;

@end

@implementation NMPushInboxViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _transitionGoesOn = NO;
    }
    return self;
}

- (UIView *)headerView
{
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), 45.0)];
        _headerView.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0, _headerView.bounds.size.width, _headerView.bounds.size.height)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14.0];
        label.text = NMLocalizedString(@"notifications_title",@"Notifications");
        
        [_headerView addSubview:label];
    }
    
    return _headerView;
}

- (UIBarButtonItem *)selectAllItem
{
    if (!_selectAllItem) {
        _selectAllItem = [[UIBarButtonItem alloc] initWithTitle:NMLocalizedString(@"select_all_btn",@"Select All") style:UIBarButtonItemStyleBordered target:self action:@selector(selectAllNotifications)];
    }
    
    return _selectAllItem;
}

- (UIBarButtonItem *)deselectAllItem
{
    if (!_deselectAllItem) {
        _deselectAllItem = [[UIBarButtonItem alloc] initWithTitle:NMLocalizedString(@"deselect_all_btn",@"Deselect All") style:UIBarButtonItemStyleBordered target:self action:@selector(deselectAllNotifications)];
    }
    
    return _deselectAllItem;
}

- (UIBarButtonItem *)closeItem
{
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithTitle:NMLocalizedString(@"close_btn", @"Close") style:UIBarButtonItemStyleBordered target:self action:@selector(closeButtonTouched)];
    }
    
    return _closeItem;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.navController = self.navigationController;
    [NMPushInboxList sharedList].delegate = self;
    self.tableView.tableHeaderView = self.headerView;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:NMLocalizedString(@"delete_btn", @"Delete") style:UIBarButtonItemStyleBordered target:self action:@selector(deleteButtonTouched)];

    UIBarButtonItem *markReadItem = [[UIBarButtonItem alloc] initWithTitle:NMLocalizedString(@"mark_as_read_btn", @"Mark as Read") style:UIBarButtonItemStyleBordered target:self action:@selector(readButtonTouched)];
    UIBarButtonItem *markUnreadItem = [[UIBarButtonItem alloc] initWithTitle:NMLocalizedString(@"mark_as_unread_btn", @"Mark as Unread") style:UIBarButtonItemStyleBordered target:self action:@selector(unreadButtonTouched)];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self setToolbarItems:@[left,markReadItem,markUnreadItem,item,right]];
    self.navigationController.toolbarHidden = YES;
    
    if (self.navigationController.presentingViewController)
        self.navigationItem.leftBarButtonItem = self.closeItem;
    
    self.navigationItem.title = NMLocalizedString(@"inbox_title", @"Inbox");
    
    [[NMPushInboxList sharedList] fetchPushInboxList];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.tabBarController) {
        if (self.editing)
            self.navigationController.toolbarHidden = NO;
        else
            self.navigationController.toolbarHidden = YES;
    }
    
    if ([NMPushManager checkAvailability] && self.tabBarController) {
        if (![NMPushInboxList sharedList].delegate) [NMPushInboxList sharedList].delegate = self;
        [[NMPushInboxList sharedList] fetchPushInboxList];
    }
    
    [self.tableView reloadData];
    [self updateEmptyImageView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(!self.transitionGoesOn)
    {
        if([NMPushInboxList sharedList].newPushReceived)
        {
            [self showNotificationWithPushObject:self.richPush];
            [NMPushInboxList sharedList].newPushReceived = NO;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (!self.navigationController.presentingViewController)
        self.navigationController.toolbarHidden = NO;
}

- (void)dealloc
{
    self.navController.delegate = nil;
}

-(void)updateEmptyImageView
{
    if([[NMPushInboxList sharedList] count] == 0)
    {
        [UIView animateWithDuration:0.5f animations:^{
            self.tableView.tableHeaderView = nil;
            self.emptyImageView.hidden = NO;
            [self setEditing:NO animated:YES];
            self.navigationItem.rightBarButtonItem = nil;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5f animations:^{
            self.tableView.tableHeaderView = self.headerView;
            self.emptyImageView.hidden = YES;
            self.navigationItem.rightBarButtonItem = self.editButtonItem;
        }];
    }
}

-(void)notificationFetchedWithPushObject:(NMPushObject*)object
{
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self updateEmptyImageView];
    if(![Netmera richPushShouldBeShownImmediately])
    {
        [NMAlertView alertViewWithTitle:NMLocalizedString(@"notification_title", @"Notification") message:object.alertText cancelButtonTitle:NMLocalizedString(@"cancel_btn", @"Cancel") otherButtonTitles:@[NMLocalizedString(@"show_btn", @"Show")] onDismiss:^(NSInteger buttonIndex) {
            [self showNotificationWithPushObject:object];
        } onCancel:^{
            [[NMPushManager loadingHUD] hide:YES];
            [NMPushInboxList sharedList].newPushReceived = NO;
        }];
    }
    else
    {
        [self showNotificationWithPushObject:object];
    }
}

-(void)showNotificationWithPushObject:(NMPushObject*)obj
{
    if([obj isKindOfClass:[NMRichPushObject class]])
    {
        [NMPushInboxList sharedList].newPushReceived = NO;
        __weak NMPushInboxViewController *weakSelf = self;
        weakSelf.richPushControllerPushingBlock = ^(UIViewController *controller){
            NMRichPushObject *object = (NMRichPushObject*)obj;
            
            if([controller isKindOfClass:[NMPushInboxViewController class]])
            {
                [[NMPushInboxList sharedList] markAsReadPushObjectAtIndex:[[NMPushInboxList sharedList] indexOfPushObject:object]];
                __block NMRichPushViewController *richPushViewController = [[NMRichPushViewController alloc] initWithRichPushObject:object];
                [weakSelf.navigationController pushViewController:richPushViewController animated:YES];
            }
            else if ([controller isKindOfClass:[NMNotificationController class]])
            {
                [(NMNotificationController*)controller requestUpdateWithRichPushObject:object];
            }
            weakSelf.richPushControllerPushingBlock = nil;
        };
        
        if(!self.transitionGoesOn)
        {
            if(weakSelf.navigationController.visibleViewController != weakSelf)
            {
                if([weakSelf.navigationController.visibleViewController isKindOfClass:[NMNotificationController class]])
                {
                    NMNotificationController *richPushController = (NMNotificationController*)weakSelf.navigationController.visibleViewController;
                    [richPushController requestUpdateWithRichPushObject:(NMRichPushObject*)obj];
                }
            }
            else
                weakSelf.richPushControllerPushingBlock(weakSelf);
            weakSelf.richPushControllerPushingBlock = nil;
        }
    }
    else
    {
        NSString *message = nil;
        if (obj.alertText)
            message = obj.alertText;
        else
            message = @"No rich push notification to show.";
        
        [[[UIAlertView alloc] initWithTitle:NMLocalizedString(@"notification_title", @"Notification") message:message delegate:nil cancelButtonTitle:NMLocalizedString(@"ok_btn", @"Ok") otherButtonTitles:nil, nil] show];
    }
}


#pragma mark - navigation controller delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.transitionGoesOn = YES;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.transitionGoesOn = NO;
    if(self.richPushControllerPushingBlock)
    {
        self.richPushControllerPushingBlock(viewController);
    }
}

#pragma mark -

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // To delete the push notification
    if(buttonIndex == actionSheet.destructiveButtonIndex)
    {
        NSArray *array = [self.tableView indexPathsForSelectedRows];
        NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
        for(NSIndexPath *indexPath in array)
        {
            [set addIndex:indexPath.row];
        }
        
        if (array.count == [NMPushInboxList sharedList].count && self.navigationController.presentingViewController)
            self.navigationItem.leftBarButtonItem = self.closeItem;
        
        [[NMPushInboxList sharedList] removePushObjectsAtIndexes:set];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self updateEmptyImageView];
    }
    else if(buttonIndex == actionSheet.cancelButtonIndex)
    {
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)closeButtonTouched
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        self.navigationController.viewControllers = nil;
    }];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    self.tableView.allowsMultipleSelectionDuringEditing = editing;
    [self.tableView setEditing:editing animated:animated];
    if(editing)
    {
        [self.navigationController setToolbarHidden:NO animated:YES];
        
        if ([self.tableView numberOfRowsInSection:0] > 0)
            self.navigationItem.leftBarButtonItem = self.selectAllItem;
    }
    else{
        [self.navigationController setToolbarHidden:YES animated:YES];
        
        if (self.navigationController.presentingViewController)
            self.navigationItem.leftBarButtonItem = self.closeItem;
        else
            self.navigationItem.leftBarButtonItem = nil;
    }
    
}

-(void)unreadButtonTouched
{
    NSUInteger countOfSelectedRows = [self.tableView indexPathsForSelectedRows].count;
    if(countOfSelectedRows > 0)
    {
        NSArray *array = [self.tableView indexPathsForSelectedRows];
        NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
        for(NSIndexPath *indexPath in array)
        {
            [set addIndex:indexPath.row];
        }
        [[NMPushInboxList sharedList] markAsUnreadPushObjectsAtIndexes:set];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self updateEmptyImageView];
        
        if (countOfSelectedRows == [NMPushInboxList sharedList].count)
            self.navigationItem.leftBarButtonItem = self.selectAllItem;
    }
}

-(void)readButtonTouched
{
    NSUInteger countOfSelectedRows = [self.tableView indexPathsForSelectedRows].count;
    if(countOfSelectedRows > 0)
    {
        NSArray *array = [self.tableView indexPathsForSelectedRows];
        NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
        for(NSIndexPath *indexPath in array)
        {
            [set addIndex:indexPath.row];
        }
        [[NMPushInboxList sharedList] markAsReadPushObjectsAtIndexes:set];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self updateEmptyImageView];

        if (countOfSelectedRows == [NMPushInboxList sharedList].count)
            self.navigationItem.leftBarButtonItem = self.selectAllItem;
    }
}

-(void)deleteButtonTouched
{
    NSUInteger countOfSelectedRows = [self.tableView indexPathsForSelectedRows].count;
    if(countOfSelectedRows > 0)
    {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:NMLocalizedString(@"cancel_btn", @"Cancel") destructiveButtonTitle:NMLocalizedString(@"delete_notifications_btn", @"Delete Notifications") otherButtonTitles:nil, nil];
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [sheet showFromBarButtonItem:self.toolbarItems[3] animated:YES];
        } else {
            [sheet showFromToolbar:self.navigationController.toolbar];
        }
    }
}

- (void)selectAllNotifications
{
    for (int index = 0; index < [self.tableView numberOfRowsInSection:0]; index ++) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionNone];
    }
    
    self.navigationItem.leftBarButtonItem = self.deselectAllItem;
}

- (void)deselectAllNotifications
{
    for (int index = 0; index < [self.tableView numberOfRowsInSection:0]; index++) {
        [self.tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                      animated:YES];
    }
    
    self.navigationItem.leftBarButtonItem = self.selectAllItem;
}

#pragma mark - NetmeraPushInboxList delegate

- (void)pushInboxListDidLoad
{
    [self.tableView reloadData];
    [[NMPushManager loadingHUD] hide:YES];
    [self updateEmptyImageView];
}

- (void)pushInboxListDidFailLoad:(NSError *)error
{
    [[NMPushManager loadingHUD] hide:YES];
    [self updateEmptyImageView];
}

#pragma mark - tableview datasource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NMPushInboxCell rowHeight];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[NMPushInboxList sharedList] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"NMPushInboxCellIdentifier";
    NMPushInboxCell *pushInboxCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(pushInboxCell == nil) {
        pushInboxCell = [[[NSBundle mainBundle] loadNibNamed:@"NMPushInboxCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    // Configure the cell
    NMRichPushObject *object = (NMRichPushObject*)[[NMPushInboxList sharedList] pushObjectAtIndex:indexPath.row];
    if(object.pushInboxStatus == NMPushInboxStatusUnread)
        pushInboxCell.backgroundColor = [UIColor colorWithRed:203/255.0 green:217/255.0 blue:239/255.0 alpha:1];
    else
        pushInboxCell.backgroundColor = [UIColor whiteColor];
    pushInboxCell.pushMessageLabel.text = object.alertText;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    pushInboxCell.dateLabel.text = [formatter stringFromDate:object.createDate];
    return pushInboxCell;
}

#pragma mark - tableview delegate

-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NMLocalizedString(@"delete_btn", @"Delete");
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewCellEditingStyleDelete;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    [[NMPushInboxList sharedList] removePushObjectAtIndex:indexPath.row];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self updateEmptyImageView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!tableView.editing)
    {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        if ([NMPushManager checkAvailability]) {
            NMPushObject *object = [[NMPushInboxList sharedList] pushObjectAtIndex:indexPath.row];
            [self showNotificationWithPushObject:object];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"Selected rich push notification is not available. You should check your internet connection."
                                                               delegate:nil
                                                      cancelButtonTitle:NMLocalizedString(@"ok_btn", @"Ok")
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    } else {
        if ([NMPushInboxList sharedList].count == [self.tableView indexPathsForSelectedRows].count)
            self.navigationItem.leftBarButtonItem = self.deselectAllItem;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editing) {
        self.navigationItem.leftBarButtonItem = self.selectAllItem;
    }
}

@end
