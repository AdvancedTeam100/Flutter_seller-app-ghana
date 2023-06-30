import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/shop_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';
class TitleAndDescriptionWidget extends StatefulWidget {
  final SellerProvider resProvider;
  final int index;
  const TitleAndDescriptionWidget({Key key, @required this.resProvider, @required  this.index}) : super(key: key);

  @override
  State<TitleAndDescriptionWidget> createState() => _TitleAndDescriptionWidgetState();
}

class _TitleAndDescriptionWidgetState extends State<TitleAndDescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
          Text('${getTranslated('inset_lang_wise_title_des', context)}',
            style: robotoRegular.copyWith(color: ColorResources.getHint(context),
              fontSize: Dimensions.FONT_SIZE_SMALL),),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),


          Row(children: [
            Text('${getTranslated('product_name', context)}',
              style: robotoRegular.copyWith(color: ColorResources.titleColor(context),
                fontSize: Dimensions.FONT_SIZE_DEFAULT),),
              Text('*',style: robotoBold.copyWith(color: ColorResources.mainCardFourColor(context),
                  fontSize: Dimensions.FONT_SIZE_DEFAULT),),
            ],
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          CustomTextField(
            textInputAction: TextInputAction.next,
            controller: TextEditingController(text: widget.resProvider.titleControllerList[widget.index].text),
            textInputType: TextInputType.name,
            hintText: getTranslated('product_title', context),
            border: true,
            onChanged: (String text) {
              widget.resProvider.setTitle(widget.index, text);
            },

          ),
          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),


          Row(
            children: [
              Text(getTranslated('product_description',context),
                style: robotoRegular.copyWith(color:  ColorResources.titleColor(context),
                    fontSize: Dimensions.FONT_SIZE_DEFAULT),),

              Text('*',style: robotoBold.copyWith(color: ColorResources.mainCardFourColor(context),
                  fontSize: Dimensions.FONT_SIZE_DEFAULT),),
            ],
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),


          CustomTextField(
            isDescription: true,
            controller: TextEditingController(text: widget.resProvider.descriptionControllerList[widget.index].text),
            onChanged: (String text) => widget.resProvider.setDescription(widget.index, text),
            textInputType: TextInputType.multiline,
            maxLine: 3,
            border: true,
            hintText: getTranslated('meta_description_hint', context),

          ),

        ],),
    );
  }
}
