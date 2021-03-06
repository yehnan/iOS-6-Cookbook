/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 6.x Edition
 BSD License, Use at your own risk
 */


#import "PushButton.h"

#define CAPWIDTH    110.0f
#define INSETS      (UIEdgeInsets){0.0f, CAPWIDTH, 0.0f, CAPWIDTH}
#define BASEGREEN   [[UIImage imageNamed:@"green-out.png"] resizableImageWithCapInsets:INSETS]
#define PUSHGREEN   [[UIImage imageNamed:@"green-in.png"] resizableImageWithCapInsets:INSETS]
#define BASERED     [[UIImage imageNamed:@"red-out.png"] resizableImageWithCapInsets:INSETS]
#define PUSHRED     [[UIImage imageNamed:@"red-in.png"] resizableImageWithCapInsets:INSETS]


@implementation PushButton
- (void) toggleButton: (UIButton *) aButton
{
	if ((_isOn = !_isOn))
	{
		[self setBackgroundImage:BASEGREEN forState:UIControlStateNormal];
		[self setBackgroundImage:PUSHGREEN forState:UIControlStateHighlighted];
        [self setTitle:@"On" forState:UIControlStateNormal];
        [self setTitle:@"On" forState:UIControlStateHighlighted];
	}
	else
	{
		[self setBackgroundImage:BASERED forState:UIControlStateNormal];
		[self setBackgroundImage:PUSHRED forState:UIControlStateHighlighted];
        [self setTitle:@"Off" forState:UIControlStateNormal];
        [self setTitle:@"Off" forState:UIControlStateHighlighted];
	}
}

+ (id) button
{
    PushButton *button = [PushButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0.0f, 0.0f, 300.0f, 233.0f);
    
    // 設定按鈕的對齊屬性
	button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	
	// 設定字型與顏色
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
	button.titleLabel.font = [UIFont boldSystemFontOfSize:24.0f];
    
    // 設定美術圖案
    [button setBackgroundImage:BASEGREEN forState:UIControlStateNormal];
    [button setBackgroundImage:PUSHGREEN forState:UIControlStateHighlighted];
    [button setTitle:@"On" forState:UIControlStateNormal];
    [button setTitle:@"On" forState:UIControlStateHighlighted];
    button.isOn = YES;
	
	// 加入動作
	[button addTarget:button action:@selector(toggleButton:) forControlEvents: UIControlEventTouchUpInside];
    
    return button;
}
@end
