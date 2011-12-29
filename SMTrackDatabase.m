//
//  SMTrackDatabase.m
//  iTunes Stats
//
//  Created by Sam Marshall on 12/24/11.
//  Copyright 2011 Sam Marshall. All rights reserved.
//

#import "SMTrackDatabase.h"


@implementation SMTrackDatabase

- (id)init {
	if (self = [super init]) {
		tracks = [[NSDictionary alloc] init];
        playlists = [[NSArray alloc] init];
		NSString *itunes_db_path = [[[NSString alloc] initWithString:@"~/Music/iTunes/iTunes Music Library.xml"] autorelease];
		itunes_db_path = [itunes_db_path stringByExpandingTildeInPath];
		NSDictionary *itunes_library = [[[NSDictionary alloc] initWithContentsOfFile:itunes_db_path] autorelease];
		tracks = [itunes_library objectForKey:@"Tracks"];
		playlists = [itunes_library objectForKey:@"Playlists"];
		[self getMasterLength];
    }
    return self;
}

- (void)loadiTunesLibraryFromLocation:(NSString *)path {
	NSDictionary *itunes_library = [[[NSDictionary alloc] initWithContentsOfFile:path] autorelease];
	tracks = [itunes_library objectForKey:@"Tracks"];
	playlists = [itunes_library objectForKey:@"Playlists"];
	[self getMasterLength];
}

- (void)getMasterLength {
	NSEnumerator *track_enumerator = [tracks objectEnumerator];
	id track_value;
	while (track_value = [track_enumerator nextObject]) {
		UInt32 length = [[track_value valueForKey:@"Total Time"] intValue];
		UInt32 plays = [[track_value valueForKey:@"Play Count"] intValue];
		length = floor(length/1000);
		master = master + (plays * length);
	}
}

- (NSInteger)getMaster {
	return master;
}

- (NSDictionary *)getTrackWithID:(NSInteger)id_num {
	return [tracks objectForKey:[NSString stringWithFormat:@"%i",id_num]];
}

- (NSArray *)getPlaylists {
	[playlists retain];
	[tracks retain];
	return playlists;
}

- (void)dealloc {
	[tracks release];
	[playlists release];
	[super dealloc];
}

@end
