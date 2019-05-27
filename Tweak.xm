#include <objc/runtime.h>
#include <dlfcn.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

static bool enabled = YES;

static void loadPrefs() {

  NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.mtac.sipprefs.plist"]];

  if (prefs) {

    enabled = [prefs objectForKey:@"enabled"] ? [[prefs objectForKey:@"enabled"] boolValue] : enabled;

  }

}

@interface PSUIPrefsListController

@property (nonatomic, copy) NSString * wifiString;

@end

%ctor {

  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), 
  NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.mtac.sipprefs/settingschanged"), 
  NULL, CFNotificationSuspensionBehaviorCoalesce);
  loadPrefs();

}

%hook PSUIPrefsListController

- (NSString *)wifiString {

	NSString *address = @"error";

	struct ifaddrs *interfaces = NULL;
	struct ifaddrs *temp_addr = NULL;
	int success = 0;

	success = getifaddrs(&interfaces);
	if (success == 0) {

			temp_addr = interfaces;
			while (temp_addr != NULL) {
					if (temp_addr->ifa_addr->sa_family == AF_INET) {
							// Check if interface is en0 which is the wifi connection on the iPhone
							if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
									// Get NSString from C String
									address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];

							}

					}

					temp_addr = temp_addr->ifa_next;
			}
	}

	freeifaddrs(interfaces);

	if (enabled == YES) {

		return address;

	} else {

		return %orig;

	}

}

%end