#import "YouTubeExtractor.h"

@implementation YouTubeExtractor

+ (NSDictionary *)youtubePlayerRequest :(NSString *)clientName :(NSString *)clientVersion :(NSString *)videoID {
    NSLocale *locale = [NSLocale currentLocale];
	NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.googleapis.com/youtube/v3/videos?key=AIzaSyCSANxBDBJGEKFdbFD9aLLEn_09I1erJ5I&part=snippet&id=VIDEO_ID"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"CONSENT=YES+" forHTTPHeaderField:@"Cookie"];
    NSString *jsonBody = [NSString stringWithFormat:@"{\"context\":{\"client\":{\"hl\":\"en\",\"gl\":\"%@\",\"clientName\":\"%@\",\"clientVersion\":\"%@\",\"playbackContext\":{\"contentPlaybackContext\":{\"signatureTimestamp\":\"sts\",\"html5Preference\":\"HTML5_PREF_WANTS\"}}}},\"contentCheckOk\":true,\"racyCheckOk\":true,\"videoId\":\"%@\"}", countryCode, clientName, clientVersion, videoID];
    [request setHTTPBody:[jsonBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    __block NSData *requestData;
    __block BOOL requestFinished = NO;
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        requestData = data;
        requestFinished = YES;
    }] resume];

    while (!requestFinished) {
        [NSThread sleepForTimeInterval:0.02];
    }

    return [NSJSONSerialization JSONObjectWithData:requestData options:0 error:nil];
}

@end
