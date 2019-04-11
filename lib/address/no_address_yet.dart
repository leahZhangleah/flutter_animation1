import 'package:flutter/material.dart';
import 'add_address.dart';
class NoAddressYet extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return NoAddressYetState();
  }

}

class NoAddressYetState extends State<NoAddressYet> {
  num itemHeight;
  @override
  Widget build(BuildContext context) {
    itemHeight = MediaQuery.of(context).size.height/7;
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
            new MaterialPageRoute(
                builder: (context){
                  return new AddAddress();
                })
        );
      },
      child: new Container(
        //color: Colors.white,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        height: itemHeight,
        child:Center(
          //alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.location_on,color: Colors.blue[400],),
                Text('点击添加地址',style: TextStyle(color: Colors.grey),)
              ],
            ),
        ),
      ),
    );
  }
}