//
//  some.m
//  SuperCarrito
//
//  Created by Rodolfo Castillo on 14/11/15.
//  Copyright © 2015 Rodolfo Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface some: NSObject
{
    NSString *firstName;
    NSString *lastName;
}

-(void) setFName:(NSString *) theFirstName;
-(void) setLName:(NSString *) theLastName;



@end
@implementation some : NSObject
// { is not required
-(void) setFName:(NSString *) theFirstName {
    // code
}

-(void) setLName:(NSString *) theLastName {
    
}

// in this way

// } is not required
@end