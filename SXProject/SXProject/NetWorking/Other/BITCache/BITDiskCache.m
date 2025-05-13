#import "BITDiskCache.h"
#import "BITCacheBackgroundTaskManager.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_4_0
#import <UIKit/UIKit.h>
#endif

#define BITDiskCacheError(error) if (error) { NSLog(@"%@ (%d) ERROR: %@", \
                                    [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
                                    __LINE__, [error localizedDescription]); }

static id <BITCacheBackgroundTaskManager> BITCacheBackgroundTaskManager;

NSString * const BITDiskCachePrefix = @"com.tumblr.BITDiskCache";
NSString * const BITDiskCacheSharedName = @"BITDiskCacheShared";

@interface BITDiskCache ()
@property (assign) NSUInteger byteCount;
@property (strong, nonatomic) NSURL *cacheURL;
@property (assign, nonatomic) dispatch_queue_t queue;
@property (strong, nonatomic) NSMutableDictionary *dates;
@property (strong, nonatomic) NSMutableDictionary *sizes;
@end

@implementation BITDiskCache

@synthesize willAddObjectBlock = _willAddObjectBlock;
@synthesize willRemoveObjectBlock = _willRemoveObjectBlock;
@synthesize willRemoveAllObjectsBlock = _willRemoveAllObjectsBlock;
@synthesize didAddObjectBlock = _didAddObjectBlock;
@synthesize didRemoveObjectBlock = _didRemoveObjectBlock;
@synthesize didRemoveAllObjectsBlock = _didRemoveAllObjectsBlock;
@synthesize byteLimit = _byteLimit;
@synthesize ageLimit = _ageLimit;

#pragma mark - Initialization -

- (instancetype)initWithName:(NSString *)name
{
    return [self initWithName:name rootPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
}

- (instancetype)initWithName:(NSString *)name rootPath:(NSString *)rootPath
{
    if (!name)
        return nil;

    if (self = [super init]) {
        _name = [name copy];
        _queue = [BITDiskCache sharedQueue];

        _willAddObjectBlock = nil;
        _willRemoveObjectBlock = nil;
        _willRemoveAllObjectsBlock = nil;
        _didAddObjectBlock = nil;
        _didRemoveObjectBlock = nil;
        _didRemoveAllObjectsBlock = nil;
        
        _byteCount = 0;
        _byteLimit = 0;
        _ageLimit = 0.0;

        _dates = [[NSMutableDictionary alloc] init];
        _sizes = [[NSMutableDictionary alloc] init];

        NSString *pathComponent = [[NSString alloc] initWithFormat:@"%@.%@", BITDiskCachePrefix, _name];
        _cacheURL = [NSURL fileURLWithPathComponents:@[ rootPath, pathComponent ]];

        __weak BITDiskCache *weakSelf = self;

        dispatch_async(_queue, ^{
            BITDiskCache *strongSelf = weakSelf;
            [strongSelf createCacheDirectory];
            [strongSelf initializeDiskProperties];
        });
    }
    return self;
}

- (NSString *)description
{
    return [[NSString alloc] initWithFormat:@"%@.%@.%p", BITDiskCachePrefix, _name, self];
}

+ (instancetype)sharedCache
{
    static id cache;
    static dispatch_once_t predicate;

    dispatch_once(&predicate, ^{
        cache = [[self alloc] initWithName:BITDiskCacheSharedName];
    });

    return cache;
}

+ (dispatch_queue_t)sharedQueue
{
    static dispatch_queue_t queue;
    static dispatch_once_t predicate;

    dispatch_once(&predicate, ^{
        queue = dispatch_queue_create([BITDiskCachePrefix UTF8String], DISPATCH_QUEUE_SERIAL);
    });

    return queue;
}

#pragma mark - Private Methods -

- (NSURL *)encodedFileURLForKey:(NSString *)key
{
    if (![key length])
        return nil;

    return [_cacheURL URLByAppendingPathComponent:[self encodedString:key]];
}

- (NSString *)keyForEncodedFileURL:(NSURL *)url
{
    NSString *fileName = [url lastPathComponent];
    if (!fileName)
        return nil;

    return [self decodedString:fileName];
}

- (NSString *)encodedString:(NSString *)string
{
    if (![string length])
        return @"";

    CFStringRef static const charsToEscape = CFSTR(".:/");
    CFStringRef escapedString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (__bridge CFStringRef)string,
                                                                        NULL,
                                                                        charsToEscape,
                                                                        kCFStringEncodingUTF8);
    return (__bridge_transfer NSString *)escapedString;
}

- (NSString *)decodedString:(NSString *)string
{
    if (![string length])
        return @"";

    CFStringRef unescapedString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef)string,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    return (__bridge_transfer NSString *)unescapedString;
}

#pragma mark - Private Trash Methods -

+ (dispatch_queue_t)sharedTrashQueue
{
    static dispatch_queue_t trashQueue;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        NSString *queueName = [[NSString alloc] initWithFormat:@"%@.trash", BITDiskCachePrefix];
        trashQueue = dispatch_queue_create([queueName UTF8String], DISPATCH_QUEUE_SERIAL);
        dispatch_set_target_queue(trashQueue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0));
    });
    
    return trashQueue;
}

+ (NSURL *)sharedTrashURL
{
    static NSURL *sharedTrashURL;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedTrashURL = [[[NSURL alloc] initFileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:BITDiskCachePrefix isDirectory:YES];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:[sharedTrashURL path]]) {
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtURL:sharedTrashURL
                                     withIntermediateDirectories:YES
                                                      attributes:nil
                                                           error:&error];
            BITDiskCacheError(error);
        }
    });
    
    return sharedTrashURL;
}

+(BOOL)moveItemAtURLToTrash:(NSURL *)itemURL
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[itemURL path]])
        return NO;

    NSError *error = nil;
    NSString *uniqueString = [[NSProcessInfo processInfo] globallyUniqueString];
    NSURL *uniqueTrashURL = [[BITDiskCache sharedTrashURL] URLByAppendingPathComponent:uniqueString];
    BOOL moved = [[NSFileManager defaultManager] moveItemAtURL:itemURL toURL:uniqueTrashURL error:&error];
    BITDiskCacheError(error);
    return moved;
}

+ (void)emptyTrash
{
    UIBackgroundTaskIdentifier taskID = [BITCacheBackgroundTaskManager beginBackgroundTask];
    
    dispatch_async([self sharedTrashQueue], ^{        
        NSError *error = nil;
        NSArray *trashedItems = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:[self sharedTrashURL]
                                                              includingPropertiesForKeys:nil
                                                                                 options:0
                                                                                   error:&error];
        BITDiskCacheError(error);

        for (NSURL *trashedItemURL in trashedItems) {
            NSError *error = nil;
            [[NSFileManager defaultManager] removeItemAtURL:trashedItemURL error:&error];
            BITDiskCacheError(error);
        }
        
        [BITCacheBackgroundTaskManager endBackgroundTask:taskID];
    });
}

#pragma mark - Private Queue Methods -

- (BOOL)createCacheDirectory
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:[_cacheURL path]])
        return NO;

    NSError *error = nil;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtURL:_cacheURL
                                            withIntermediateDirectories:YES
                                                             attributes:nil
                                                                  error:&error];
    BITDiskCacheError(error);

    return success;
}

- (void)initializeDiskProperties
{
    NSUInteger byteCount = 0;
    NSArray *keys = @[ NSURLContentModificationDateKey, NSURLTotalFileAllocatedSizeKey ];

    NSError *error = nil;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:_cacheURL
                                                   includingPropertiesForKeys:keys
                                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                        error:&error];
    BITDiskCacheError(error);

    for (NSURL *fileURL in files) {
        NSString *key = [self keyForEncodedFileURL:fileURL];

        error = nil;
        NSDictionary *dictionary = [fileURL resourceValuesForKeys:keys error:&error];
        BITDiskCacheError(error);

        NSDate *date = [dictionary objectForKey:NSURLContentModificationDateKey];
        if (date && key)
            [_dates setObject:date forKey:key];

        NSNumber *fileSize = [dictionary objectForKey:NSURLTotalFileAllocatedSizeKey];
        if (fileSize) {
            [_sizes setObject:fileSize forKey:key];
            byteCount += [fileSize unsignedIntegerValue];
        }
    }

    if (byteCount > 0)
        self.byteCount = byteCount; // atomic
}

- (BOOL)setFileModificationDate:(NSDate *)date forURL:(NSURL *)fileURL
{
    if (!date || !fileURL) {
        return NO;
    }
    
    NSError *error = nil;
    BOOL success = [[NSFileManager defaultManager] setAttributes:@{ NSFileModificationDate: date }
                                                    ofItemAtPath:[fileURL path]
                                                           error:&error];
    BITDiskCacheError(error);

    if (success) {
        NSString *key = [self keyForEncodedFileURL:fileURL];
        if (key) {
            [_dates setObject:date forKey:key];
        }
    }

    return success;
}

- (BOOL)removeFileAndExecuteBlocksForKey:(NSString *)key
{
    NSURL *fileURL = [self encodedFileURLForKey:key];
    if (!fileURL || ![[NSFileManager defaultManager] fileExistsAtPath:[fileURL path]])
        return NO;

    if (_willRemoveObjectBlock)
        _willRemoveObjectBlock(self, key, nil, fileURL);

    BOOL trashed = [BITDiskCache moveItemAtURLToTrash:fileURL];
    if (!trashed)
        return NO;
    
    [BITDiskCache emptyTrash];

    NSNumber *byteSize = [_sizes objectForKey:key];
    if (byteSize)
        self.byteCount = _byteCount - [byteSize unsignedIntegerValue]; // atomic

    [_sizes removeObjectForKey:key];
    [_dates removeObjectForKey:key];

    if (_didRemoveObjectBlock)
        _didRemoveObjectBlock(self, key, nil, fileURL);

    return YES;
}

- (void)trimDiskToSize:(NSUInteger)trimByteCount
{
    if (_byteCount <= trimByteCount)
        return;

    NSArray *keysSortedBySize = [_sizes keysSortedByValueUsingSelector:@selector(compare:)];

    for (NSString *key in [keysSortedBySize reverseObjectEnumerator]) { // largest objects first
        [self removeFileAndExecuteBlocksForKey:key];

        if (_byteCount <= trimByteCount)
            break;
    }
}

- (void)trimDiskToSizeByDate:(NSUInteger)trimByteCount
{
    if (_byteCount <= trimByteCount)
        return;

    NSArray *keysSortedByDate = [_dates keysSortedByValueUsingSelector:@selector(compare:)];

    for (NSString *key in keysSortedByDate) { // oldest objects first
        [self removeFileAndExecuteBlocksForKey:key];

        if (_byteCount <= trimByteCount)
            break;
    }
}

- (void)trimDiskToDate:(NSDate *)trimDate
{
    NSArray *keysSortedByDate = [_dates keysSortedByValueUsingSelector:@selector(compare:)];
    
    for (NSString *key in keysSortedByDate) { // oldest files first
        NSDate *accessDate = [_dates objectForKey:key];
        if (!accessDate)
            continue;
        
        if ([accessDate compare:trimDate] == NSOrderedAscending) { // older than trim date
            [self removeFileAndExecuteBlocksForKey:key];
        } else {
            break;
        }
    }
}

- (void)trimToAgeLimitRecursively
{
    if (_ageLimit == 0.0)
        return;
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:-_ageLimit];
    [self trimDiskToDate:date];
    
    __weak BITDiskCache *weakSelf = self;
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_ageLimit * NSEC_PER_SEC));
    dispatch_after(time, _queue, ^(void) {
        BITDiskCache *strongSelf = weakSelf;
        [strongSelf trimToAgeLimitRecursively];
    });
}

#pragma mark - Public Asynchronous Methods -

- (void)objectForKey:(NSString *)key block:(BITDiskCacheObjectBlock)block
{
    NSDate *now = [[NSDate alloc] init];

    if (!key || !block)
        return;

    __weak BITDiskCache *weakSelf = self;

    dispatch_async(_queue, ^{
        BITDiskCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        NSURL *fileURL = [strongSelf encodedFileURLForKey:key];
        id <NSCoding> object = nil;

        if ([[NSFileManager defaultManager] fileExistsAtPath:[fileURL path]]) {
            @try {
                object = [NSKeyedUnarchiver unarchiveObjectWithFile:[fileURL path]];
            }
            @catch (NSException *exception) {
                NSError *error = nil;
                [[NSFileManager defaultManager] removeItemAtPath:[fileURL path] error:&error];
                BITDiskCacheError(error);
            }

            [strongSelf setFileModificationDate:now forURL:fileURL];
        }

        block(strongSelf, key, object, fileURL);
    });
}

- (void)fileURLForKey:(NSString *)key block:(BITDiskCacheObjectBlock)block
{
    NSDate *now = [[NSDate alloc] init];

    if (!key || !block)
        return;

    __weak BITDiskCache *weakSelf = self;

    dispatch_async(_queue, ^{
        BITDiskCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        NSURL *fileURL = [strongSelf encodedFileURLForKey:key];

        if ([[NSFileManager defaultManager] fileExistsAtPath:[fileURL path]]) {
            [strongSelf setFileModificationDate:now forURL:fileURL];
        } else {
            fileURL = nil;
        }

        block(strongSelf, key, nil, fileURL);
    });
}

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key block:(BITDiskCacheObjectBlock)block
{
    NSDate *now = [[NSDate alloc] init];

    if (!key || !object)
        return;

    UIBackgroundTaskIdentifier taskID = [BITCacheBackgroundTaskManager beginBackgroundTask];

    __weak BITDiskCache *weakSelf = self;

    dispatch_async(_queue, ^{
        BITDiskCache *strongSelf = weakSelf;
        if (!strongSelf) {
            [BITCacheBackgroundTaskManager endBackgroundTask:taskID];
            return;
        }

        NSURL *fileURL = [strongSelf encodedFileURLForKey:key];

        if (strongSelf->_willAddObjectBlock)
            strongSelf->_willAddObjectBlock(strongSelf, key, object, fileURL);

        BOOL written = [NSKeyedArchiver archiveRootObject:object toFile:[fileURL path]];

        if (written) {
            [strongSelf setFileModificationDate:now forURL:fileURL];

            NSError *error = nil;
            NSDictionary *values = [fileURL resourceValuesForKeys:@[ NSURLTotalFileAllocatedSizeKey ] error:&error];
            BITDiskCacheError(error);

            NSNumber *diskFileSize = [values objectForKey:NSURLTotalFileAllocatedSizeKey];
            if (diskFileSize) {
                NSNumber *oldEntry = [strongSelf->_sizes objectForKey:key];
                
                if ([oldEntry isKindOfClass:[NSNumber class]]){
                    strongSelf.byteCount = strongSelf->_byteCount - [oldEntry unsignedIntegerValue];
                }
                
                [strongSelf->_sizes setObject:diskFileSize forKey:key];
                strongSelf.byteCount = strongSelf->_byteCount + [diskFileSize unsignedIntegerValue]; // atomic
            }
            
            if (strongSelf->_byteLimit > 0 && strongSelf->_byteCount > strongSelf->_byteLimit)
                [strongSelf trimToSizeByDate:strongSelf->_byteLimit block:nil];
        } else {
            fileURL = nil;
        }

        if (strongSelf->_didAddObjectBlock)
            strongSelf->_didAddObjectBlock(strongSelf, key, object, written ? fileURL : nil);

        if (block)
            block(strongSelf, key, object, fileURL);

        [BITCacheBackgroundTaskManager endBackgroundTask:taskID];
    });
}

- (void)removeObjectForKey:(NSString *)key block:(BITDiskCacheObjectBlock)block
{
    if (!key)
        return;

    UIBackgroundTaskIdentifier taskID = [BITCacheBackgroundTaskManager beginBackgroundTask];

    __weak BITDiskCache *weakSelf = self;

    dispatch_async(_queue, ^{
        BITDiskCache *strongSelf = weakSelf;
        if (!strongSelf) {
            [BITCacheBackgroundTaskManager endBackgroundTask:taskID];
            return;
        }

        NSURL *fileURL = [strongSelf encodedFileURLForKey:key];
        [strongSelf removeFileAndExecuteBlocksForKey:key];

        if (block)
            block(strongSelf, key, nil, fileURL);

        [BITCacheBackgroundTaskManager endBackgroundTask:taskID];
    });
}

- (void)trimToSize:(NSUInteger)trimByteCount block:(BITDiskCacheBlock)block
{
    if (trimByteCount == 0) {
        [self removeAllObjects:block];
        return;
    }

    UIBackgroundTaskIdentifier taskID = [BITCacheBackgroundTaskManager beginBackgroundTask];
    
    __weak BITDiskCache *weakSelf = self;
    
    dispatch_async(_queue, ^{
        BITDiskCache *strongSelf = weakSelf;
        if (!strongSelf) {
            [BITCacheBackgroundTaskManager endBackgroundTask:taskID];
            return;
        }

        [strongSelf trimDiskToSize:trimByteCount];

        if (block)
            block(strongSelf);
        
        [BITCacheBackgroundTaskManager endBackgroundTask:taskID];
    });
}

- (void)trimToDate:(NSDate *)trimDate block:(BITDiskCacheBlock)block
{
    if (!trimDate)
        return;

    if ([trimDate isEqualToDate:[NSDate distantPast]]) {
        [self removeAllObjects:block];
        return;
    }
    
    UIBackgroundTaskIdentifier taskID = [BITCacheBackgroundTaskManager beginBackgroundTask];

    __weak BITDiskCache *weakSelf = self;

    dispatch_async(_queue, ^{
        BITDiskCache *strongSelf = weakSelf;
        if (!strongSelf) {
            [BITCacheBackgroundTaskManager endBackgroundTask:taskID];
            return;
        }

        [strongSelf trimDiskToDate:trimDate];

        if (block)
            block(strongSelf);
        
        [BITCacheBackgroundTaskManager endBackgroundTask:taskID];
    });
}

- (void)trimToSizeByDate:(NSUInteger)trimByteCount block:(BITDiskCacheBlock)block
{
    if (trimByteCount == 0) {
        [self removeAllObjects:block];
        return;
    }

    UIBackgroundTaskIdentifier taskID = [BITCacheBackgroundTaskManager beginBackgroundTask];

    __weak BITDiskCache *weakSelf = self;

    dispatch_async(_queue, ^{
        BITDiskCache *strongSelf = weakSelf;
        if (!strongSelf) {
            [BITCacheBackgroundTaskManager endBackgroundTask:taskID];
            return;
        }

        [strongSelf trimDiskToSizeByDate:trimByteCount];

        if (block)
            block(strongSelf);

        [BITCacheBackgroundTaskManager endBackgroundTask:taskID];
    });
}

- (void)removeAllObjects:(BITDiskCacheBlock)block
{
    UIBackgroundTaskIdentifier taskID = [BITCacheBackgroundTaskManager beginBackgroundTask];
    
    __weak BITDiskCache *weakSelf = self;

    dispatch_async(_queue, ^{
        BITDiskCache *strongSelf = weakSelf;
        if (!strongSelf) {
            [BITCacheBackgroundTaskManager endBackgroundTask:taskID];
            return;
        }

        if (strongSelf->_willRemoveAllObjectsBlock)
            strongSelf->_willRemoveAllObjectsBlock(strongSelf);
        
        [BITDiskCache moveItemAtURLToTrash:strongSelf->_cacheURL];
        [BITDiskCache emptyTrash];

        [strongSelf createCacheDirectory];

        [strongSelf->_dates removeAllObjects];
        [strongSelf->_sizes removeAllObjects];
        strongSelf.byteCount = 0; // atomic

        if (strongSelf->_didRemoveAllObjectsBlock)
            strongSelf->_didRemoveAllObjectsBlock(strongSelf);

        if (block)
            block(strongSelf);
        
        [BITCacheBackgroundTaskManager endBackgroundTask:taskID];
    });
}

- (void)enumerateObjectsWithBlock:(BITDiskCacheObjectBlock)block completionBlock:(BITDiskCacheBlock)completionBlock
{
    if (!block)
        return;

    UIBackgroundTaskIdentifier taskID = [BITCacheBackgroundTaskManager beginBackgroundTask];

    __weak BITDiskCache *weakSelf = self;

    dispatch_async(_queue, ^{
        BITDiskCache *strongSelf = weakSelf;
        if (!strongSelf) {
            [BITCacheBackgroundTaskManager endBackgroundTask:taskID];
            return;
        }

        NSArray *keysSortedByDate = [strongSelf->_dates keysSortedByValueUsingSelector:@selector(compare:)];

        for (NSString *key in keysSortedByDate) {
            NSURL *fileURL = [strongSelf encodedFileURLForKey:key];
            block(strongSelf, key, nil, fileURL);
        }

        if (completionBlock)
            completionBlock(strongSelf);

        [BITCacheBackgroundTaskManager endBackgroundTask:taskID];
    });
}

#pragma mark - Public Synchronous Methods -

- (id <NSCoding>)objectForKey:(NSString *)key
{
    if (!key)
        return nil;

    __block id <NSCoding> objectForKey = nil;

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self objectForKey:key block:^(BITDiskCache *cache, NSString *key, id <NSCoding> object, NSURL *fileURL) {
        objectForKey = object;
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif

    return objectForKey;
}

- (NSURL *)fileURLForKey:(NSString *)key
{
    if (!key)
        return nil;

    __block NSURL *fileURLForKey = nil;

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self fileURLForKey:key block:^(BITDiskCache *cache, NSString *key, id <NSCoding> object, NSURL *fileURL) {
        fileURLForKey = fileURL;
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif

    return fileURLForKey;
}

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key
{
    if (!object || !key)
        return;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self setObject:object forKey:key block:^(BITDiskCache *cache, NSString *key, id <NSCoding> object, NSURL *fileURL) {
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif
}

- (void)removeObjectForKey:(NSString *)key
{
    if (!key)
        return;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self removeObjectForKey:key block:^(BITDiskCache *cache, NSString *key, id <NSCoding> object, NSURL *fileURL) {
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif
}

- (void)trimToSize:(NSUInteger)byteCount
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self trimToSize:byteCount block:^(BITDiskCache *cache) {
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif
}

- (void)trimToDate:(NSDate *)date
{
    if (!date)
        return;

    if ([date isEqualToDate:[NSDate distantPast]]) {
        [self removeAllObjects];
        return;
    }

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self trimToDate:date block:^(BITDiskCache *cache) {
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif
}

- (void)trimToSizeByDate:(NSUInteger)byteCount
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self trimToSizeByDate:byteCount block:^(BITDiskCache *cache) {
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif
}

- (void)removeAllObjects
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self removeAllObjects:^(BITDiskCache *cache) {
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif
}

- (void)enumerateObjectsWithBlock:(BITDiskCacheObjectBlock)block
{
    if (!block)
        return;

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self enumerateObjectsWithBlock:block completionBlock:^(BITDiskCache *cache) {
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif
}

#pragma mark - Public Thread Safe Accessors -

- (BITDiskCacheObjectBlock)willAddObjectBlock
{
    __block BITDiskCacheObjectBlock block = nil;

    dispatch_sync(_queue, ^{
        block = _willAddObjectBlock;
    });

    return block;
}

- (void)setWillAddObjectBlock:(BITDiskCacheObjectBlock)block
{
    __weak BITDiskCache *weakSelf = self;

    dispatch_async(_queue, ^{
        BITDiskCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        strongSelf->_willAddObjectBlock = [block copy];
    });
}

- (BITDiskCacheObjectBlock)willRemoveObjectBlock
{
    __block BITDiskCacheObjectBlock block = nil;

    dispatch_sync(_queue, ^{
        block = _willRemoveObjectBlock;
    });

    return block;
}

- (void)setWillRemoveObjectBlock:(BITDiskCacheObjectBlock)block
{
    __weak BITDiskCache *weakSelf = self;

    dispatch_async(_queue, ^{
        BITDiskCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        strongSelf->_willRemoveObjectBlock = [block copy];
    });
}

- (BITDiskCacheBlock)willRemoveAllObjectsBlock
{
    __block BITDiskCacheBlock block = nil;

    dispatch_sync(_queue, ^{
        block = _willRemoveAllObjectsBlock;
    });

    return block;
}

- (void)setWillRemoveAllObjectsBlock:(BITDiskCacheBlock)block
{
    __weak BITDiskCache *weakSelf = self;

    dispatch_async(_queue, ^{
        BITDiskCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        strongSelf->_willRemoveAllObjectsBlock = [block copy];
    });
}

- (BITDiskCacheObjectBlock)didAddObjectBlock
{
    __block BITDiskCacheObjectBlock block = nil;

    dispatch_sync(_queue, ^{
        block = _didAddObjectBlock;
    });

    return block;
}

- (void)setDidAddObjectBlock:(BITDiskCacheObjectBlock)block
{
    __weak BITDiskCache *weakSelf = self;

    dispatch_async(_queue, ^{
        BITDiskCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        strongSelf->_didAddObjectBlock = [block copy];
    });
}

- (BITDiskCacheObjectBlock)didRemoveObjectBlock
{
    __block BITDiskCacheObjectBlock block = nil;

    dispatch_sync(_queue, ^{
        block = _didRemoveObjectBlock;
    });

    return block;
}

- (void)setDidRemoveObjectBlock:(BITDiskCacheObjectBlock)block
{
    __weak BITDiskCache *weakSelf = self;

    dispatch_async(_queue, ^{
        BITDiskCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        strongSelf->_didRemoveObjectBlock = [block copy];
    });
}

- (BITDiskCacheBlock)didRemoveAllObjectsBlock
{
    __block BITDiskCacheBlock block = nil;

    dispatch_sync(_queue, ^{
        block = _didRemoveAllObjectsBlock;
    });

    return block;
}

- (void)setDidRemoveAllObjectsBlock:(BITDiskCacheBlock)block
{
    __weak BITDiskCache *weakSelf = self;

    dispatch_async(_queue, ^{
        BITDiskCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        strongSelf->_didRemoveAllObjectsBlock = [block copy];
    });
}

- (NSUInteger)byteLimit
{
    __block NSUInteger byteLimit = 0;
    
    dispatch_sync(_queue, ^{
        byteLimit = _byteLimit;
    });
    
    return byteLimit;
}

- (void)setByteLimit:(NSUInteger)byteLimit
{
    __weak BITDiskCache *weakSelf = self;
    
    dispatch_barrier_async(_queue, ^{
        BITDiskCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;
        
        strongSelf->_byteLimit = byteLimit;

        if (byteLimit > 0)
            [strongSelf trimDiskToSizeByDate:byteLimit];
    });
}

- (NSTimeInterval)ageLimit
{
    __block NSTimeInterval ageLimit = 0.0;
    
    dispatch_sync(_queue, ^{
        ageLimit = _ageLimit;
    });
    
    return ageLimit;
}

- (void)setAgeLimit:(NSTimeInterval)ageLimit
{
    __weak BITDiskCache *weakSelf = self;
    
    dispatch_barrier_async(_queue, ^{
        BITDiskCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;
        
        strongSelf->_ageLimit = ageLimit;
        
        [strongSelf trimToAgeLimitRecursively];
    });
}

#pragma mark - Background Tasks -

+ (void)setBackgroundTaskManager:(id <BITCacheBackgroundTaskManager>)backgroundTaskManager {
    BITCacheBackgroundTaskManager = backgroundTaskManager;
}

@end
