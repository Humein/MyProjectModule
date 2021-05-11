//
//  MatrixHandleManager.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2021/2/7.
//  Copyright © 2021 xinxin. All rights reserved.
//

#import "MatrixHandleManager.h"
#import <Matrix/Matrix.h>
#import "WCBlockTypeDef.h"
#import "AppDelegate.h"

void kscrash_crashCallback(const KSCrashReportWriter *writer)
{
    writer->beginObject(writer, "WeChat");
    writer->addUIntegerElement(writer, "uin", 21002);
    writer->endContainer(writer);
}

@interface MatrixHandleManager ()<MatrixPluginListenerDelegate,WCCrashBlockMonitorDelegate,MatrixAdapterDelegate> {
    WCCrashBlockMonitorPlugin *m_cbPlugin;
    WCMemoryStatPlugin *m_msPlugin;
}

@end

@implementation MatrixHandleManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self installMatrix];
    }
    return self;
}

//MARK: - init matix
- (void)installMatrix {
    /*
     程序 main 函数入口；
     AppDelegate 中的 application:didFinishLaunchingWithOptions:；
     */

    // Get Matrix's log
    [MatrixAdapter sharedInstance].delegate = self;
    Matrix *matrix = [Matrix sharedInstance];
    MatrixBuilder *curBuilder = [[MatrixBuilder alloc] init];
    curBuilder.pluginListener = self; // pluginListener 回调 plugin 的相关事件
        
    
    //  崩溃卡顿 配置
    WCCrashBlockMonitorConfig *crashBlockConfig = [[WCCrashBlockMonitorConfig alloc] init];
    crashBlockConfig.enableCrash = YES;
    crashBlockConfig.enableBlockMonitor = YES;
    crashBlockConfig.blockMonitorDelegate = self;
    crashBlockConfig.onAppendAdditionalInfoCallBack = kscrash_crashCallback;
    crashBlockConfig.reportStrategy = EWCCrashBlockReportStrategy_All;
    
    WCBlockMonitorConfiguration *blockMonitorConfig = [WCBlockMonitorConfiguration defaultConfig];
    blockMonitorConfig.bMainThreadHandle = YES;
    blockMonitorConfig.bFilterSameStack = YES;
    blockMonitorConfig.triggerToBeFilteredCount = 10;
    blockMonitorConfig.bGetCPUHighLog = NO;
    blockMonitorConfig.bGetPowerConsumeStack = YES;
    
    crashBlockConfig.blockMonitorConfiguration = blockMonitorConfig;

    
    // 添加卡顿和崩溃监控
    WCCrashBlockMonitorPlugin *crashBlockPlugin = [[WCCrashBlockMonitorPlugin alloc] init];
    crashBlockPlugin.pluginConfig = crashBlockConfig;
    [curBuilder addPlugin:crashBlockPlugin];
        
    // 添加内存监控功能
    WCMemoryStatPlugin *memoryStatPlugin = [[WCMemoryStatPlugin alloc] init];
    memoryStatPlugin.pluginConfig = [WCMemoryStatConfig defaultConfiguration];
    [curBuilder addPlugin:memoryStatPlugin];
    
    
    [matrix addMatrixBuilder:curBuilder];
    
    // 开启卡顿和崩溃监控
    [crashBlockPlugin start];
    // 开启内存监控，注意 memoryStatPlugin 开启之后对性能损耗较大，建议按需开启
    [memoryStatPlugin start];
    
    m_cbPlugin = crashBlockPlugin;
    m_msPlugin = memoryStatPlugin;
}

- (WCCrashBlockMonitorPlugin *)getCrashBlockPlugin;
{
    return m_cbPlugin;
}

- (WCMemoryStatPlugin *)getMemoryStatPlugin
{
    return m_msPlugin;
}


//MARK: - 接收回调获得监控数据
#pragma mark - MatrixPluginListenerDelegate
- (void)onReportIssue:(MatrixIssue *)issue
{
    NSLog(@"get issue: %@", issue);
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    TextViewController *textVC = nil;
    
    NSString *currentTilte = @"unknown";
    
    if ([issue.issueTag isEqualToString:[WCCrashBlockMonitorPlugin getTag]]) {
        if (issue.reportType == EMCrashBlockReportType_Lag) {
            NSMutableString *lagTitle = [@"Lag" mutableCopy];
            if (issue.customInfo != nil) {
                NSString *dumpTypeDes = @"";
                NSNumber *dumpType = [issue.customInfo objectForKey:@g_crash_block_monitor_custom_dump_type];
                EDumpType type = [dumpType integerValue];
                switch (type) {
                    case EDumpType_MainThreadBlock:
                        dumpTypeDes = @"Foreground Main Thread Block";
                        break;
                    case EDumpType_BackgroundMainThreadBlock:
                        dumpTypeDes = @"Background Main Thread Block";
                        break;
                    case EDumpType_CPUBlock:
                        dumpTypeDes = @"CPU Too High";
                        break;
                    case EDumpType_PowerConsume:
                        dumpTypeDes = @"Power Consume";
                        break;
                    case EDumpType_LaunchBlock:
                        dumpTypeDes = @"Launching Main Thread Block";
                        break;
                    case EDumpType_BlockThreadTooMuch:
                        dumpTypeDes = @"Block And Thread Too Much";
                        break;
                    case EDumpType_BlockAndBeKilled:
                        dumpTypeDes = @"Main Thread Block Before Be Killed";
                        break;
                    default:
                        dumpTypeDes = [NSString stringWithFormat:@"%d", [dumpType intValue]];
                        break;
                }
                [lagTitle appendFormat:@" [%@]", dumpTypeDes];
            }
            currentTilte = [lagTitle copy];
        }
        if (issue.reportType == EMCrashBlockReportType_Crash) {
            currentTilte = @"Crash";
        }
    }
    
    if ([issue.issueTag isEqualToString:[WCMemoryStatPlugin getTag]]) {
        currentTilte = @"OOM Info";
    }
    
    if (issue.dataType == EMatrixIssueDataType_Data) {
        NSString *dataString = [[NSString alloc] initWithData:issue.issueData encoding:NSUTF8StringEncoding];
//        textVC = [[TextViewController alloc] initWithString:dataString withTitle:currentTilte];
    } else {
//        textVC = [[TextViewController alloc] initWithFilePath:issue.filePath withTitle:currentTilte];
    }
//    [appDelegate.navigationController pushViewController:textVC animated:YES];
    
    [[Matrix sharedInstance] reportIssueComplete:issue success:YES];
}

#pragma mark - WCCrashBlockMonitorDelegate
- (void)onCrashBlockMonitorBeginDump:(EDumpType)dumpType blockTime:(uint64_t)blockTime
{
    
}

- (void)onCrashBlockMonitorEnterNextCheckWithDumpType:(EDumpType)dumpType
{
    if (dumpType != EDumpType_MainThreadBlock || dumpType != EDumpType_BackgroundMainThreadBlock) {
    }
}

- (void)onCrashBlockMonitorDumpType:(EDumpType)dumpType filter:(EFilterType)filterType
{
    NSLog(@"filtered dump type:%u, filter type: %u", (uint32_t)dumpType, (uint32_t)filterType);
}

- (void)onCrashBlockMonitorDumpFilter:(EDumpType)dumpType
{
    
}

- (NSDictionary *)onCrashBlockGetUserInfoForFPSWithDumpType:(EDumpType)dumpType
{
    return nil;
}

#pragma mark - MatrixAdapterDelegate

- (BOOL)matrixShouldLog:(MXLogLevel)level
{
    return YES;
}

- (void)matrixLog:(MXLogLevel)logLevel
           module:(const char *)module
             file:(const char *)file
             line:(int)line
         funcName:(const char *)funcName
          message:(NSString *)message
{
    NSLog(@"%@:%@:%@:%@",
          [NSString stringWithUTF8String:module],[NSString stringWithUTF8String:file],[NSString stringWithUTF8String:funcName], message);
}

@end
