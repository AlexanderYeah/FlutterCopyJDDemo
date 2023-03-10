import 'dart:convert';

import 'package:copy_jd_demo/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 关于全选 ： 底部的全选与反选
 还有就是购物车的每一个item 点击的时候 当所有的item 都被选中的时候 也是全选
 
 * */
class CartProvider with ChangeNotifier {
  List cartList = [];

  int get cartListCount => cartList.length;
  // 是否是全选状态
  bool isCheckedAll = false;
  // 总价格
  double totalPrice = 0;

  // 初始化的时候加载数据
  CartProvider() {
    this.init();
  }

  //
  init() async {
    // 加载购物车的数据
    try {
      List cartListData = json.decode(await Storage.getString("cartList"));
      print("cartList---cartList");
      print(cartList);
      this.cartList = cartListData;
    } catch (error) {
      print(error);
    }
    // 赋值是否全选
    this.isCheckedAll = this.isCheckAll();
    // 更新数据
    notifyListeners();
  }

  // 更新数据
  updateList() {
    this.init();
  }

  // 改变购物车总商品的数量
  // 这里是为了把数据保存到本地 从新进入购物车界面 展示修改过后的数量 否则的话 界面上的值改变了 但是本地的依然没有改变
  changeCartItemCount() {
    Storage.setString("cartList", json.encode(this.cartList));
    // 就散价格
    calculateTotalPrice();
    notifyListeners();
  }

  // 实现全选和反选
  checkedAll(isSelected) {
    for (var i = 0; i < this.cartList.length; i++) {
      cartList[i]["checked"] = isSelected;
    }
    // 赋值是否是全选的状态
    isCheckedAll = isSelected;
    Storage.setString("cartList", json.encode(this.cartList));
    // 计算价格
    calculateTotalPrice();
    notifyListeners();
  }

  // 判断是否是全选
  bool isCheckAll() {
    if (this.cartList.length > 0) {
      // 只要有一个
      for (var i = 0; i < this.cartList.length; i++) {
        if (cartList[i]["checked"] == false) {
          return false;
        }
      }
      return true;
    } else {
      return false;
    }
  }

  // 监听每一项的选中事件 并且判断是否是全选 或者反全选
  // 改变的时候重新循环遍历
  itemChange() {
    this.isCheckedAll = this.isCheckAll();
    Storage.setString("cartList", json.encode(this.cartList));
    calculateTotalPrice();
    notifyListeners();
  }

  // 计算总价格
  calculateTotalPrice() {
    double tempTotalPrice = 0;
    for (var i = 0; i < this.cartList.length; i++) {
      if (cartList[i]["checked"] == true) {
        tempTotalPrice = tempTotalPrice +
            this.cartList[i]["price"] * this.cartList[i]["cartCount"];
      }
    }
    this.totalPrice = tempTotalPrice;
    notifyListeners();
  }

  // 删除数据
  deleteItem() {
    // 不能根据索引值 for 循环删除
    // 思路是 创建一个数组，把没有勾选的数组摘出来 重新赋值给已经cartList，保存到本地 就实现了删除操作
    List tempList = [];
    for (var i = 0; i < this.cartList.length; i++) {
      if (this.cartList[i]["checked"] == false) {
        tempList.add(this.cartList[i]);
      }
    }
    this.cartList = tempList;
    // 执行一下计算总价
    calculateTotalPrice();
    // 重新保存数据
    Storage.setString("cartList", json.encode(this.cartList));
    notifyListeners();
  }

  // 获取购物车中选中的数据
  static getCartSelectedData() async {
    List cartList = [];
    List selectedDataList = [];
    try {
      cartList = json.decode(await Storage.getString("cartList"));
      for (var i = 0; i < cartList.length; i++) {
        if (cartList[i]["checked"] == true) {
          selectedDataList.add(cartList[i]);
        }
      }
    } catch (error) {
      print(error);
    }
    return selectedDataList;
  }
}
