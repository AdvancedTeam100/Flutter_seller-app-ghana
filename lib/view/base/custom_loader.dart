
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';


class CustomLoader extends StatelessWidget {
  final double height;
  const CustomLoader({Key key, this.height = 1200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
                height: 80,width: 80, decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT)
            ),
                child: const Center(
                  child: SpinKitCircle(
                    color: Colors.white,
                    size: 50.0,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
