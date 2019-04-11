import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bottom_button.dart';
import 'titlebar.dart';
import 'add_address.dart';
import 'behavior.dart';
import 'no_address_yet.dart';
import 'package:camera/camera.dart';


class ChooseAddress extends StatefulWidget {
  const ChooseAddress({ Key key }) : super(key: key);
  _ChooseAddressState createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress>{
  final _scaffoldState = GlobalKey<ScaffoldState>();
  Size deviceSize;
  BuildContext _context;
  num itemHeight = 80;
  num paddingHorizontal = 20;

  @override
  Widget build(BuildContext context) {
    _context = context;
    deviceSize = MediaQuery.of(_context).size;
    itemHeight = deviceSize.height / 7;
    paddingHorizontal = deviceSize.width / 4;
    return Scaffold(
        appBar: PreferredSize(
            child: Titlebar1(
                titleValue: "选择地址",
                actionValue: "添加新地址",
                leadingCallback: ()=>Navigator.pop(context),
              actionCallback: ()=>Navigator.push<String>(
                  context,new MaterialPageRoute(builder: (BuildContext context){
                return new AddAddress();
              })
              ),
            ),
            preferredSize: Size.fromHeight(50)),


        );
  }

  Widget buildAddressList(){
    return Column(
      children: <Widget>[
        buildCurrentAddress(),
        Expanded(
            flex: 1,
            child: ScrollConfiguration(behavior: MyBehavior(), child: ListView.builder(
                shrinkWrap: true,
//                  itemExtent: itemHeight,
                scrollDirection: Axis.vertical,
                itemCount: 10,
                cacheExtent: 0.0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                    child: Column(
                      children: <Widget>[
                        ListTile(
//                            onTap: buildTextInput(),
                          title: Row(
                            children: <Widget>[
                              Text("姓名",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16)),
                              Padding(padding: EdgeInsets.only(left: 10),),
                              Text("电话号码",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16))
                            ],
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                                "广东深圳市南山区24号",
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
        ),
        NextButton(
          text: "发布",
          onNext: _onNext,
          padingHorzation: paddingHorizontal,
        )
      ],
    );
  }

  Widget buildCurrentAddress() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 1),
          child: ListTile(
            title: Padding(
                padding: EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.location_on, color: Colors.blue[400]),
                    SizedBox(width: 1),
                    Text("张三",
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                    SizedBox(width: 5),
                    Text("13564793024",
                        style: TextStyle(color: Colors.black, fontSize: 14))
                  ],
                )),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 4, left: 26),
              child: Text(
                  "广东深圳市 南山区24号",
                  style: TextStyle(color: Colors.black, fontSize: 14)),
            ),
            trailing: Text(
              "修改",
              style: TextStyle(color: Colors.grey),
            ),
            contentPadding: EdgeInsets.only(left: 10, right: 15),
          ),
        ),
        Container(
          height: 15,
          color: Colors.grey[300],
        )
      ],
    );
  }

  _onNext() {
    //Fluttertoast.showToast(msg: "发布了！");
  }

    Widget _addNewAddress(BuildContext context) {
      return Scaffold(appBar: AppBar(
        title: Text('输入和选择'),
      ),body:TextField(),
      );
    }


}


