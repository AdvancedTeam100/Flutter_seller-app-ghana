import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/cart_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/cart_provider.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/widget/product_variation_selection_dialog.dart';



class POSProductWidget extends StatefulWidget {
  final int index;
  final Product productModel;
  POSProductWidget({@required this.productModel, this.index});

  @override
  State<POSProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<POSProductWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.fromLTRB( Dimensions.PADDING_SIZE_MEDIUM, Dimensions.PADDING_SIZE_EXTRA_SMALL, Dimensions.PADDING_SIZE_MEDIUM, Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Consumer<ProductProvider>(
        builder: (context, product,_) {
          return Consumer<CartProvider>(
            builder: (context, cart,_) {

              if(cart.customerCartList != null && cart.customerCartList.isNotEmpty ){
                List<CartModel> _cart = [];
                _cart = cart.customerCartList[cart.customerIndex].cart;

                for(int i=0; i<_cart.length; i++){
                  if(widget.productModel.id == _cart[i].product.id){

                    product.setCartQuantity(_cart[i].quantity, widget.index);
                  }

                }
              }

              return GestureDetector(
                onTap: (){
                  if(widget.productModel.variation.isNotEmpty){
                    showModalBottomSheet(context: context, isScrollControlled: true,
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(0),
                        builder: (con) => CartBottomSheet(product: widget.productModel));
                  }

                },
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_SMALL),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                        boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.05),
                            spreadRadius: 1, blurRadius: 1, offset: Offset(1,2))],
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 2,
                            child: Column(
                              children: [
                                Container(decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(.10),
                                  borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),),
                                    width: Dimensions.image_size,
                                    height: Dimensions.image_size,
                                    child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                                        child: CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).
                                        baseUrls.productThumbnailUrl}/${widget.productModel.thumbnail}',
                                          width: Dimensions.image_size, height: Dimensions.image_size,))),
                                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Text(getTranslated(widget.productModel.productType, context), style: robotoRegular.copyWith(color: Theme.of(context).primaryColor),),
                                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              ],
                            ),
                          ),
                          SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),


                          Expanded(flex: 8,
                            child: Padding(padding: const EdgeInsets.all(8.0),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(widget.productModel.name ?? '', style: robotoRegular.copyWith(),
                                    maxLines: 2, overflow: TextOverflow.ellipsis),
                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),



                                Row(children: [
                                  Text(PriceConverter.convertPrice(context, widget.productModel.unitPrice,
                                      discountType: widget.productModel.discountType, discount: widget.productModel.discount),
                                    style: robotoBold.copyWith(color: ColorResources.titleColor(context)),),
                                  Expanded(child: SizedBox.shrink()),

                                ]),
                                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Row(
                                  children: [
                                    widget.productModel.discount > 0 ?
                                    Text(PriceConverter.convertPrice(context, widget.productModel.unitPrice),
                                      maxLines: 1,overflow: TextOverflow.ellipsis,
                                      style: robotoRegular.copyWith(color: ColorResources.mainCardFourColor(context),
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: Dimensions.FONT_SIZE_SMALL,
                                      ),): SizedBox.shrink(),


                                  ],
                                ),




                              ],),
                            ),
                          ),
                        ],),
                    ),
                    widget.productModel.variation.isNotEmpty?
                    Positioned(
                        right:  Provider.of<LocalizationProvider>(context, listen: false).isLtr? 10 : null, bottom: 10, left:  Provider.of<LocalizationProvider>(context, listen: false).isLtr?  null : 10,
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(Icons.add_circle, color: Theme.of(context).primaryColor,size: Dimensions.INCREMENT_BUTTON))):

                    Positioned(
                      right:  Provider.of<LocalizationProvider>(context, listen: false).isLtr? 10 : null, bottom: 10, left:  Provider.of<LocalizationProvider>(context, listen: false).isLtr?  null : 10,
                      child: Align(

                        child: Consumer<CartProvider>(
                            builder: (context,cartController,_) {
                              return Container(child: Row(children: [
                                product.cartQuantity[widget.index] > 0?
                                InkWell(

                                  onTap: (){
                                    if(product.cartQuantity[widget.index] > 1){
                                      CartModel cartModel = CartModel(widget.productModel.unitPrice, widget.productModel.discount, 1, widget.productModel.tax,null,null, widget.productModel, widget.productModel.taxModel);
                                      cartController.addToCart(context, cartModel, decreaseQuantity: true);
                                    }

                                  },
                                  child: Icon(Icons.remove_circle, color:product.cartQuantity[widget.index] > 1?
                                      Theme.of(context).colorScheme.onPrimary : Theme.of(context).hintColor,
                                      size: Dimensions.INCREMENT_BUTTON),
                                ):SizedBox(),
                                product.cartQuantity[widget.index]>0?
                                Center(child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_SMALL),
                                  child: Text(product.cartQuantity[widget.index].toString(), style: robotoRegular.copyWith()),
                                )):SizedBox(),
                                InkWell(
                                  onTap: (){
                                    CartModel cartModel = CartModel(widget.productModel.unitPrice, widget.productModel.discount, 1, widget.productModel.tax,null,null, widget.productModel, widget.productModel.taxModel);
                                    cartController.addToCart(context, cartModel);
                                  },
                                  child: Icon(Icons.add_circle, color: Theme.of(context).primaryColor,size: Dimensions.INCREMENT_BUTTON),
                                ),
                              ],),);
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          );
        }
      ),
    );
  }
}
