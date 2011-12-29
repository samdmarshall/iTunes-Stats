//
//  SMTracklistController.h
//
//  Created by Sam Marshall on 12/24/11.
//  Copyright 2011 Sam Marshall. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SMTrackDatabase.h"

@interface SMTracklistController : NSObject <NSTableViewDataSource> {
	NSMutableArray *tracks;
	IBOutlet NSTableView *t_table;
}
- (void)loadTrackData:(NSInteger)playlist_num fromDatabase:(SMTrackDatabase *)db;
@end
