// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: msg_shake.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30002
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30002 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

NS_ASSUME_NONNULL_BEGIN

#pragma mark - MsgShakeRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
@interface MsgShakeRoot : GPBRootObject
@end

#pragma mark - ShakeRequestMsg

typedef GPB_ENUM(ShakeRequestMsg_FieldNumber) {
  ShakeRequestMsg_FieldNumber_SenderUid = 1,
  ShakeRequestMsg_FieldNumber_ReceiverUid = 2,
  ShakeRequestMsg_FieldNumber_ExtType = 3,
  ShakeRequestMsg_FieldNumber_ExtLength = 4,
  ShakeRequestMsg_FieldNumber_SenderName = 5,
};

/**
 * SHAKE_REQUEST=10000013;//发送抖动通知
 **/
@interface ShakeRequestMsg : GPBMessage

/** 发送方 */
@property(nonatomic, readwrite) int64_t senderUid;

@property(nonatomic, readwrite) BOOL hasSenderUid;
/** 接收方 */
@property(nonatomic, readwrite) int64_t receiverUid;

@property(nonatomic, readwrite) BOOL hasReceiverUid;
/** 扩展类型 */
@property(nonatomic, readwrite) int64_t extType;

@property(nonatomic, readwrite) BOOL hasExtType;
/** 扩展消息体长度 */
@property(nonatomic, readwrite) int32_t extLength;

@property(nonatomic, readwrite) BOOL hasExtLength;
/** 发送方名字    web端使用，手机端不用设置 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *senderName;
/** Test to see if @c senderName has been set. */
@property(nonatomic, readwrite) BOOL hasSenderName;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
