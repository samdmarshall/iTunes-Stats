//
//  SMTracklistController.m
//
//  Created by Sam Marshall on 12/24/11.
//  Copyright 2011 Sam Marshall. All rights reserved.
//

#import "SMTracklistController.h"

@implementation SMTracklistController

- (void)awakeFromNib {
	tracks = [NSMutableArray new];
	[t_table reloadData];
}

- (id)init {
	if (self = [super init]) {
		tracks = [[NSMutableArray alloc] init];
		[t_table reloadData];
	}
    return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
	return [tracks count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
	return [[tracks objectAtIndex:rowIndex] objectForKey:[aTableColumn identifier]];
}

- (void)loadTrackData:(NSInteger)playlist_num fromDatabase:(SMTrackDatabase *)db {
	[tracks removeAllObjects];
	NSArray *playlist_items = [[[db getPlaylists] objectAtIndex:playlist_num] objectForKey:@"Playlist Items"];
	for (UInt32 i = 0; i < [playlist_items count]; i++) {
		UInt32 id_number = [[[playlist_items objectAtIndex:i] objectForKey:@"Track ID"] intValue];
		NSMutableDictionary *the_track = (NSMutableDictionary *)[db getTrackWithID:id_number];
		UInt32 minutes = [[the_track valueForKey:@"Total Time"] intValue];
		float seconds = (minutes/1000.0)/60.0;
		minutes = floor(seconds);
		seconds = ceil((seconds - minutes) * 60);
		NSString *length_string = [[[NSString alloc] initWithFormat:@"%i:%02i",minutes,(int)seconds] autorelease];
		[the_track setObject:length_string forKey:@"Length"];
		float percent = (([[the_track valueForKey:@"Total Time"] intValue] / 1000.0) * [[the_track valueForKey:@"Play Count"] intValue]);
		percent = (percent / [db getMaster]) * 100.0;
		NSString *percentage = [[[NSString alloc] initWithFormat:@"%f%%",percent] autorelease];
		[the_track setValue:percentage forKey:@"Percentage Played"];
		[tracks addObject:the_track];
	}
	[t_table reloadData];
	[t_table setNeedsDisplay:YES];
}

- (void)dealloc {
	[tracks release];
	[super dealloc];
}

@end
