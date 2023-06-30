import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

void showCustomSnackBar(String message, BuildContext context, {bool isError = true, bool isToaster = false}) {
  if(isToaster){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: isError ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      content: Text(message,
        style: robotoRegular.copyWith(color: Colors.white)),
    ));
  }

}