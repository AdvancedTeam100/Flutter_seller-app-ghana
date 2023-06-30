import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class InvoiceElementView extends StatelessWidget {
  final bool isBold;
  final String title;
  final String serial;
  final String quantity;
  final String price;
  const InvoiceElementView({
    Key key,
    this.serial,
    this.isBold = false,
    this.title,
    this.quantity,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(children: [
      Expanded(flex: 5,
        child: serial != null ? Row(mainAxisAlignment: MainAxisAlignment.start,children: [
          _textView(context, serial, isBold),
          SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

          _textView(context, title, isBold),

        ],) : Text(title, style: isBold ? robotoBold.copyWith(
          color: Theme.of(context).primaryColor,
          fontSize: Dimensions.FONT_SIZE_LARGE,
        ) : robotoRegular.copyWith(color: Theme.of(context).hintColor)),
      ),

      Expanded(flex: 3,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          quantity != null ? _textView(context, quantity, isBold) : SizedBox(),
          SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

          Text(price, style: isBold ? robotoBold.copyWith(
            fontSize: Dimensions.FONT_SIZE_LARGE,
          ) : robotoRegular.copyWith(color: Theme.of(context).hintColor)),
        ],),
      ),
    ],);
  }

  Text _textView(BuildContext context,String text, bool isBold) {
    return Text(text, style: isBold ? robotoRegular.copyWith(
            fontSize: Dimensions.FONT_SIZE_LARGE,
          ) : robotoRegular.copyWith(color: Theme.of(context).hintColor));
  }
}
