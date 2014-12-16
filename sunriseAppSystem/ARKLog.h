//
//  ARKLog.h
//  sunriseFourAlarm
//
//  Created by Nicholas Piano on 14/11/2013.
//  Copyright (c) 2013 Nicholas Piano. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ARKLog(args...) ExtendNSLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);
