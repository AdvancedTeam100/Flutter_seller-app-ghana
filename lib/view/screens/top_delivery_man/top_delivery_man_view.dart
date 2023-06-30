import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/top_delivery_man.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/base/title_row.dart';
import 'package:sixvalley_vendor_app/view/screens/top_delivery_man/top_delivery_man_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/top_delivery_man/widget/top_delivery_man_widget.dart';



class TopDeliveryManView extends StatelessWidget {
  final bool isMain;
  const TopDeliveryManView({Key key, this.isMain = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeliveryManProvider>(
      builder: (context, deliveryProvider, child) {
        List<DeliveryMan> deliveryManList;
        deliveryManList = deliveryProvider.topDeliveryManList;


        return Column(mainAxisSize: MainAxisSize.min, children: [

          isMain?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_DEFAULT,
                vertical: Dimensions.PADDING_SIZE_SMALL),
            child: Row(
              children: [
                SizedBox(width: Dimensions.ICON_SIZE_DEFAULT, child: Image.asset(Images.top_delivery_man)),
                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Expanded(
                  child: TitleRow(title: '${getTranslated('top_delivery_man', context)}',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TopDeliveryMAnScreen()))),
                ),
              ],
            ),
          ):SizedBox(),

          !deliveryProvider.isLoading ? deliveryManList.length != 0 ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_SMALL,
                vertical: Dimensions.PADDING_SIZE_SMALL),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: MediaQuery.of(context).size.width < 400? 1/1.12: MediaQuery.of(context).size.width < 420? 1/.97 : 1/.95,
              ),
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: isMain && deliveryManList.length > 4 ? 4: deliveryManList.length,
              itemBuilder: (context, index) {

                return TopDeliveryManWidget(deliveryMan : deliveryManList[index]);
              },
            ),
          ): NoDataScreen() :SizedBox.shrink(),

          deliveryProvider.isLoading ? Center(child: Padding(
            padding: EdgeInsets.all(Dimensions.ICON_SIZE_EXTRA_SMALL),
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
          )) : SizedBox.shrink(),

        ]);
      },
    );
  }
}
