//
//  EZCacheManager.m
//  EZKit
//
//  Created by Ezreal on 16/5/8.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "EZCacheManager.h"
#import "EZDeviceManager.h"
#import "FMDB.h"
#import <CommonCrypto/CommonDigest.h>

#define kDefaultDBName @"EZCache.sqlite"

/// String's md5 hash.
static NSString *_EZNSStringMD5(NSString *string) {
    if (!string) return nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],  result[1],  result[2],  result[3],
            result[4],  result[5],  result[6],  result[7],
            result[8],  result[9],  result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@interface EZCacheManager ()
{
    FMDatabase *_db;
    NSTimer *timer;
}

@property(nonatomic,strong)NSString *dbPath;

@end

@implementation EZCacheManager
DEF_SINGLETON(EZCacheManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createDatabase];
        self.cacheTime = 0;
    }
    return self;
}

-(BOOL)createDatabase
{
    self.dbPath = [EZSharedDevice.strPathDoc stringByAppendingString:[NSString stringWithFormat:@"/%@",kDefaultDBName]];
    
    _db = [FMDatabase databaseWithPath:self.dbPath];
    NSString *trigger = @"CREATE TRIGGER IF NOT EXISTS EZCacheTrigger AFTER UPDATE OF data ON EZ_Cache FOR EACH ROW  BEGIN update EZ_Cache set write_time = datetime('now','localtime') where secret_key = new.secret_key; END";
    NSString *sql = @"CREATE TABLE IF NOT EXISTS EZ_Cache(secret_key CHAR(32) PRIMARY KEY NOT NULL,data NTEXT NOT NULL,write_time TimeStamp NOT NULL DEFAULT (datetime('now','localtime')));";
    [_db open];
    
    [_db setLogsErrors:YES];
    [_db executeUpdate:@"PRAGMA CACHE_SIZE=1000"];
    [_db executeUpdate:@"PRAGMA encoding = \"UTF-8\""];
    [_db executeUpdate:@"PRAGMA auto_vacuum=1"];
    [_db executeUpdate:@"PRAGMA synchronous= OFF"];
    
    [_db executeUpdate:sql];//创建缓存表
    
    [_db executeUpdate:trigger];//创建触发器 用来记录数据更新时间
    
    return YES;
}

-(BOOL)ez_isHasKey:(NSString *)key
{
    NSString *strSQL = [NSString stringWithFormat:@"SELECT secret_key FROM EZ_Cache WHERE secret_key = '%@'",key];
    FMResultSet *set = [_db executeQuery:strSQL];
    if ([set next]) {
        [set close];
        return YES;
    }
    return NO;
}

-(BOOL)ez_insertKey:(NSString *)key value:(NSString *)value
{
    NSString *strSQL = [NSString stringWithFormat:@"INSERT INTO EZ_Cache (secret_key,data) VALUES('%@','%@')",key,value];
    return [_db executeUpdate:strSQL];
}

-(BOOL)ez_updateKey:(NSString *)key value:(NSString *)value
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE EZ_Cache SET data = '%@' WHERE secret_key = '%@';",value,key];
    return [_db executeUpdate:strSQL];
}

-(BOOL)ez_saveCacheByKey:(NSString *)key value:(NSString *)value
{
    if (key != nil && value != nil)
    {
        NSString *secret_key = _EZNSStringMD5(key);
        if ([self ez_isHasKey:secret_key]) {
            if ([self ez_updateKey:secret_key value:value]) {
                NSLog(@"更新成功");
            }else{
                NSLog(@"更新失败");
            }
        }else{
            if ([self ez_insertKey:secret_key value:value]) {
                NSLog(@"插入成功");
            }else{
                NSLog(@"插入失败");
            }
        }
        return YES;
    }
    else
    {
        return NO;
    }

}

-(NSString *)ez_valueByKey:(NSString *)key
{
    NSString *secret_key = _EZNSStringMD5(key);
    if ([self ez_isHasKey:secret_key])
    {
        NSString *strSQL = [NSString stringWithFormat:@"SELECT data from EZ_Cache WHERE secret_key = '%@'",secret_key];
        FMResultSet *set = [_db executeQuery:strSQL];
        if (set.next)
        {
            return [set objectForColumnName:@"data"];
        }
        else
        {
            return nil;
        }
    }
    else
    {
        return nil;
    }
}

-(BOOL)ez_clearAllCache
{
    NSString *strSQL = @"Delete from EZ_Cache";
    return [_db executeUpdate:strSQL];
}

-(BOOL)ez_clearCacheByKey:(NSString *)key
{
    NSString *strSQL = @"";
    return [_db executeUpdate:strSQL];
}

-(long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize] - 16384;
    }
    return 0;
}

-(CGFloat)cacheSize
{
    return  [self fileSizeAtPath:self.dbPath];
}

-(void)dealloc
{
    [_db close];
}

@end
