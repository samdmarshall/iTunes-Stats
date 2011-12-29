//
//  SMTrackDatabase.h
//  iTunes Stats
//
//  Created by Sam Marshall on 12/24/11.
//  Copyright 2011 Sam Marshall. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SMTrackDatabase : NSObject {
	NSDictionary *tracks;
	NSArray *playlists;
	NSInteger master;
}
- (void)loadiTunesLibraryFromLocation:(NSString *)path;
- (NSDictionary *)getTrackWithID:(NSInteger)id_num;
- (NSArray *)getPlaylists;
- (void)getMasterLength;
- (NSInteger)getMaster;
@end
