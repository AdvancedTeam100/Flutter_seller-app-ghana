import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/top_delivery_man.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/widget/delivery_man_card.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/widget/pos_product_shimmer.dart';



class DeliveryManListView extends StatelessWidget {
  const DeliveryManListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeliveryManProvider>(
      builder: (context, prodProvider, child) {
        List<DeliveryMan> listOfDeliveryMan = [];
        listOfDeliveryMan = prodProvider.listOfDeliveryMan;


        return Column(mainAxisSize: MainAxisSize.min, children: [
          listOfDeliveryMan != null?  listOfDeliveryMan.length != 0 ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_SMALL),
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: listOfDeliveryMan.length,
              itemBuilder: (context, index) {
                return DeliveryManCardWidget(deliveryMan: listOfDeliveryMan[index]);
              },
            ),
          ): Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/5),
            child: NoDataScreen(),
          ) : PosProductShimmer(),

          prodProvider.isLoading ? Center(child: Padding(
            padding: EdgeInsets.all(Dimensions.ICON_SIZE_EXTRA_SMALL),
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
          )) : SizedBox.shrink(),

        ]);
      },
    );
  }
}
