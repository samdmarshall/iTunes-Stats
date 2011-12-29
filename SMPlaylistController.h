//
//  SMPlaylistController.h
//
//  Created by Sam Marshall on 12/24/11.
//  Copyright 2011 Sam Marshall. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SMTrackDatabase.h"
#import "SMTracklistController.h"

@interface SMPlaylistController : NSObject {
	NSMutableArray *playlists;
	IBOutlet SMTracklistController *track_list;
	SMTrackDatabase *db;
	IBOutlet NSTableView *pl_table;
}
- (void)loadPlaylists:(NSArray *)list;
- (int)numberOfRowsInTableView:(NSTableView *)tableView;
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex;

@end
