import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/shipping_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';

class DropDownForShippingTypeWidget extends StatelessWidget {
  const DropDownForShippingTypeWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT, 0),
      child: Consumer<ShippingProvider>(
        builder: (context, shippingProvider, _) {
          return Container(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              border: Border.all(width: .5, color: Theme.of(context).hintColor.withOpacity(.7)),
            ),
            child: DropdownButton<String>(
              value: shippingProvider.selectedShippingTypeName,
              items: shippingProvider.shippingType.map((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(getTranslated(value, context)));
              }).toList(),
              onChanged: (val) {
                shippingProvider.setShippingTypeIndex(context, val == 'category_wise'? 0: val == 'order_wise'?1:2);
              },
              isExpanded: true,
              underline: SizedBox(),
            ),
          );
        }
      ),
    );
  }
}
