import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/shipping_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/shipping/widget/category_wise_shipping_card.dart';
import 'package:sixvalley_vendor_app/view/screens/shipping/widget/drop_down_for_shipping_type.dart';



class CategoryWiseShippingScreen extends StatefulWidget {
  const CategoryWiseShippingScreen({Key key}) : super(key: key);

  @override
  State<CategoryWiseShippingScreen> createState() => _CategoryWiseShippingScreenState();
}

class _CategoryWiseShippingScreenState extends State<CategoryWiseShippingScreen> {

  @override
  void initState() {
   Provider.of<ShippingProvider>(context, listen: false).setShippingCost();
   Provider.of<ShippingProvider>(context, listen: false).iniType('category_wise');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Provider.of<ShippingProvider>(context,listen: false).getCategoryWiseShippingMethod(context);
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('shipping_method', context),),
      body: Column(
        children: [
          DropDownForShippingTypeWidget(),
          Expanded(
            child: Consumer<ShippingProvider>(
              builder: (context, shipProv, child) {
                return  Stack(
                  children: [
                    Column(
                      children: [
                        shipProv.categoryWiseShipping !=null ? shipProv.categoryWiseShipping.length > 0 ?
                        Expanded(
                            child: Padding(
                              padding:  EdgeInsets.only(bottom: 80, top: Dimensions.PADDING_SIZE_SMALL),
                              child: ListView.builder(
                                itemCount: shipProv.categoryWiseShipping.length,
                                itemBuilder: (context, index){
                                  return CategoryWiseShippingCard(shipProv: shipProv,index: index,category: shipProv.categoryWiseShipping[index].category);
                                }

                              ),
                            ))
                            : Expanded(child: NoDataScreen())
                            : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))
                      ],
                    ),
                    Positioned(bottom: 10,left: 20,right: 20,
                        child:shipProv.isLoading?
                        Container(width:30, height: 40,child: Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor))) :
                        CustomButton(borderRadius: 12,
                          fontColor: Colors.white,
                          btnTxt: getTranslated('save_update', context),
                          onTap: (){
                          List<int> _ids= [];
                          List<double> _cost= [];
                          List<int> _isMulti= [];
                          shipProv.shippingCostController.forEach((cost) {
                            _cost.add(double.parse(cost.text.trim().toString()));
                          });
                          _ids = shipProv.ids;
                          _isMulti = shipProv.isMultiplyInt;
                          shipProv.setCategoryWiseShippingCost(context, _ids, _cost, _isMulti).then((value) {
                            if(value.response.statusCode==200){
                              shipProv.getCategoryWiseShippingMethod(context);
                            }
                          });

                        },))
                  ],
                );
              }

            ),
          ),
        ],
      ),
    );
  }
}
