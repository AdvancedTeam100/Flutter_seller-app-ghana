
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/provider/shipping_provider.dart';
import 'package:sixvalley_vendor_app/provider/shop_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/attribute_view.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';


class QuantityUpdateDialog extends StatefulWidget {
  final String title;
  final Function onYesPressed;
  final TextEditingController note;
  final TextEditingController stockQuantityController;
  final Product product;
  QuantityUpdateDialog({this.title, @required this.onYesPressed, this.note, this.product, this.stockQuantityController});

  @override
  State<QuantityUpdateDialog> createState() => _QuantityUpdateDialogState();
}

class _QuantityUpdateDialogState extends State<QuantityUpdateDialog> {


  int addColor = 0;

  void _load(){
    String languageCode = Provider.of<LocalizationProvider>(context, listen: false).locale.countryCode == 'US'?
    'en':Provider.of<LocalizationProvider>(context, listen: false).locale.countryCode.toLowerCase();
    Provider.of<SplashProvider>(context,listen: false).getColorList();
    Provider.of<SellerProvider>(context,listen: false).getAttributeList(context, widget.product, languageCode);
  }

  @override
  void initState() {
    _load();
    widget.stockQuantityController.text = widget.product.currentStock.toString();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Consumer<SellerProvider>(
          builder: (context, resProvider, child) {
            List<int> _colors = [];
            _colors.add(0);


            if (Provider.of<SellerProvider>(context, listen: false).attributeList != null &&
                Provider.of<SellerProvider>(context, listen: false).attributeList.length > 0) {
              if(addColor==0) {
                addColor++;
                if ( widget.product.colors != null && widget.product.colors.length > 0) {
                  Future.delayed(Duration.zero, () async {
                    Provider.of<SellerProvider>(context, listen: false).setAttribute();
                  });
                }
                for (int index = 0; index < widget.product.colors.length; index++) {
                  _colors.add(index);
                  Future.delayed(Duration.zero, () async {
                    resProvider.addVariant(context,0, widget.product.colors[index].name, widget.product, false);
                    resProvider.addColorCode(widget.product.colors[index].code);
                  });
                }
              }

            }


            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                child: Column(mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_DEFAULT),
                          child: Column(mainAxisSize: MainAxisSize.min, children: [


                             Padding(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                              child: Text(
                                widget.title, textAlign: TextAlign.center,
                                style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                              ),
                            ),

                            resProvider.attributeList != null?
                            AttributeView(product: widget.product, colorOn: resProvider.attributeList[0].active, onlyQuantity: true):CircularProgressIndicator(),


                            Container(margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE, right: Dimensions.PADDING_SIZE_LARGE,
                                bottom: Dimensions.PADDING_SIZE_SMALL),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text(getTranslated('total_quantity', context),
                                      style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  CustomTextField(
                                    border: true,
                                    textInputType: TextInputType.number,
                                    controller: widget.stockQuantityController,
                                    textInputAction: TextInputAction.next,
                                    isAmount: true,
                                    hintText: 'Ex: 500',
                                  ),
                                ],)),


                            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                            Consumer<ShippingProvider>(builder: (context, shippingProvider, child) {
                              return !shippingProvider.isLoading ? Padding(
                                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                                child: Container(height: 40,
                                  child: CustomButton(
                                    borderRadius: 10,
                                    btnTxt: getTranslated('update_quantity',context),
                                    onTap: () =>  widget.onYesPressed(),
                                  ),
                                ),
                              ) : Center(child: CircularProgressIndicator());
                            }),
                          ]),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Padding(
                              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                              child: Container(width: 18,child: Image.asset(Images.cross)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        ));
  }
}