/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 6.x Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>

#define COOKBOOK_PURPLE_COLOR [UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]
#define BARBUTTON(TITLE, SELECTOR) [[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]

#define IS_IPAD	(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define RECTCENTER(rect) CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
#define SAFE_PERFORM_WITH_ARG(THE_OBJECT, THE_SELECTOR, THE_ARG) (([THE_OBJECT respondsToSelector:THE_SELECTOR]) ? [THE_OBJECT performSelector:THE_SELECTOR withObject:THE_ARG] : nil)
#define RESIZABLE(_VIEW_) [_VIEW_ setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth]

#import <UIKit/UIKit.h>
#import "ModalAlertDelegate.h"
#import "ModalSheetDelegate.h"

#define COOKBOOK_PURPLE_COLOR	[UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]
#define BARBUTTON(TITLE, SELECTOR) 	[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]

@interface TestBedViewController : UIViewController
@end

@implementation TestBedViewController

// 三個選項按鈕與Cancel按鈕
- (void) alertThree: (id) sender
{
    // Cancel = 0, One = 1, Two = 2, Three = 3
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"One", @"Two", @"Three", nil]; 
    ModalAlertDelegate *delegate = [ModalAlertDelegate delegateWithAlert:alertView];
    NSLog(@"Selected Button: %d", [delegate show]);
}

// 文字輸入
- (void) alertText: (id) sender
{
    // OK = 1, Cancel = 0
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"What is your name?" message:@"Please enter your name" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    ModalAlertDelegate *delegate = [ModalAlertDelegate delegateWithAlert:alertView];
    
    NSString *response = @"No worries. I'm shy too.";
    if ([delegate show])
        response = [NSString stringWithFormat:@"Hello %@", [alertView textFieldAtIndex:0].text];
    
    [[[UIAlertView alloc] initWithTitle:nil message:response delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil] show];
}

// 基本動作表
- (void) actionBasic: (id) sender
{
    // Destructive = 0, One = 1, Two = 2, Three = 3, Cancel = 4
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Title" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Destructive" otherButtonTitles:@"One", @"Two", @"Three", nil];
    ModalSheetDelegate *msd = [ModalSheetDelegate delegateWithSheet:actionSheet];
    actionSheet.delegate = msd;
    
    int result = [msd showFromBarButtonItem:sender animated:YES];
    NSLog(@"Selected Button: %d", result);
}

// 長動作表
- (void) actionSheetLong: (id) sender
{
    // 底下程式碼無法用於iOS 6早期beta測試版 -- 可捲動列表加上run loop，需小心carefully with run loops
    // UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine", nil];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"One", @"Two", @"Three", @"Four", @"Five", nil];
    ModalSheetDelegate *msd = [ModalSheetDelegate delegateWithSheet:actionSheet];
    actionSheet.delegate = msd;
    
    int result = [msd showFromBarButtonItem:sender animated:YES];
    NSLog(@"Selected Button: %d", result);
}

#pragma mark redirect to samples

- (void) alert: (id) sender
{
    [self alertText:sender];
}

- (void) action: (id) sender
{
    // [self actionBasic: sender];
    [self actionSheetLong:sender];
}

- (void) loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = BARBUTTON(@"Alert", @selector(alert:));
    self.navigationItem.leftBarButtonItem = BARBUTTON(@"Action", @selector(action:));
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
@end

#pragma mark -

#pragma mark Application Setup
@interface TestBedAppDelegate : NSObject <UIApplicationDelegate>
{
	UIWindow *window;
}
@end
@implementation TestBedAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{	
    // [application setStatusBarHidden:YES];
    [[UINavigationBar appearance] setTintColor:COOKBOOK_PURPLE_COLOR];
    
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	TestBedViewController *tbvc = [[TestBedViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tbvc];
    window.rootViewController = nav;
	[window makeKeyAndVisible];
    return YES;
}
@end
int main(int argc, char *argv[]) {
    @autoreleasepool {
        int retVal = UIApplicationMain(argc, argv, nil, @"TestBedAppDelegate");
        return retVal;
    }
}