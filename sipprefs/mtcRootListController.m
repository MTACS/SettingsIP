#include "mtcRootListController.h"
#include <spawn.h>

@implementation mtcRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

- (void)kill {

pid_t pid;

	int status;

	const char* args[] = {"killall", "-9", "Preferences", NULL};

	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);

	waitpid(pid, &status, WEXITED);

}

- (void)twitter {

	[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://twitter.com/mtac8"]];

}

- (void)donate {

	[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://paypal.me/mtac"]]; 

}

@end
