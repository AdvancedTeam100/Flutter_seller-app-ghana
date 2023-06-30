import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/provider/cart_provider.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/provider/bottom_menu_provider.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/provider/product_review_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonExist;
  final Function onBackPressed;
  final Function filter;
  final Function switchAction;
  final bool isAction;
  final bool isSwitch;
  final bool isCart;
  final bool activeProduct;
  final bool activeDelivery;
  final bool productSwitch;
  final bool reviewSwitch;
  final int index;
  final bool isTooltip;
  final Widget widget;
  CustomAppBar({@required this.title,
    this.isBackButtonExist = true,
    this.onBackPressed,
    this.isAction = false,
    this.filter,
    this.isSwitch = false,
    this.switchAction,
    this.isCart = false,
    this.activeProduct = false,
    this.productSwitch = false,
    this.activeDelivery = false,
    this.reviewSwitch = false,
    this.index,
    this.isTooltip = false, this.widget});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).primaryColor.withOpacity(0):
          Theme.of(context).primaryColor.withOpacity(.10),
            offset: Offset(0, 2.0), blurRadius: 4.0,
          )
        ]),
        child: AppBar(
          shadowColor: Theme.of(context).primaryColor.withOpacity(.5),
          titleSpacing: 0,
          title: Text(title, style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
              color: Theme.of(context).textTheme.bodyText1.color)),
          centerTitle: true,
          leading: isBackButtonExist ? IconButton(icon: Icon(Icons.arrow_back_ios, size: Dimensions.ICON_SIZE_DEFAULT),
              color: Theme.of(context).textTheme.bodyText1.color,
            onPressed: () => onBackPressed != null ? onBackPressed() : Navigator.pop(context)) :
          IconButton(icon: Image.asset(Images.logo, color : Theme.of(context).primaryColor,scale: 5,), onPressed: () {  },),
          backgroundColor: Theme.of(context).highlightColor,
          elevation: 0,
          actions: isAction? [
            isSwitch?
            Consumer<ProductProvider>(
              builder: (context, details,_) {
                return Consumer<DeliveryManProvider>(
                  builder: (context, delivery,_) {
                    return Consumer<ProductReviewProvider>(
                      builder: (context, productReview,_) {
                        return Padding(
                          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          child: FlutterSwitch(width: 40,height: 22,toggleSize: 18,
                              padding: 2,
                              value: productSwitch? details.productDetails?.status == 1 :
                              reviewSwitch? productReview.reviewList[index].status==1 :
                              delivery.deliveryManDetails?.deliveryMan?.isActive == 1,
                              onToggle: switchAction),
                        );
                      }
                    );
                  }
                );
              }
            ):
                isCart?
                Consumer<CartProvider>(
                    builder: (context, cartController, _) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: IconButton(
                          onPressed: () {

                            Provider.of<BottomMenuController>(context, listen: false).selectHomePage();
                          },
                          icon: Stack(clipBehavior: Clip.none, children: [
                            Image.asset(
                              Images.cart,
                              height: Dimensions.ICON_SIZE_DEFAULT,
                              width: Dimensions.ICON_SIZE_DEFAULT,
                              color: Theme.of(context).primaryColor,
                            ),
                            Positioned(top: -4, right: -4,
                              child: CircleAvatar(radius: 7, backgroundColor: Colors.green,
                                child: Text('${cartController.customerCartList.isNotEmpty?cartController.customerCartList[cartController.customerIndex].cart.length : 0}',
                                    style: robotoRegular.copyWith(color: Theme.of(context).cardColor,
                                    fontSize: Dimensions.FONT_SIZE_SMALL)), ),
                            ),
                          ],),
                        ),
                      );
                    }
                ) :
                isTooltip?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                  child: widget,
                ):
            SizedBox()
          ]: [],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 50);
}
