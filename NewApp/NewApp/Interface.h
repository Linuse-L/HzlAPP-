//
//  Interface.h
//  NewApp
//
//  Created by L on 15/9/26.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#ifndef NewApp_Interface_h
#define NewApp_Interface_h
//域名365jd.ru comelry.ru
#define _huazhonglong_ @"http://www.canteens.top/app.php"
//苹果商店ID

#define kHarpyAppID @"1031456086"

//首页
#define Home_Url @"?root=getAppHome"
#define getZenID_Url @"?root=getZenID"


#define Activity_URL @"?root=getActivity"

//登录
#define Login_Url @"?root=userLogIn"

//注册

#define Regist_Url @"?root=addUser"

//传输token
#define sendToken_url _huazhonglong_@"?root=putToken"

//退出登陆
#define Signout_Url @"?root=userLogOff"
//所有产品展示
#define allProductList_Url @"?root=getProductsList&type=allProductsList"
//分类
//产品详细
#define ProductInfo_Url @"?root=getProductInfo&"
//#define getProductSize_URL @"?root=getProductSizevb&"
#define getProductSize_URL @"?root=getProductSizevc&"
//添加购物车
#define addToCart_URL @"?root=getAppCartvb&action=app_add_product"

//查询购物车
#define queryAppCart_URL @"?root=getAppCartvb"

//删除购物车
#define removeAppCart_URL @"?root=getAppCartvb&action=app_remove_product&"

//修改购物车
#define updateAppCart_URL @"?root=getAppCartvb&action=app_update_product"

//添加评论
#define addProductReViews_Url @"?root=addProductReviews"
//评论列表
#define reviewList_Url _huazhonglong_@"?root=getProductReviewList"

//第一级分类列表
#define ClassList_Url @"?root=getClassList"
//第二级分类列表
#define ClassList2_Url @"?root=getClassList&"
//第三级分类列表
#define ClassList3_Url @"?root=getClassList&"
//产品瀑布流
#define getProductsList @"?root=getProductsList&type=classProductsList&"

//用户地址
#define getUserAddress_URL @"?root=getUserAddress"
//添加用户地址
#define addUserAddress_Url @"?root=addUserAddress"
//修改地址
#define editAddress_Url @"?root=editUserAddress"

#define getCountryID_Url @"?root=getCountryID"

//获得所有国家列表
#define getAllCountryID_Url @"?root=getCountryIDVb"
//支付
#define createOrder_URL @"?root=createOrder"

//未付款订单
#define nopayOrder_Url @"?root=getMyOrder&type=getNoPaid"

//完成订单
#define paySuccessOrder_Url @"?root=getMyOrder&type=getPaidSuccess"

//删除订单
#define delOrder_Url @"?root=delOrder"

#define getSearchResult_URL @"?root=getProductsList&type=getSearchResult&"

//添加商品收藏
#define collection_Url @"?root=addLikeProducts"

//查询商品收藏
#define queryCollection_url @"?root=getProductsList&type=likeProductsList"

//运费
#define shippingPrice_url @"?root=getShippingList"

//选择运费
#define selectshippingMethod_url @"?root=createOrder"

//获取国家货币
#define getCurrencies_url @"?root=getCurrencies"

//修改国家货币
#define setCurrency_url @"?root=setCurrency"

//分享折扣
#define getShareStatus_Url @"?root=setShareStatus"

//物流追踪
#define getTrackInfo @"?root=getTrackInfo"

//筛选接口
#define screenPrd @"?root=getClassTags"

//优惠券接口
#define coupon_url @"?root=getCoupon"

//获取总价接口
#define getallOrderTotal @"?root=getOrderTotal"

#endif
