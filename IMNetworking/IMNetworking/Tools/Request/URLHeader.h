//
//  URLHeader.h
//  Utilities
//
//  Created by Alien on 2019/6/17.
//  Copyright © 2019 ouwen. All rights reserved.
//

#ifndef URLHeader_h
#define URLHeader_h

#define BaseURL @"http://wanxiangcheng365.cn/BangBang/" //请求URL
#define QueryHome @"api/queryHome"   //查询首页数据，返回广告位，功能以及底部广告
#define BindBaiDuPush @"api/bindPushService"  //绑定百度推送
#define LOGINOUT @"api/logout" //退出登录  退出登录在设置里面 同时推出IM 还有推送应该也退出吧

#define LOGIN @"mobile/login"  //登录webview地址
#define GetUserInfo  @"api/getUserInfo"  //我的，个人资料请求接口
#define UpdateUserInfo @"api/regUserInfo" //完善用户信息
#define ChangePwd @"api/changePwd" //完善用户信息
#define UserAgreeement @"mobile/agreement.html" //用户协议 关于页面-协议 webview

#define HomeSearch @"mobile/friends_new" //首页搜索 跳转webview
#define HomeNewTask @"mobile/friends_new" //首页新任务  webview
#define HomeTasking  @"mobile/friends_end" //首页任务中  webview
#define HomeAds  @"mobile/friends" //首页底部广告跳转地址 首页功能跳转 均是该地址 webview  首页banner的跳转地址 banner里有

#define QueryMessage @"api/queryChatList" //查询消息列表
#define QueryChatSign @"api/getSign" //查询聊天sign
#define MessageDetail @"mobile/payOrderDetail" //消息Item 点击 Webview
#define MessageItemPay @"mobile/pay" //消息Item Pay webview  消息列表还有个发起单聊  腾讯云通信
#define OrderList @"mobile/order_list" //订单列表 webview 已接单 state 0  配送中 state 5 已完成 state 10 已取消 state 15 全部 state -1
#define OrderListKuaiDi @"mobile/order_list_kuaidi"//快递订单列表 已接单0 已支付5 配送中10 已取消 15 全部 -1
#define QueryPushMsgList @"api/queryPushMsgRecord"//我的 原声 消息通知 查询推送消息列表
#define MineAddress @"mobile/address" //我的地址管理 webview
#define MineKefu @"mobile/kefu" //我的 客服 webview
#define MineCommonQuestion @"mobile/wenti" //我的 常见问题 webview
#define MineQianbao @"mobile/qianbao" //我的 钱包 webview
#define MineFeedback @"mobile/feedback" //我的 意见反馈 webview


#define UploadPic @"api/upload" //上传图片信息
#define UploadVideo @"api/uploadLuYin" //上传录音文件
#define DownUrl @"download/index.html";
#define  MessageUrl  @"mobile/msg.html";//通知消息

#endif /* URLHeader_h */
