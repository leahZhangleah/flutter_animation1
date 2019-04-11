import 'package:flutter/material.dart';

class Coupon extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CouponState();
  }

}

class CouponState extends State<Coupon> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        buildCouponDescription(),
        buildCouponValidation(),
      ],
    );
  }

  Widget buildCouponDescription(){
    return new Container(
      decoration:BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(
          right: new Radius.circular(20.0)
        )
      ) ,
    );
  }

  Widget buildCouponValidation(){
    return new Container(
      decoration:BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(
              left: new Radius.circular(20.0)
          )
      ) ,
    );
  }
}