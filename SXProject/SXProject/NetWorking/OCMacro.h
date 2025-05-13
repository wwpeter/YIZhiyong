//
//  OCMacro.h
//  SXProject
//
//  Created by 王威 on 2024/4/18.
//

#ifndef OCMacro_h
#define OCMacro_h

#define kStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]) || ([(_ref) isEqual:@"<null>"])|| ([(_ref) isEqual:@"(null)"]))


#endif /* OCMacro_h */
