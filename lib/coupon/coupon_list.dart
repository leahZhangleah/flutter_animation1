import 'package:flutter/material.dart';
import 'package:flutter_animation/address/titlebar.dart';
import 'coupon.dart';
class CouponList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CouponListState();
  }

}

class CouponListState extends State<CouponList> {
  List<Coupon> couponList;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(child: Titlebar1(
          titleValue: "优惠券",
          leadingCallback: ()=>Navigator.pop(context),),
          preferredSize: Size.fromHeight(50)),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context,index){

          }),
    );
  }
}