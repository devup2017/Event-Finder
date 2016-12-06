//
//  UserData.h
//  Event Finder
//
//  Created by Adrian on 9/29/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

-(void)createDictionary:(NSString *)key value:(NSString *)value;
-(void)addObjectToDictionary:(NSDictionary *)dictionary;
-(void)save:(NSMutableDictionary *)dic;

@end
