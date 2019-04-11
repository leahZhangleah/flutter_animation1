import 'package:flutter/material.dart';
import 'behavior.dart';
import 'titlebar.dart';

class AddressManage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child: Titlebar1(
          titleValue: "我的地址",
          actionValue: "添加新地址",
          leadingCallback: null,
          actionCallback: _addNewAddress),
          preferredSize: Size.fromHeight(50)),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 10,
          cacheExtent: 0.0,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text("电话号码",
                            style: TextStyle(
                                color: Colors.black, fontSize: 14)),
                        Text("姓名",
                            style: TextStyle(
                                color: Colors.black, fontSize: 14))
                      ],
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                          "广东深圳市 南山区 深南大道 发放的大"
                              "23344号",
                          style: TextStyle(
                              color: Colors.black, fontSize: 14)),
                    ),
                    trailing: Text(
                      "修改",
                      style: TextStyle(color: Colors.grey),
                    ),
                    contentPadding:
                    EdgeInsets.only(left: 10, right: 15),
                  ),
                  index < 10
                      ? Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Divider(height: 1, color: Colors.grey))
                      : null,
                ],
              ),
            );
          }),)
    );
  }


  _addNewAddress() {
    //todo
  }
}