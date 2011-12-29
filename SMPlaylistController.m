//
//  SMPlaylistController.m
//
//  Created by Sam Marshall on 12/24/11.
//  Copyright 2011 Sam Marshall. All rights reserved.
//

#import "SMPlaylistController.h"

@implementation SMPlaylistController

-  (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
	return [playlists count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex {
	return [playlists objectAtIndex:rowIndex];
}

- (void)awakeFromNib {
	db = [[SMTrackDatabase alloc] init];
	playlists = [NSMutableArray new];
	[self loadPlaylists:[db getPlaylists]];
	[pl_table reloadData];
	[pl_table setDoubleAction:@selector(doubleClickAction:)];
	[pl_table setTarget:self];
}

- (IBAction)doubleClickAction:(id)sender {
	UInt32 row = [sender clickedRow];
	if (row < [playlists count] && row != -1) {
		[track_list loadTrackData:row fromDatabase:db];
	}
}

- (void)loadPlaylists:(NSArray *)list {
	[playlists removeAllObjects];
	for (UInt32 i = 0; i < [list count]; i++) {
		NSString *pl_name = [[[NSString alloc] initWithFormat:@"%@",[[list objectAtIndex:i] objectForKey:@"Name"]] autorelease];
		[playlists addObject:pl_name];
	}
	[pl_table reloadData];
}

- (void)dealloc {
	[db release];
	[playlists release];
	[super dealloc];
}

@end
