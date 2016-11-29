//
//  UIDevice+Software.m
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

#import "UIDevice+Software.h"

@import Darwin.POSIX.sys.stat;
@import Darwin.POSIX.pwd;
@import Darwin.POSIX.grp;
#import <sys/types.h>
#import <sys/sysctl.h>
#import <sys/utsname.h>

#import <mach/mach.h>

#import "UIDevice+Software.h"

@implementation UIDevice (Software)

- (BOOL)alpha_isJailbroken
{
    return [self alpha_jailbreakStatus] != UIDeviceJailbreakStatusNotJailbroken;
}

- (UIDeviceJailbreakStatus)alpha_jailbreakStatus
{
#if !TARGET_IPHONE_SIMULATOR
    
    //
    // Check if the application can open Cydia
    //
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        return UIDeviceJailbreakStatusCydia;
    }
    
    BOOL isDirectory;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Cyd", @"ia.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"bla", @"ckra1n.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Fake", @"Carrier.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Ic", @"y.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Inte", @"lliScreen.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"MxT", @"ube.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Roc", @"kApp.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"SBSet", @"ttings.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Wint", @"erBoard.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/l", @"ib/a", @"pt/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/l", @"ib/c", @"ydia/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/mobile", @"Library/SBSettings", @"Themes/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/t", @"mp/cyd", @"ia.log"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/s", @"tash/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/cy", @"dia/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"us", @"r/b",@"in", @"s", @"shd"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"us", @"r/sb",@"in", @"s", @"shd"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/cy", @"dia/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/sftp-", @"server"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@",@"/Syste",@"tem/Lib",@"rary/Lau",@"nchDae",@"mons/com.ike",@"y.bbot.plist"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@%@",@"/Sy",@"stem/Lib",@"rary/Laun",@"chDae",@"mons/com.saur",@"ik.Cy",@"@dia.Star",@"tup.plist"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"/Libr",@"ary/Mo",@"bileSubstra",@"te/MobileSubs",@"trate.dylib"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"/va",@"r/c",@"ach",@"e/a",@"pt/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"/va",@"r/l",@"ib",@"/apt/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"/va",@"r/l",@"ib/c",@"ydia/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"/va",@"r/l",@"og/s",@"yslog"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/bi",@"n/b",@"ash"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/b",@"in/",@"sh"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/et",@"c/a",@"pt/"]isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/etc/s",@"sh/s",@"shd_config"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"/us",@"r/li",@"bexe",@"c/ssh-k",@"eysign"]]) {
        return UIDeviceJailbreakStatusPathExists;
    }
    
    /*
     //
     // For check
     //
     int pid = fork();
     
     if (!pid)
     {
     exit(0);
     }
     
     if (pid >= 0)
     {
     return UIDeviceJailbreakStatusSandboxWrite;
     }
     */
    
    //
    // Symbolic link verification
    //
    struct stat s;
    
    if (lstat("/Applications", &s) || lstat("/var/stash/Library/Ringstones", &s) || lstat("/var/stash/Library/Wallpaper", &s)
        || lstat("/var/stash/usr/include", &s) || lstat("/var/stash/usr/libexec", &s)  || lstat("/var/stash/usr/share", &s) || lstat("/var/stash/usr/arm-apple-darwin9", &s)) {
        if (s.st_mode & S_IFLNK) {
            return UIDeviceJailbreakStatusSymbolicLinkVerification;
        }
    }
    
    //
    // Try to write file in private
    //
    NSError *error;
    
    [[NSString stringWithFormat:@"Jailbreak test string"] writeToFile:@"/private/test_jb.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (nil == error) {
        return UIDeviceJailbreakStatusPrivateWrite;
    }
    else {
        [[NSFileManager defaultManager] removeItemAtPath:@"/private/test_jb.txt" error:nil];
    }
    
    FILE *file = fopen("/bin/ssh", "r");
    
    if (file) {
        return UIDeviceJailbreakStatusShellExists;
    }
    
#endif
    return UIDeviceJailbreakStatusNotJailbroken;
}

- (NSDate *)alpha_systemBootDate {
    const int MIB_SIZE = 2;
    
    int mib[MIB_SIZE];
    size_t size;
    struct timeval  boottime;
    
    mib[0] = CTL_KERN;
    mib[1] = KERN_BOOTTIME;
    size = sizeof(boottime);
    
    if (sysctl(mib, MIB_SIZE, &boottime, &size, NULL, 0) != -1) {
        NSDate* bootDate = [NSDate dateWithTimeIntervalSince1970:boottime.tv_sec + boottime.tv_usec / 1.e6];
        
        return bootDate;
    }
    
    return nil;
}

- (NSUInteger)alpha_processCount {
    return [self alpha_processList].count;
}

- (NSArray *)alpha_processList {
    
    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
    u_int miblen = 4;
    
    size_t size;
    int st = sysctl(mib, miblen, NULL, &size, NULL, 0);
    
    struct kinfo_proc * process = NULL;
    struct kinfo_proc * newprocess = NULL;
    
    do {
        
        size += size / 10;
        newprocess = realloc(process, size);
        
        if (!newprocess) {
            if (process) {
                free(process);
            }
            
            return nil;
        }
        
        process = newprocess;
        st = sysctl(mib, miblen, process, &size, NULL, 0);
        
    } while (st == -1 && errno == ENOMEM);
    
    if (st == 0) {
        if (size % sizeof(struct kinfo_proc) == 0) {
            size_t nprocess = size / sizeof(struct kinfo_proc);
            
            if (nprocess) {
                
                NSMutableArray * array = [[NSMutableArray alloc] init];
                
                for (int i = (int)nprocess - 1; i >= 0; i--) {
                    
                    NSString * processID = [NSString stringWithFormat:@"%d", process[i].kp_proc.p_pid];
                    NSString * processName = [NSString stringWithFormat:@"%s", process[i].kp_proc.p_comm];
                    
                    NSString *processPriority = [NSString stringWithFormat:@"%d", process[i].kp_proc.p_priority];
                    
                    NSString * ruid = [NSString stringWithFormat:@"%d", process[i].kp_eproc.e_pcred.p_ruid];
                    NSString * rgid = [NSString stringWithFormat:@"%d", process[i].kp_eproc.e_pcred.p_rgid];
                    
                    NSString * svgid = [NSString stringWithFormat:@"%d", process[i].kp_eproc.e_pcred.p_svgid];
                    
                    NSString * svuid = [NSString stringWithFormat:@"%d", process[i].kp_eproc.e_ucred.cr_uid];
                    
                    //
                    // Start time
                    //
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
                    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
                    
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:process[i].kp_proc.p_un.__p_starttime.tv_sec];
                    
                    NSTimeInterval timeIntervalSinceStart = [date timeIntervalSinceNow] * -1 * 1000;
                    NSString *stringTimeInterval = [NSString stringWithFormat:@"%.0f", timeIntervalSinceStart];
                    
                    //
                    // This causes crash on simulator
                    //
                    
#if !(TARGET_IPHONE_SIMULATOR)
                    
                    struct passwd* pwd = getpwuid(process[i].kp_eproc.e_pcred.p_ruid);
                    NSString *u = [NSString stringWithFormat:@"%s", pwd->pw_name];
                    
                    
                    struct group* gwd = getgrgid(process[i].kp_eproc.e_pcred.p_rgid);
                    NSString *g = [NSString stringWithFormat:@"%s", gwd->gr_name];
                    
#else
                    NSString *u = @"simulator";
                    NSString *g = @"simulator";
#endif
                    
                    NSDictionary *dict = @{@"pid" : processID,
                                           @"name" : processName,
                                           @"priority" : processPriority,
                                           @"ruid" : ruid,
                                           @"rgid" : rgid,
                                           @"svgid" : svgid,
                                           @"svuid" : svuid,
                                           @"uname" : u,
                                           @"gname" : g,
                                           @"IntervalSinceStart" : stringTimeInterval
                                           };
                    
                    [array addObject:dict];
                }
                
                free(process);
                return array;
            }
        }
    }
    
    free(process);
    return nil;
}

- (float)alpha_cpuUsage {
    processor_info_array_t _cpuInfo, _prevCPUInfo = nil;
    mach_msg_type_number_t _numCPUInfo, _numPrevCPUInfo = 0;
    unsigned _numCPUs;
    NSLock *_cpuUsageLock;
    
    int _mib[2U] = { CTL_HW, HW_NCPU };
    size_t _sizeOfNumCPUs = sizeof(_numCPUs);
    int _status = sysctl(_mib, 2U, &_numCPUs, &_sizeOfNumCPUs, NULL, 0U);
    
    if (_status)
    {
        _numCPUs = 1;
    }
    
    _cpuUsageLock = [[NSLock alloc] init];
    
    natural_t _numCPUsU = 0U;
    kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &_numCPUsU, &_cpuInfo, &_numCPUInfo);
    
    Float32 inUse = 0.0;
    Float32 total = 0.0;
    
    if (err == KERN_SUCCESS) {
        [_cpuUsageLock lock];
        
        for (unsigned i = 0U; i < _numCPUs; i++) {
            Float32 _inUse, _total;
            
            if (_prevCPUInfo) {
                _inUse = (
                          (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                          );
                _total = _inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
            }
            else {
                _inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                _total = _inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
            }
            
            inUse += _inUse;
            total += _total;
            
            //NSLog(@"Core : %u, Usage: %.2f%%", i, _inUse / _total * 100.f);
        }
        
        [_cpuUsageLock unlock];
        
        if (_prevCPUInfo) {
            size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCPUInfo;
            vm_deallocate(mach_task_self(), (vm_address_t)_prevCPUInfo, prevCpuInfoSize);
        }
        
        _prevCPUInfo = _cpuInfo;
        _numPrevCPUInfo = _numCPUInfo;
        
        _cpuInfo = nil;
        _numCPUInfo = 0U;
    }
    
    return total > 0.0 ? (inUse / total) : 0.0;
}

@end
