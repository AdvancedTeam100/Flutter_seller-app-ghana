import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/cart_model.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/provider/cart_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';



class ItemCartWidget extends StatelessWidget {
  final CartModel cartModel;
  final int index;
  const ItemCartWidget({Key key, this.cartModel, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String baseUrl = '${Provider.of<SplashProvider>(context, listen: false).configModel.baseUrls.productThumbnailUrl}';
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_MEDIUM),
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (DismissDirection direction) {
          Provider.of<CartProvider>(context, listen: false).removeFromCart(index);

        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
              boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.125),
                  spreadRadius: 0.5, blurRadius: 0.3, offset: Offset(1,2))]
          ),
          padding: const EdgeInsets.fromLTRB( Dimensions.PADDING_SIZE_EXTRA_SMALL,Dimensions.PADDING_SIZE_SMALL,0,Dimensions.PADDING_SIZE_SMALL),
          child: Column(
            children: [
              Row(children: [

                Expanded(flex: 5,
                  child: Container(child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(height: Dimensions.PRODUCT_IMAGE_SIZE,
                          width: Dimensions.PRODUCT_IMAGE_SIZE,
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_BORDER),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: CustomImage(image: '$baseUrl/${cartModel.product.thumbnail}',
                                placeholder: Images.placeholder_image,
                                fit: BoxFit.cover,
                                width: Dimensions.PRODUCT_IMAGE_SIZE,
                                height: Dimensions.PRODUCT_IMAGE_SIZE),
                          ),),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                      Expanded(child: Text('${cartModel.product.name}', maxLines: 2,overflow: TextOverflow.ellipsis,
                        style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),)),
                    ],
                  ),),
                ),

                Expanded(
                  flex: 4,
                  child: Consumer<CartProvider>(
                    builder: (context,cartController,_) {
                      return Container(child: Row(children: [

                        InkWell(
                          onTap: (){
                            cartController.setQuantity(context,false, index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Icon(Icons.remove_circle, size: Dimensions.INCREMENT_BUTTON,
                                color:cartModel.quantity>1? Theme.of(context).colorScheme.onPrimary:Theme.of(context).hintColor),
                          ),
                        ),
                        Center(child: Text(cartModel.quantity.toString(),
                          style: robotoRegular.copyWith())),
                        InkWell(
                          onTap: (){
                            cartController.setQuantity(context,true, index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Icon(Icons.add_circle, size: Dimensions.INCREMENT_BUTTON, color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],),);
                    }
                  ),
                ),

                Expanded(flex: 2,
                    child: Container(child: Text(PriceConverter.convertPrice(context, cartModel.price),
                        style: robotoRegular.copyWith()))),


              ],),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

            ],
          ),
        ),
      ),
    );
  }
}
