import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';


class PosProductShimmer extends StatelessWidget {
  PosProductShimmer({Key key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(

      itemCount: 10,
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).highlightColor,
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 5)],
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true,
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              // Product Image
              Container(
                decoration: BoxDecoration(
                  color: ColorResources.getIconBg(context),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                ),
              ),

              // Product Details
              Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 20, color: Colors.white),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Row(children: [
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Container(height: 20, width: 50, color: Colors.white),
                        ]),
                      ),
                      Container(height: 10, width: 50, color: Colors.white),
                      Icon(Icons.star, color: Colors.orange, size: 15),
                    ]),
                  ],
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
