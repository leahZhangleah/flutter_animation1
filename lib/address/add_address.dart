import 'package:flutter/material.dart';

class AddAddress extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddAddressState();
  }
}

class AddAddressState extends State<AddAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("添加新地址"),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: ()=>Navigator.pop(context)),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
              child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      '保存',
                    ),
                  )))
        ],
      ),
        body: Container(
            decoration: BoxDecoration(color: Colors.grey[300]),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(padding: EdgeInsets.only(left: 10),child:TextField(
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: "添加人",
                          hintStyle: TextStyle(color:Colors.grey[400],fontSize: 14)
                      )
                  )
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                    child: Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(padding: EdgeInsets.only(left: 10),child:TextField(
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: "添加人电话号码",
                          hintStyle: TextStyle(color:Colors.grey[400],fontSize: 14)
                      )
                  )
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                    child: Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(padding: EdgeInsets.only(left: 10),child:TextField(
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: "添加人地区",
                          hintStyle: TextStyle(color:Colors.grey[400],fontSize: 14)
                      )
                  )
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                    child: Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(padding: EdgeInsets.only(left: 10),child:TextField(
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: "详细地址：如道路、门牌号、小号、楼栋号等",
                          hintStyle: TextStyle(color:Colors.grey[400],fontSize: 14)
                      )
                  )
                  ),
                )
              ],
            )
        )
    );
  }
}
