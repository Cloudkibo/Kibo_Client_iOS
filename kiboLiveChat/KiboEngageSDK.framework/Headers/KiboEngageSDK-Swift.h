// Generated by Apple Swift version 2.2 (swiftlang-703.0.18.1 clang-703.0.29)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreGraphics;
@import Foundation;
@import ObjectiveC;
@import Dispatch;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UITableView;
@class NSIndexPath;
@class UITableViewCell;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC13KiboEngageSDK25ChatsDetailViewController")
@interface ChatsDetailViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView * _Nonnull)tableView heightForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UICollectionView;
@class UICollectionViewLayout;
@class UICollectionViewCell;

SWIFT_CLASS("_TtC13KiboEngageSDK20GroupsViewController")
@interface GroupsViewController : UIViewController <UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) IBOutlet UICollectionView * _Null_unspecified collectionViewGroups;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (CGSize)collectionView:(UICollectionView * _Nonnull)collectionView layout:(UICollectionViewLayout * _Nonnull)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (NSInteger)collectionView:(UICollectionView * _Nonnull)collectionView numberOfItemsInSection:(NSInteger)section;
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView * _Nonnull)collectionView;
- (UICollectionViewCell * _Nonnull)collectionView:(UICollectionView * _Nonnull)collectionView cellForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
@end


@interface NSDictionary (SWIFT_EXTENSION(KiboEngageSDK))
@end


SWIFT_CLASS("_TtC13KiboEngageSDK16SocketAckEmitter")
@interface SocketAckEmitter : NSObject
- (void)with:(NSArray * _Nonnull)items;
@end

@class NSArray;

SWIFT_CLASS("_TtC13KiboEngageSDK14SocketAnyEvent")
@interface SocketAnyEvent : NSObject
@property (nonatomic, readonly, copy) NSString * _Null_unspecified event;
@property (nonatomic, readonly, strong) NSArray * _Nullable items;
@property (nonatomic, readonly, copy) NSString * _Nonnull description;
@end

@protocol SocketEngineClient;
@class NSHTTPCookie;
@class NSTimer;
@class NSData;
enum SocketEnginePacketType : NSInteger;

SWIFT_PROTOCOL("_TtP13KiboEngageSDK16SocketEngineSpec_")
@protocol SocketEngineSpec
@property (nonatomic, weak) id <SocketEngineClient> _Nullable client;
@property (nonatomic, readonly) BOOL closed;
@property (nonatomic, readonly) BOOL connected;
@property (nonatomic, readonly, copy) NSArray<NSHTTPCookie *> * _Nullable cookies;
@property (nonatomic, readonly, copy) NSDictionary<NSString *, NSString *> * _Nullable extraHeaders;
@property (nonatomic, readonly) BOOL fastUpgrade;
@property (nonatomic, readonly) BOOL forcePolling;
@property (nonatomic, readonly) BOOL forceWebsockets;
@property (nonatomic, readonly, strong) dispatch_queue_t _Null_unspecified parseQueue;
@property (nonatomic, readonly, strong) NSTimer * _Nullable pingTimer;
@property (nonatomic, readonly) BOOL polling;
@property (nonatomic, readonly) BOOL probing;
@property (nonatomic, readonly, strong) dispatch_queue_t _Null_unspecified emitQueue;
@property (nonatomic, readonly, strong) dispatch_queue_t _Null_unspecified handleQueue;
@property (nonatomic, readonly, copy) NSString * _Nonnull sid;
@property (nonatomic, readonly, copy) NSString * _Nonnull socketPath;
@property (nonatomic, readonly, copy) NSString * _Nonnull urlPolling;
@property (nonatomic, readonly, copy) NSString * _Nonnull urlWebSocket;
@property (nonatomic, readonly) BOOL websocket;
- (nonnull instancetype)initWithClient:(id <SocketEngineClient> _Nonnull)client url:(NSString * _Nonnull)url options:(NSDictionary * _Nullable)options;
- (void)close:(NSString * _Nonnull)reason;
- (void)didError:(NSString * _Nonnull)error;
- (void)doFastUpgrade;
- (void)flushWaitingForPostToWebSocket;
- (void)open:(NSDictionary<NSString *, id> * _Nullable)opts;
- (void)parseEngineData:(NSData * _Nonnull)data;
- (void)parseEngineMessage:(NSString * _Nonnull)message fromPolling:(BOOL)fromPolling;
- (void)send:(NSString * _Nonnull)msg withData:(NSArray<NSData *> * _Nonnull)datas;
- (void)write:(NSString * _Nonnull)msg withType:(enum SocketEnginePacketType)type withData:(NSArray<NSData *> * _Nonnull)data;
@end

@class NSURLSession;
@class WebSocket;
@class NSError;

SWIFT_CLASS("_TtC13KiboEngageSDK12SocketEngine")
@interface SocketEngine : NSObject <SocketEngineSpec>
@property (nonatomic, readonly, strong) dispatch_queue_t _Null_unspecified emitQueue;
@property (nonatomic, readonly, strong) dispatch_queue_t _Null_unspecified handleQueue;
@property (nonatomic, readonly, strong) dispatch_queue_t _Null_unspecified parseQueue;
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull postWait;
@property (nonatomic) BOOL waitingForPoll;
@property (nonatomic) BOOL waitingForPost;
@property (nonatomic, readonly) BOOL closed;
@property (nonatomic, readonly) BOOL connected;
@property (nonatomic, readonly, copy) NSArray<NSHTTPCookie *> * _Nullable cookies;
@property (nonatomic, readonly, copy) NSDictionary<NSString *, NSString *> * _Nullable extraHeaders;
@property (nonatomic, readonly) BOOL fastUpgrade;
@property (nonatomic, readonly) BOOL forcePolling;
@property (nonatomic, readonly) BOOL forceWebsockets;
@property (nonatomic, readonly) BOOL invalidated;
@property (nonatomic, readonly, strong) NSTimer * _Nullable pingTimer;
@property (nonatomic, readonly) BOOL polling;
@property (nonatomic, readonly) BOOL probing;
@property (nonatomic, readonly, strong) NSURLSession * _Nullable session;
@property (nonatomic, readonly, copy) NSString * _Nonnull sid;
@property (nonatomic, readonly, copy) NSString * _Nonnull socketPath;
@property (nonatomic, readonly, copy) NSString * _Nonnull urlPolling;
@property (nonatomic, readonly, copy) NSString * _Nonnull urlWebSocket;
@property (nonatomic, readonly) BOOL websocket;
@property (nonatomic, readonly, strong) WebSocket * _Nullable ws;
@property (nonatomic, weak) id <SocketEngineClient> _Nullable client;
- (nonnull instancetype)initWithClient:(id <SocketEngineClient> _Nonnull)client url:(NSString * _Nonnull)url options:(NSDictionary * _Nullable)options;
- (void)close:(NSString * _Nonnull)reason;
- (void)didError:(NSString * _Nonnull)error;
- (void)doFastUpgrade;
- (void)flushWaitingForPostToWebSocket;
- (void)open:(NSDictionary<NSString *, id> * _Nullable)opts;
- (void)parseEngineData:(NSData * _Nonnull)data;
- (void)parseEngineMessage:(NSString * _Nonnull)message fromPolling:(BOOL)fromPolling;

/// Send an engine message (4)
- (void)send:(NSString * _Nonnull)msg withData:(NSArray<NSData *> * _Nonnull)datas;

/// Write a message, independent of transport.
- (void)write:(NSString * _Nonnull)msg withType:(enum SocketEnginePacketType)type withData:(NSArray<NSData *> * _Nonnull)data;
- (void)websocketDidConnect:(WebSocket * _Nonnull)socket;
- (void)websocketDidDisconnect:(WebSocket * _Nonnull)socket error:(NSError * _Nullable)error;
@end


SWIFT_PROTOCOL("_TtP13KiboEngageSDK18SocketEngineClient_")
@protocol SocketEngineClient
- (void)engineDidError:(NSString * _Nonnull)reason;
- (void)engineDidClose:(NSString * _Nonnull)reason;
@optional
- (void)engineDidOpen:(NSString * _Nonnull)reason;
@required
- (void)parseEngineMessage:(NSString * _Nonnull)msg;
- (void)parseEngineBinaryData:(NSData * _Nonnull)data;
@end

typedef SWIFT_ENUM(NSInteger, SocketEnginePacketType) {
  SocketEnginePacketTypeOpen = 0,
  SocketEnginePacketTypeClose = 1,
  SocketEnginePacketTypePing = 2,
  SocketEnginePacketTypePong = 3,
  SocketEnginePacketTypeMessage = 4,
  SocketEnginePacketTypeUpgrade = 5,
  SocketEnginePacketTypeNoop = 6,
};


enum SocketIOClientStatus : NSInteger;
@class NSUUID;

SWIFT_CLASS("_TtC13KiboEngageSDK14SocketIOClient")
@interface SocketIOClient : NSObject <SocketEngineClient>
@property (nonatomic, readonly, copy) NSString * _Nonnull socketURL;
@property (nonatomic, readonly, strong) id <SocketEngineSpec> _Nullable engine;
@property (nonatomic, readonly) enum SocketIOClientStatus status;
@property (nonatomic, copy) NSDictionary<NSString *, id> * _Nullable connectParams;
@property (nonatomic) BOOL forceNew;
@property (nonatomic, copy) NSString * _Nonnull nsp;
@property (nonatomic) BOOL reconnects;
@property (nonatomic) NSInteger reconnectWait;
@property (nonatomic, readonly, copy) NSString * _Nullable sid;

/// Not so type safe way to create a SocketIOClient, meant for Objective-C compatiblity. If using Swift it's recommended to use init(var socketURL: String, options: Set<SocketIOClientOption>)
- (nonnull instancetype)initWithSocketURL:(NSString * _Nonnull)socketURL options:(NSDictionary * _Nullable)options;
- (void)close;

/// Connect to the server.
- (void)connect;

/// Connect to the server. If we aren't connected after timeoutAfter, call handler
- (void)connectWithTimeoutAfter:(NSInteger)timeoutAfter withTimeoutHandler:(void (^ _Nullable)(void))handler;

/// Disconnects the socket. Only reconnect the same socket if you know what you're doing. Will turn off automatic reconnects.
- (void)disconnect;

/// Same as emit, but meant for Objective-C
- (void)emit:(NSString * _Nonnull)event withItems:(NSArray * _Nonnull)items;

/// Same as emitWithAck, but for Objective-C
- (void (^ _Nonnull)(uint64_t, void (^ _Nonnull)(NSArray * _Nonnull)))emitWithAck:(NSString * _Nonnull)event withItems:(NSArray * _Nonnull)items;
- (void)engineDidClose:(NSString * _Nonnull)reason;

/// error
- (void)engineDidError:(NSString * _Nonnull)reason;

/// Causes an event to be handled. Only use if you know what you're doing.
- (void)handleEvent:(NSString * _Nonnull)event data:(NSArray * _Nonnull)data isInternalMessage:(BOOL)isInternalMessage withAck:(NSInteger)ack;

/// Leaves nsp and goes back to /
- (void)leaveNamespace;

/// Joins namespace
- (void)joinNamespace:(NSString * _Nonnull)namespace_;

/// Removes handler(s)
- (void)off:(NSString * _Nonnull)event;

/// Removes a handler with the specified UUID gotten from an on or once
- (void)offWithId:(NSUUID * _Nonnull)id;

/// Adds a handler for an event. Returns: A unique id for the handler
- (NSUUID * _Nonnull)on:(NSString * _Nonnull)event callback:(void (^ _Nonnull)(NSArray * _Nonnull, SocketAckEmitter * _Nonnull))callback;

/// Adds a single-use handler for an event. Returns: A unique id for the handler
- (NSUUID * _Nonnull)once:(NSString * _Nonnull)event callback:(void (^ _Nonnull)(NSArray * _Nonnull, SocketAckEmitter * _Nonnull))callback;

/// Adds a handler that will be called on every event.
- (void)onAny:(void (^ _Nonnull)(SocketAnyEvent * _Nonnull))handler;

/// Same as connect
- (void)open;
- (void)parseEngineMessage:(NSString * _Nonnull)msg;
- (void)parseEngineBinaryData:(NSData * _Nonnull)data;

/// Tries to reconnect to the server.
- (void)reconnect;

/// Removes all handlers. Can be used after disconnecting to break any potential remaining retain cycles.
- (void)removeAllHandlers;
@end


@interface SocketIOClient (SWIFT_EXTENSION(KiboEngageSDK))
@end

typedef SWIFT_ENUM(NSInteger, SocketIOClientStatus) {
  SocketIOClientStatusNotConnected = 0,
  SocketIOClientStatusClosed = 1,
  SocketIOClientStatusConnecting = 2,
  SocketIOClientStatusConnected = 3,
  SocketIOClientStatusReconnecting = 4,
};

@class NSURL;
@class NSStream;

SWIFT_CLASS("_TtC13KiboEngageSDK9WebSocket")
@interface WebSocket : NSObject <NSStreamDelegate>
+ (NSString * _Nonnull)ErrorDomain;
@property (nonatomic, strong) dispatch_queue_t _Null_unspecified queue;
@property (nonatomic, copy) void (^ _Nullable onConnect)(void);
@property (nonatomic, copy) void (^ _Nullable onDisconnect)(NSError * _Nullable);
@property (nonatomic, copy) void (^ _Nullable onText)(NSString * _Nonnull);
@property (nonatomic, copy) void (^ _Nullable onData)(NSData * _Nonnull);
@property (nonatomic, copy) void (^ _Nullable onPong)(void);
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> * _Nonnull headers;
@property (nonatomic) BOOL voipEnabled;
@property (nonatomic) BOOL selfSignedSSL;
@property (nonatomic, copy) NSString * _Nullable origin;
@property (nonatomic, readonly) BOOL isConnected;
@property (nonatomic, readonly, strong) NSURL * _Nonnull currentURL;
- (nonnull instancetype)initWithUrl:(NSURL * _Nonnull)url protocols:(NSArray<NSString *> * _Nullable)protocols OBJC_DESIGNATED_INITIALIZER;

/// Connect to the websocket server on a background thread
- (void)connect;

/// write a string to the websocket. This sends it as a text frame.
- (void)writeString:(NSString * _Nonnull)str;

/// write binary data to the websocket. This sends it as a binary frame.
- (void)writeData:(NSData * _Nonnull)data;
- (void)writePing:(NSData * _Nonnull)data;
- (void)stream:(NSStream * _Nonnull)aStream handleEvent:(NSStreamEvent)eventCode;
@end

#pragma clang diagnostic pop
