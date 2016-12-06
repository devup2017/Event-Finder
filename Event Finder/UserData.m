//
//  UserData.m
//  Event Finder
//
//  Created by Adrian on 9/29/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import "UserData.h"
#import "AppDelegate.h"
@implementation UserData

-(void)createDictionary:(NSString *)key value:(NSString *)value{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:value forKey:key];
    [self addObjectToDictionary:dic];
}



-(void)addObjectToDictionary:(NSDictionary *)dictionary{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"user"]){
        NSDictionary *deepCopy = [[NSDictionary alloc] initWithDictionary: [[NSUserDefaults standardUserDefaults]objectForKey:@"user"] copyItems: YES];
        if (deepCopy) {
            [dic addEntriesFromDictionary: deepCopy];
        }
    }
    [dic addEntriesFromDictionary:dictionary];
    
    NSLog(@"%@", dic);
    [self save:dic];
}

-(void)save:(NSMutableDictionary *)dic{
    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"user"];
}

@end
