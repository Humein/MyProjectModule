//
//  DBAbstractItem+JoinSql.m
//  DBProject
//
//  Created by Zhang Xin Xin on 2019/3/27.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "DBAbstractItem+JoinSql.h"

@implementation DBAbstractItem (JoinSql)

+ (NSString*)joinPropertyNameTypeToCreateTable
{
    NSMutableArray *stringArray= [NSMutableArray new];
    
    NSArray *propertyNameArray= [self  requireProperties];
    
    NSArray *propertyTypeArray= [self requirePropertTypes];
    
    NSString *primaryKey = [self primaryKey];
    
    int i =0 ;
    
    for (NSString *propertyName in propertyNameArray) {
        
        NSString *rowString = nil;
        
        NSNumber *type= propertyTypeArray[i];
        
        if ([propertyName isEqualToString:primaryKey]) {
            
            rowString = [self propertyName:propertyName type:type isPromaryKey:YES];
        }else{
            rowString =[self propertyName:propertyName type:type isPromaryKey:NO];
        }
        
        [stringArray addObject:rowString];
        
        i++;
    }
    return [stringArray componentsJoinedByString:@","];
}


- (NSString*)joinPropertyName
{
    NSArray *propertyNameArray=[[self class] requireProperties];
    return [propertyNameArray componentsJoinedByString:@","];
}

- (NSString*)joinPropertyValue
{
    NSMutableArray *valueArray = [NSMutableArray new];
    NSArray *propertyNameArray=[[self class] requireProperties];
    NSArray *propertyTypeArray = [[self class] requirePropertTypes];
    int i = 0;
    for (NSString *propertyName in propertyNameArray) {
        id value=[self valueForKey:propertyName];
        NSNumber *type= [propertyTypeArray objectAtIndex:i];
        if (type.integerValue == 2) {
            value=[NSString stringWithFormat:@"'%@'",value];
        }
        [valueArray addObject:value];
        i++;
    }
    return [valueArray componentsJoinedByString:@","];
}


//拼接一个属性的数组
- (NSString*)joinPropertyNameArray:(NSArray*)propertyNameArray
{
    return [propertyNameArray componentsJoinedByString:@","];
}

//拼接一个值的数组
- (NSString*)joinPropertyValueArrayFromPropertyNameArray:(NSArray*)propertyNameArray
{
    NSMutableArray *valueArray = [NSMutableArray new];
    NSDictionary *propertyTypeDict = [[self class] propertyNamesWithTypes];
    int i = 0;
    for (NSString *propertyName in propertyNameArray) {
        id value=[self valueForKey:propertyName];
        
        NSNumber *type= [propertyTypeDict objectForKey:propertyName];
        if (type.integerValue == 2) {
            value=[NSString stringWithFormat:@"'%@'",value];
        }
        [valueArray addObject:value];
        i++;
    }
    return [valueArray componentsJoinedByString:@","];
}

//拼接key和value的处理
- (NSString*)joinKeyAndValue:(NSArray*)propertyNameArray
{
    NSMutableArray *keyValueArray = [NSMutableArray new];
    
    NSDictionary *propertyTypeDict = [[self class] propertyNamesWithTypes];
    
    int i =0 ;
    for (NSString *propertyName in propertyNameArray) {
        
        id value=[self valueForKey:propertyName];
        NSNumber *type= [propertyTypeDict objectForKey:propertyName];
        if (type.integerValue == 2) {
            value=[NSString stringWithFormat:@"'%@'",value];
        }
        
        [keyValueArray addObject:[NSString stringWithFormat:@"%@ = %@",propertyName,value]];
        i++;
    }
    
    return [keyValueArray componentsJoinedByString:@","];
    
}


- (NSString*)whereKeyToValue
{
    NSDictionary *dict = [[self class] propertyNamesWithTypes];
    
    NSString *primaryKey =[[self class] primaryKey];
    
    NSString *value = nil;
    
    NSNumber *typeNum = [dict objectForKey:primaryKey];
    
    if (typeNum.integerValue == 2) {
        
        value = [NSString stringWithFormat:@"'%@'",[self valueForKey:primaryKey]];
    }else{
        value = [self valueForKey:primaryKey];
    }
    NSString *keyToValueString = [NSString stringWithFormat:@"%@=%@",primaryKey,value];
    
    return keyToValueString;
}


+ (NSString*)propertyName:(NSString*)propertyName type:(NSNumber*)type isPromaryKey:(BOOL)is
{
    NSString *tempString = nil;
    if (is) {
        switch (type.integerValue) {
            case 0:
                tempString = [NSString stringWithFormat:@"%@ INTEGER PRIMARY KEY DEFAULT 0 ",propertyName];
                break;
            case 1:
                tempString = [NSString stringWithFormat:@"%@ REAL PRIMARY KEY DEFAULT 0.0 ",propertyName];
                break;
            case 2:
                tempString = [NSString stringWithFormat:@"%@ TEXT PRIMARY KEY DEFAULT 'no value'",propertyName];
                break;
            default:
                break;
        }
        
    }else{
        switch (type.integerValue) {
            case 0:
                tempString = [NSString stringWithFormat:@"%@ INTEGER DEFAULT 0",propertyName];
                break;
            case 1:
                tempString = [NSString stringWithFormat:@"%@ REAL DEFAULT 0.0",propertyName];
                break;
            case 2:
                tempString = [NSString stringWithFormat:@"%@ TEXT DEFAULT 'no value'",propertyName];
                break;
            default:
                break;
        }
    }
    return tempString;
}

@end
