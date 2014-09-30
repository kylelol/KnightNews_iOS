//
//  KKNewsAPI.m
//  KnightNews
//
//  Created by Kyle Kirkland on 9/30/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "KKNewsAPI.h"
#import "JJVStoryItem.h"
#import "JJVStoryItemStore.h"
#import "Constants.h"

@interface KKNewsAPI()

@property (nonatomic) NSURLSession *session;

@end

@implementation KKNewsAPI

/*Singleton pattern */
+(instancetype) sharedUtilities
{
    static KKNewsAPI *sharedUtilities;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUtilities = [[KKNewsAPI alloc] init];
    });
    
    return sharedUtilities;
}


/**
 Override
 */
-(id)init
{
    self = [super init];
    if ( self )
    {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
        
    }
    
    return self;
}

#pragma mark - Request Methods
-(void)downloadNewsFeedWithCompletionBlock:(KKNewsRetrievedCompletionBlock)completionBlock
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: YES];
    NSString *requestString = @"http://knightnews.com/api/get_recent_posts/";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL: url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"%@", jsonObject);
        
        [self parseJSONObject: jsonObject];
        
        if (completionBlock)
        {
            completionBlock(YES, error);
        }
        
        
    }];
    [dataTask resume];
    
}

-(void)parseJSONObject:(NSDictionary *)jsonObject
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    //get the list of posts (top most level of the JSON object)
    items = jsonObject[@"posts"];
    
    //int count = 0;
    //get each posts attributes, each post is stored in a dictionary
    for (NSDictionary *post in items) {
        JJVStoryItem *storyItem = [[JJVStoryItem alloc] init];
        
        //storyItem.position = count++;
        
        storyItem.url = post[@"url"];
        storyItem.title = post[@"title_plain"];
        storyItem.contents = post[@"content"];
        storyItem.excerpt = post[@"excerpt"];
        //storyItem.date = post[DATE_CONSTANT2];
        
        //these fields are in their own seperate dictionaries
        NSDictionary *innerDictionary = post[@"author"];
        storyItem.author = innerDictionary[@"name"];
        
        innerDictionary = post[@"custom_fields"];
        NSArray *customFieldsArray = innerDictionary[@"image"];
        //image url is inside of an array inside of a dictionary
        storyItem.imageUrl = customFieldsArray[0];
        
        //add to our store
        [[JJVStoryItemStore sharedStore] addItem: storyItem];
        
    }
    
}

@end