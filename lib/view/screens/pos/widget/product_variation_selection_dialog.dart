
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/cart_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/cart_provider.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';

class CartBottomSheet extends StatefulWidget {
  final Product product;
  final Function callback;
  CartBottomSheet({@required this.product, this.callback});

  @override
  _CartBottomSheetState createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {

  route(bool isRoute, String message) async {
    if (isRoute) {
      showCustomSnackBar(message, context, isError: false);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      showCustomSnackBar(message, context);

    }
  }
  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).initData(widget.product,widget.product.minimumOrderQty, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          child: Consumer<ProductProvider>(
            builder: (ctx, productProvider, child) {

              Variation _variation;
              String _variantName = widget.product.colors.length != 0 ? widget.product.colors[productProvider.variantIndex].name : null;
              List<String> _variationList = [];
              for(int index=0; index < widget.product.choiceOptions.length; index++) {
                _variationList.add(widget.product.choiceOptions[index].options[productProvider.variationIndex[index]].trim());

              }
              String variationType = '';
              if(_variantName != null) {
                variationType = _variantName;
                _variationList.forEach((variation) => variationType = '$variationType-$variation');
              }else {

                bool isFirst = true;
                _variationList.forEach((variation) {
                  if(isFirst) {
                    variationType = '$variationType$variation';
                    isFirst = false;
                  }else {
                    variationType = '$variationType-$variation';
                  }
                });
              }
              double price = widget.product.unitPrice;
              int _stock = widget.product.currentStock;
              variationType = variationType.replaceAll(' ', '');
              for(Variation variation in widget.product.variation) {
                if(variation.type == variationType) {
                  price = variation.price;
                  _variation = variation;
                  _stock = variation.qty;
                  break;
                }
              }
              print('-------variation--------${_variation.type}');
              double priceWithDiscount = PriceConverter.convertWithDiscount(context, price, widget.product.discount, widget.product.discountType);
              double priceWithQuantity = priceWithDiscount * productProvider.quantity;

              double total = 0, avg = 0;
              widget.product.reviews.forEach((review) {
                total += review.rating;
              });
              avg = total /widget.product.reviews.length;
              print('avarage=>$avg');

              String ratting = widget.product.reviews != null && widget.product.reviews.length != 0?
              avg.toString() : "0";

              return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                // Close Button
                Align(alignment: Alignment.centerRight, child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(width: 25, height: 25,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).highlightColor, boxShadow: [BoxShadow(
                      color: Theme.of(context).hintColor, spreadRadius: 1, blurRadius: 5,)]),
                    child: Icon(Icons.clear, size: Dimensions.ICON_SIZE_SMALL),
                  ),
                )),



                Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Container(width: 100, height: 100,
                        decoration: BoxDecoration(color: ColorResources.getImageBg(context),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: .5,color: Theme.of(context).primaryColor.withOpacity(.20))),
                        child: ClipRRect(borderRadius: BorderRadius.circular(5),
                            child: CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.productThumbnailUrl}/${widget.product.thumbnail}')),),
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),


                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(widget.product.name ?? '',
                              style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                              maxLines: 2, overflow: TextOverflow.ellipsis),

                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          Row(children: [
                            Icon(Icons.star,color: Colors.orange),
                            Text(double.parse(ratting).toStringAsFixed(1),
                                style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                                maxLines: 2, overflow: TextOverflow.ellipsis),
                          ],
                          ),
                        ]),
                        ),
                      ]),

                  Row(children: [
                    widget.product.discount > 0 ?
                    Container(margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color:Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(PriceConverter.percentageCalculation(context, widget.product.unitPrice,
                            widget.product.discount, widget.product.discountType),
                          style: titilliumRegular.copyWith(color: Theme.of(context).cardColor,
                              fontSize: Dimensions.FONT_SIZE_DEFAULT))),
                    ) : SizedBox(width: 93),


                    SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                    widget.product.discount > 0 ?
                    Text(PriceConverter.convertPrice(context, widget.product.unitPrice),
                      style: titilliumRegular.copyWith(color: ColorResources.getRed(context),
                          decoration: TextDecoration.lineThrough)) : SizedBox(),

                    SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                    Text(PriceConverter.convertPrice(context, widget.product.unitPrice,
                        discountType: widget.product.discountType, discount: widget.product.discount),
                          style: titilliumRegular.copyWith(color: ColorResources.getPrimary(context),
                              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)),

                  ],
                  ),
                ],),


                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                widget.product.colors.length > 0 ?
                Row( children: [
                  Text('${getTranslated('select_variant', context)} : ',
                      style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                  SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      itemCount: widget.product.colors.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        String colorString = '0xff' + widget.product.colors[index].code.substring(1, 7);
                        return InkWell(
                          onTap: () {
                            Provider.of<ProductProvider>(context, listen: false).setCartVariantIndex(widget.product.minimumOrderQty, index, context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                border: productProvider.variantIndex == index ? Border.all(width: 1,
                                    color: Theme.of(context).primaryColor):null
                            ),
                            child: Padding(padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),

                              child: Container(height: Dimensions.topSpace, width: Dimensions.topSpace,
                                padding: EdgeInsets.all( Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(int.parse(colorString)),
                                  borderRadius: BorderRadius.circular(5),),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ]) : SizedBox(),
                widget.product.colors.length > 0 ? SizedBox(height: Dimensions.PADDING_SIZE_SMALL) : SizedBox(),


                // Variation
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.product.choiceOptions.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Text('${getTranslated('available', context)} '+' '+'${widget.product.choiceOptions[index].title} : ',
                          style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                      SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),


                      Expanded(
                        child: Padding(padding: const EdgeInsets.all(2.0),
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: (1 / .7),
                            ),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.product.choiceOptions[index].options.length,
                            itemBuilder: (ctx, i) {
                              return InkWell(
                                onTap: () => Provider.of<ProductProvider>(context, listen: false).setCartVariationIndex(widget.product.minimumOrderQty, index, i, context),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: productProvider.variationIndex[index] == i? Theme.of(context).primaryColor: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(5),
                                    border: productProvider.variationIndex[index] != i ?  Border.all(color: Theme.of(context).hintColor,):
                                    Border.all(color: Theme.of(context).primaryColor,),),
                                  child: Center(
                                    child: Text(widget.product.choiceOptions[index].options[i].trim(), maxLines: 1,
                                        overflow: TextOverflow.ellipsis, style: titilliumRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                          color: productProvider.variationIndex[index] != i ?
                                          ColorResources.getTextTitle(context) : Colors.white,
                                        )),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ]);
                  },
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),


                // Quantity
                Row(children: [
                  Text(getTranslated('quantity', context), style: robotoBold),
                  QuantityButton(isIncrement: false, quantity: productProvider.quantity,
                      stock: _stock, minimumOrderQuantity: widget.product.minimumOrderQty,
                      digitalProduct: widget.product.productType == "digital"),
                  Text(productProvider.quantity.toString(), style: titilliumSemiBold),
                  QuantityButton(isIncrement: true, quantity: productProvider.quantity, stock: _stock,
                      minimumOrderQuantity: widget.product.minimumOrderQty,
                      digitalProduct: widget.product.productType == "digital"),
                ]),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(getTranslated('total_price', context), style: robotoBold),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                  Text(PriceConverter.convertPrice(context, priceWithQuantity),
                    style: titilliumBold.copyWith(color: ColorResources.getPrimary(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                  ),
                ]),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                CustomButton(btnTxt: getTranslated(_stock < widget.product.minimumOrderQty && widget.product.productType == "physical"?
                'out_of_stock' : 'add_to_cart', context),
                    onTap: _stock < widget.product.minimumOrderQty  &&  widget.product.productType == "physical" ? null :() {
                      if(_stock >= widget.product.minimumOrderQty  || widget.product.productType == "digital") {
                        CartModel cart = CartModel(widget.product.unitPrice, widget.product.discount, 1, widget.product.tax,_variation.type, _variation, widget.product, widget.product.taxModel);
                          Provider.of<CartProvider>(context, listen: false).addToCart(context, cart);
                          Navigator.pop(context);
                      }}),
                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
              ]);
            },
          ),
        ),
      ],
    );
  }

}

class QuantityButton extends StatelessWidget {
  final bool isIncrement;
  final int quantity;
  final bool isCartWidget;
  final int stock;
  final int minimumOrderQuantity;
  final bool digitalProduct;

  QuantityButton({
    @required this.isIncrement,
    @required this.quantity,
    @required this.stock,
    this.isCartWidget = false,@required this.minimumOrderQuantity,@required this.digitalProduct,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (!isIncrement && quantity > 1 ) {
          if(quantity > minimumOrderQuantity ) {
            Provider.of<ProductProvider>(context, listen: false).setQuantity(quantity - 1);
          }else{
            Fluttertoast.showToast(
                msg: '${getTranslated('minimum_quantity_is', context)}$minimumOrderQuantity',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        } else if (isIncrement && quantity < stock || digitalProduct) {
          Provider.of<ProductProvider>(context, listen: false).setQuantity(quantity + 1);
        }

      },
      icon: Container(
        width: 40,height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: Theme.of(context).primaryColor)
        ),
        child: Icon(
          isIncrement ? Icons.add : Icons.remove,
          color: isIncrement ? quantity >= stock && !digitalProduct? ColorResources.getLowGreen(context) : ColorResources.getPrimary(context)
              : quantity > 1
              ? ColorResources.getPrimary(context)
              : ColorResources.getTextTitle(context),
          size: isCartWidget?26:20,
        ),
      ),
    );
  }
}


