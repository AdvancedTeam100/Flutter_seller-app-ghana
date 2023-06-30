import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/cart_provider.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/provider/product_review_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_date_picker.dart';
import 'package:sixvalley_vendor_app/view/base/custom_drop_down_item.dart';




class ReviewFilterBottomSheet extends StatefulWidget {
  const ReviewFilterBottomSheet({Key key}) : super(key: key);

  @override
  State<ReviewFilterBottomSheet> createState() => _ReviewFilterBottomSheetState();
}

class _ReviewFilterBottomSheetState extends State<ReviewFilterBottomSheet> {

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Consumer<ProductReviewProvider>(
        builder: (context, reviewProvider,_) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.PADDING_SIZE_DEFAULT),
                  topRight: Radius.circular(Dimensions.PADDING_SIZE_DEFAULT))
            ),

            child: Column(mainAxisSize: MainAxisSize.min,
              children: [

                Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT,
                  top: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                  child: Text(getTranslated('filter_date', context), style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),),
                ),

                CustomDropDownItem(
                    widget: Consumer<ProductProvider>(
                        builder: (context, product,_) {
                          return DropdownButton<int>(
                            value: product.reviewProductIndex,
                            items: product.reviewProductIds.map((int value) {
                              return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(product.sellerProductList[(product.reviewProductIds.indexOf(value))].name));}).toList(),
                            onChanged: (int value) {
                              product.setReviewProductIndex(value,product.sellerProductList[(product.reviewProductIds.indexOf(value))].id, true);
                            },
                            isExpanded: true, underline: SizedBox(),);
                        }
                    )

                ),
                CustomDropDownItem(
                  widget: Consumer<CartProvider>(
                    builder: (context, customer,_) {
                      return DropdownButton<int>(
                        value: customer.reviewCustomerIndex,
                        items: customer.reviewCustomerIds.map((int value) {
                          return DropdownMenuItem<int>(
                              value: value,
                              child: Text(customer.searchedCustomerList[(customer.reviewCustomerIds.indexOf(value))].fName + ' '+ customer.searchedCustomerList[(customer.reviewCustomerIds.indexOf(value))].lName));}).toList(),
                        onChanged: (int value) {
                          customer.setReviewCustomerIndex(value,customer.searchedCustomerList[(customer.reviewCustomerIds.indexOf(value))].id, true);
                        },
                        isExpanded: true, underline: SizedBox(),);
                    }
                  ),
                ),
                CustomDropDownItem(
                  widget: DropdownButtonFormField<String>(
                    value: reviewProvider.reviewStatusName,
                    isExpanded: true,
                    decoration: InputDecoration(border: InputBorder.none),
                    iconSize: 24, elevation: 16, style: robotoRegular,
                    onChanged: (value){
                      reviewProvider.setReviewStatusIndex(value == 'select_status'?0:value == 'Active'? 1:2);
                    },
                    items: reviewProvider.reviewStatusList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(getTranslated(value, context),
                            style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyText1.color)),
                      );
                    }).toList(),
                  ),

                ),

                Row(children: [
                  Expanded(child: CustomDatePicker(
                    title: getTranslated('from', context),
                    image: Images.calender_icon,
                    text: reviewProvider.startDate != null ?
                    reviewProvider.dateFormat.format(reviewProvider.startDate).toString() : getTranslated('select_date', context),
                    selectDate: () => reviewProvider.selectDate("start", context),
                  )),
                  Expanded(child: CustomDatePicker(
                    title: getTranslated('to', context),
                    image: Images.calender_icon,
                    text: reviewProvider.endDate != null ?
                    reviewProvider.dateFormat.format(reviewProvider.endDate).toString() : getTranslated('select_date', context),
                    selectDate: () => reviewProvider.selectDate("end", context),
                  )),
                ],),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: CustomButton(btnTxt: getTranslated('search', context),
                  onTap: (){
                    int  productId = Provider.of<ProductProvider>(context, listen: false).selectedProductId;
                    int  customerId = Provider.of<CartProvider>(context, listen: false).selectedCustomerIdForReviewFilter;
                    reviewProvider.filterReviewList(context, productId, customerId);
                  },),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),


          ],),);
        }
      ),
    );
  }
}
