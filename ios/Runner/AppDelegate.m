#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
[GeneratedPluginRegistrant registerWithRegistry:self];
// custom code to allow get flavor
FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
FlutterMethodChannel* flavorChannel = [FlutterMethodChannel methodChannelWithName:@"flavor" binaryMessenger:controller];
[flavorChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
NSString* flavor = (NSString*)[[NSBundle mainBundle].infoDictionary valueForKey:@"Flavor"];
result(flavor);
}];
return [super application:application didFinishLaunchingWithOptions:launchOptions];
}


@end
