//
//  ManWuAddressManagerMaroc.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-13.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#ifndef basicFoundation_ManWuAddressManagerMaroc_h
#define basicFoundation_ManWuAddressManagerMaroc_h

#define kAddressManagerSuccessBlock         @"AddressManagerSuccessBlock"
#define kAddressManagerFailureBlock         @"AddressManagerFailureBlock"

#define kAddressSelectedSuccessBlock        @"AddressSelectedSuccessBlock"
#define kAddressSelectedFailureBlock        @"AddressSelectedFailureBlock"

#define kAddressModelKey                    @"addressModel"

typedef void(^addressDidChangeBlock) (BOOL addressDidChange,WeAppComponentBaseItem* addressComponentItem);

typedef void (^successWrapper)(WeAppComponentBaseItem *addressModel);
typedef void (^failureWrapper)();

#endif
