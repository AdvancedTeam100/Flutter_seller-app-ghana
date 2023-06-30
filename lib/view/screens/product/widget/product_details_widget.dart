import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/provider/shop_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/see_more_button.dart';
import 'package:sixvalley_vendor_app/view/screens/shop/widget/shop_product_card.dart';

class ProductDetailsWidget extends StatefulWidget {
  final Product productModel;
  const ProductDetailsWidget({Key key, this.productModel}) : super(key: key);

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  ScrollController _controller;
  String message = "";
  bool activated = false;
  bool endScroll = false;
  _onStartScroll(ScrollMetrics metrics) {
    setState(() {
      message = "start";
    });
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    setState(() {
      message = "scrolling";
    });
  }

  _onEndScroll(ScrollMetrics metrics) {
    setState(() {
      message = "end";
    });
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange) {
      setState(() {
        endScroll = true;
        message = "bottom";
        print('============$message=========');
      });
    }

  }
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    print('============$message=========');
    super.initState();
  }
  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(message);
    if(message == 'end' && !endScroll){
      Future.delayed(const Duration(seconds: 10), () {
        if (this.mounted) {
          setState(() {
            activated = true;
          });
        }
      });
    }else{
      activated = false;
    }

    return Consumer<SellerProvider>(
      builder: (context, categoryProvider,_) {
        String category = '';
        if(categoryProvider.categoryList != null && categoryProvider.categoryList.isNotEmpty){
        for(int i=0; i< categoryProvider.categoryList.length; i++){
          if(widget.productModel.categoryIds[0].id == categoryProvider.categoryList[i].id.toString()){
            category = categoryProvider.categoryList[i].name;
          }
        }

        }

        return RefreshIndicator(
          onRefresh: () async{
            Provider.of<ProductProvider>(context, listen: false).getProductDetails(context, widget.productModel.id);
            Provider.of<SellerProvider>(context,listen: false).getCategoryList(context,null, 'en');
          },
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollStartNotification) {
                _onStartScroll(scrollNotification.metrics);
              } else if (scrollNotification is ScrollUpdateNotification) {
                _onUpdateScroll(scrollNotification.metrics);
              } else if (scrollNotification is ScrollEndNotification) {
                _onEndScroll(scrollNotification.metrics);
              }
              return false;
            },
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    children: [
                      ShopProductWidget(productModel: widget.productModel, isDetails: true),
                      Container(

                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          boxShadow: [BoxShadow(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).primaryColor.withOpacity(0):
                          Theme.of(context).primaryColor.withOpacity(.125), blurRadius:1, spreadRadius: 1, offset: Offset(1,2))]
                        ),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_MEDIUM, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_SMALL),
                            child: Text(getTranslated('product_specification', context), style: robotoMedium,),
                          ),

                          Row(children: [
                            Expanded(flex: 4,child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              CustomText(title: 'purchase_price'),
                              CustomText(title: 'selling_price'),
                              CustomText(title: 'tax'),
                              CustomText(title: 'taxModel'),
                              CustomText(title: 'discount'),
                              widget.productModel.productType == 'physical'?
                              CustomText(title: 'current_stock'):SizedBox.shrink(),
                              CustomText(title: 'category'),
                              // CustomText(title: 'sub_category'),
                              CustomText(title: 'product_type'),
                              widget.productModel.productType == 'physical'?
                              CustomText(title: 'shipping_cost'):SizedBox.shrink(),
                            ])), Container(transform: Matrix4.translationValues(0, 4, 0),
                              height:widget.productModel.productType == 'physical'? 345: 255, width: .25, color: Theme.of(context).hintColor,),

                            Expanded(flex: 8,child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              CustomText(amount: widget.productModel.purchasePrice, amountValue: true,),
                              CustomText(amount: widget.productModel.unitPrice, amountValue: true,),
                              CustomText(title: widget.productModel.tax.toString(), isPercentage: true, isLocale: false,),
                              CustomText(title: widget.productModel.taxModel, isPercentage: false, isLocale: true,),
                              CustomText(amount: widget.productModel.discount, isLocale: false,
                                  title: widget.productModel.discountType == 'percent'? widget.productModel.discount.toString():'0',
                                  amountValue: widget.productModel.discountType == 'flat',isPercentage: widget.productModel.discountType == 'percent'),
                              widget.productModel.productType == 'physical'?
                              CustomText(title: widget.productModel.productType == 'physical'? widget.productModel.currentStock.toString() : getTranslated('digital', context), isLocale: false,):SizedBox(),
                              CustomText(title: category, isLocale: false,),
                              // CustomText(title: subCategory, isLocale: false,),
                              CustomText(title:  widget.productModel.productType),
                              widget.productModel.productType == 'physical'?
                              CustomText(amount: widget.productModel.shippingCost, amountValue: true):SizedBox.shrink(),

                         ])),
                       ],)
                      ],),),

                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.125), blurRadius:1, spreadRadius: 1, offset: Offset(1,2))]
                        ),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_MEDIUM, Dimensions.PADDING_SIZE_DEFAULT, 0),
                            child: Text(getTranslated('description', context), style: robotoBold,),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_SMALL, 0, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_SMALL),
                            child: Html(data: widget.productModel.details,
                              tagsList: Html.tags,
                              customRenders: {
                                tableMatcher(): tableRender(),
                              },
                              style: {
                              "table": Style(
                                  backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                                ),
                                "tr": Style(
                                  border: Border(bottom: BorderSide(color: Colors.grey)),
                                ),
                                "th": Style(
                                  padding: EdgeInsets.all(6),
                                  backgroundColor: Colors.grey,
                                ),
                                "td": Style(
                                  padding: EdgeInsets.all(6),
                                  alignment: Alignment.topLeft,
                                ),

                              },),
                          ),
                        ],
                      ),)

                    ],
                  ),
                ),
                activated?
                SeeMoreButton(): SizedBox(),

              ],
            ),
          ),
        );
      }
    );
  }
}

class CustomText extends StatelessWidget {
  final String title;
  final double amount;
  final bool amountValue;
  final bool isLocale;
  final bool isPercentage;
  const CustomText({Key key, this.title, this.amountValue = false, this.amount,
    this.isLocale = true, this.isPercentage = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Divider(thickness: 1,),
        SizedBox(height: 28,
          child: Padding(
            padding:  EdgeInsets.only(left: Provider.of<LocalizationProvider>(context).isLtr? Dimensions.ICON_SIZE_DEFAULT :0,
                right: Provider.of<LocalizationProvider>(context).isLtr ? 0: Dimensions.ICON_SIZE_DEFAULT),
            child: amountValue?
            Text('${PriceConverter.convertPrice(context, amount)}'):
            isLocale?
            Text(getTranslated(title, context)):
            isPercentage?
            Text('$title%'):
            Text(title),
          ),
        ),


      ],
    );
  }
}
