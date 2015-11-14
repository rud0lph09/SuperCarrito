//
//  requests.m
//  request
//
//  Created by Sergio Albarrán on 14/11/15.
//  Copyright © 2015 Sergio Albarrán. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "requests.h"


@implementation request


- (NSString *) getCall: (NSString * ) str
{
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableString *urlCp = [[NSMutableString alloc] initWithFormat:@"http://10.49.86.154:8080/v1/productos/%@", str];
    
    [[session dataTaskWithURL:[NSURL URLWithString:urlCp]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                // handle response
                NSLog(@"request: %@", urlCp);
                NSLog(@"requestReply: %@", response);
                
            }] resume];
    
    NSURL *url = [NSURL URLWithString:urlCp];
    NSError* error;
    NSString *content = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    NSLog(@"requestReply: %@", content);
    return content;
}

- (void) postMethod: (id) sender
{
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:@"http://10.49.86.154:8080/v1/productos"]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                // handle response
                NSLog(@"requestReply: %@", response);
            }] resume];
    
    NSURL *url = [NSURL URLWithString:@"http://10.49.86.154:8080/v1/productos"];
    NSError* error;
    NSString *content = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    NSLog(@"requestReply: %@", content);
}


@end
