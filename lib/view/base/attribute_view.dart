
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/shop_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';

import 'custom_button.dart';
import 'custom_snackbar.dart';


class AttributeView extends StatefulWidget {
  final Product product;
  final bool colorOn;
  final bool onlyQuantity;
  AttributeView({@required this.product, @required this.colorOn, this.onlyQuantity = false});

  @override
  State<AttributeView> createState() => _AttributeViewState();
}

class _AttributeViewState extends State<AttributeView> {
  bool colorONOFF;
  int addVar = 0;

  void _load(){
    Provider.of<SellerProvider>(context,listen: false).selectedColor;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _load();
  }


  @override
  Widget build(BuildContext context) {
    colorONOFF = widget.colorOn;
    return Consumer<SellerProvider>(
      builder: (context, resProvider, child){




        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
          widget.onlyQuantity?SizedBox():
          Text(getTranslated('other_attributes', context),
              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

          widget.onlyQuantity?SizedBox():
          SizedBox(height: 50,
            child: resProvider.attributeList.length> 0 ?
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: resProvider.attributeList.length,
              itemBuilder: (context, index) {
                if(index == 0 && widget.colorOn){
                  return SizedBox();
                }

                return InkWell(
                  onTap: () => resProvider.toggleAttribute(context,index, widget.product),
                  child: Container(
                    width: 100, alignment: Alignment.center,
                    margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    decoration: BoxDecoration(
                      color: resProvider.attributeList[index].active ?
                      Theme.of(context).primaryColor : Theme.of(context).hintColor.withOpacity(.10),
                      borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    ),
                    child: Text(
                      resProvider.attributeList[index].attribute.name, maxLines: 2, textAlign: TextAlign.center,
                      style: robotoRegular.copyWith(
                        color: resProvider.attributeList[index].active ?
                        Theme.of(context).cardColor : Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                );
              },
            ):SizedBox(),
          ),
          SizedBox(height: resProvider.attributeList.where((element) => element.active).length > 0 ?
          Dimensions.PADDING_SIZE_LARGE : 0),
          widget.onlyQuantity?SizedBox():
          resProvider.attributeList.length>0?
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: resProvider.attributeList.length,
            itemBuilder: (context, index) {
              return (resProvider.attributeList[index].active && index != 0) ?
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resProvider.attributeList[index].attribute.name, maxLines: 2, textAlign: TextAlign.center,
                      style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                    Row(children: [

                      Expanded(child: CustomTextField(
                        border: true,
                        controller: resProvider.attributeList[index].controller,
                        textInputAction: TextInputAction.done,
                        capitalization: TextCapitalization.words,
                        // title: false,
                      )),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                      Container(height: 50, width : 80,
                        child: CustomButton(
                          onTap: () {
                            String _variant = resProvider.attributeList[index].controller.text.trim();
                            if(_variant.isEmpty) {
                              showCustomSnackBar(getTranslated('enter_a_variant_name', context),context);
                            }else {
                              resProvider.attributeList[index].controller.text = '';
                              resProvider.addVariant(context,index, _variant, widget.product, true);
                            }
                          },
                          btnTxt: 'Add',
                        ),
                      ),

                    ]),
                  ],
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                Container(
                  height: 30,
                  child: resProvider.attributeList[index].variants.length > 0? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    itemCount: resProvider.attributeList[index].variants.length,
                    itemBuilder: (context, i) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_MEDIUM),
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
                          Text(resProvider.attributeList[index].variants[i], style: robotoRegular),
                          SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                          InkWell(
                            onTap: () => resProvider.removeVariant(context,index, i, widget.product),
                            child: Icon(Icons.close, size: 15),
                          ),
                        ]),
                      );
                    },
                  ):Align(
                      alignment: Alignment.centerLeft,
                      child: Text(getTranslated('no_variant_added_yet', context),
                        style: robotoRegular.copyWith(color: ColorResources.mainCardFourColor(context).withOpacity(.8)),)),
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              ]) : SizedBox();
            },
          ):SizedBox(),

          widget.onlyQuantity?SizedBox():
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
          resProvider.variantTypeList.length>0?
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                  flex: 4,
                  child: Text(getTranslated('variant',context),
                    style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                        color: Theme.of(context).disabledColor),
                  ),
                ),
                widget.onlyQuantity?SizedBox():
                Expanded(
                  flex: 4,
                  child: Text(getTranslated('price',context),
                      style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: Theme.of(context).disabledColor)),
                ),


                Expanded(
                  flex: widget.onlyQuantity ? 3 : 4,
                  child: Text(getTranslated('quantity',context),
                    style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                        color: Theme.of(context).disabledColor),),
                ),
              ],):SizedBox.shrink(),
          SizedBox(height:    resProvider.variantTypeList.length>0? Dimensions.PADDING_SIZE_DEFAULT : 0),

          resProvider.variantTypeList.length>0?
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: resProvider.variantTypeList.length,
            itemBuilder: (context, index) {

              return Padding(
                padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Expanded(flex: 4, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                    Text(
                      resProvider.variantTypeList[index].variantType,
                      overflow: TextOverflow.ellipsis,
                      style: robotoRegular.copyWith(color: ColorResources.titleColor(context)), maxLines: 2,
                    ),
                  ])),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                      widget.onlyQuantity?SizedBox():
                  Expanded(flex: 4, child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      CustomTextField(
                        variant: true,
                        border: true,
                        hintText: 'Ex: \$234',
                        controller: resProvider.variantTypeList[index].controller,
                        focusNode: resProvider.variantTypeList[index].node,
                        nextNode: index != resProvider.variantTypeList.length-1 ? resProvider.variantTypeList[index+1].node : null,
                        textInputAction: index != resProvider.variantTypeList.length-1 ? TextInputAction.next : TextInputAction.done,
                        isAmount: true,
                        textInputType: TextInputType.number,
                        amountIcon: true,
                      ),
                    ],
                  )),
                  SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                  Expanded(flex: 4, child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      CustomTextField(
                        variant: true,
                        border: true,
                        hintText: 'Ex: 345',
                        controller: resProvider.variantTypeList[index].qtyController,
                        focusNode: resProvider.variantTypeList[index].qtyNode,
                        nextNode: index != resProvider.variantTypeList.length-1 ? resProvider.variantTypeList[index+1].node : null,
                        textInputAction: index != resProvider.variantTypeList.length-1 ? TextInputAction.next : TextInputAction.done,
                        isAmount: true,
                        amountIcon: false,
                        textInputType: TextInputType.number,
                      ),
                    ],
                  )),

                ]),
              );
            },
          ):SizedBox(),
          SizedBox(height: resProvider.hasAttribute() ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0),

        ]);
      },
    );
  }
}
