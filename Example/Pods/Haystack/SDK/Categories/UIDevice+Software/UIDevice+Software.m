//
//  UIDevice+Software.m
//

#include <sys/types.h>
#include <sys/sysctl.h>
#import <mach/mach.h>

#import "UIDevice+Software.h"

@implementation UIDevice (Software)

- (NSUInteger)hs_processCount
{
    return [self hs_processList].count;
}

- (NSArray *)hs_processList
{
    
    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
    u_int miblen = 4;
    
    size_t size;
    int st = sysctl(mib, miblen, NULL, &size, NULL, 0);
    
    struct kinfo_proc * process = NULL;
    struct kinfo_proc * newprocess = NULL;
    
    do
    {
        size += size / 10;
        newprocess = realloc(process, size);
        
        if (!newprocess){
            
            if (process){
                free(process);
            }
            
            return nil;
        }
        
        process = newprocess;
        st = sysctl(mib, miblen, process, &size, NULL, 0);
    }
    while (st == -1 && errno == ENOMEM);
    
    if (st == 0)
    {
        if (size % sizeof(struct kinfo_proc) == 0)
        {
            int nprocess = (int)(size / sizeof(struct kinfo_proc));
            
            if (nprocess)
            {
                NSMutableArray * array = [[NSMutableArray alloc] init];
                
                for (int i = nprocess - 1; i >= 0; i--)
                {
                    
                    NSString *processID = [[NSString alloc] initWithFormat:@"%d", process[i].kp_proc.p_pid];
                    NSString *processName = [[NSString alloc] initWithFormat:@"%s", process[i].kp_proc.p_comm];
                    
                    NSDictionary * dict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:processID, processName, nil] forKeys:[NSArray arrayWithObjects:@"ProcessID", @"ProcessName", nil]];

                    [array addObject:dict];
                }
                
                free(process);
                return array;
            }
        }
    }
    
    return nil;
}

- (float)hs_cpuUsage
{
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
    
    if (err == KERN_SUCCESS)
    {
        [_cpuUsageLock lock];
        
        for (unsigned i = 0U; i < _numCPUs; i++)
        {
            Float32 _inUse, _total;
            
            if (_prevCPUInfo)
            {
                _inUse = (
                          (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                          );
                _total = _inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
            }
            else
            {
                _inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                _total = _inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
            }
            
            inUse += _inUse;
            total += _total;
            
            //NSLog(@"Core : %u, Usage: %.2f%%", i, _inUse / _total * 100.f);
        }
        
        [_cpuUsageLock unlock];
        
        if (_prevCPUInfo)
        {
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
