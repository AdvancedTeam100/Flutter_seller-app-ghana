import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/shop_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';



class DigitalProductWidget extends StatefulWidget {
  final SellerProvider resProvider;
  final Product product;
  const DigitalProductWidget({Key key, this.resProvider, this.product}) : super(key: key);

  @override
  State<DigitalProductWidget> createState() => _DigitalProductWidgetState();
}

class _DigitalProductWidgetState extends State<DigitalProductWidget> {
  PlatformFile fileNamed;
  File file;
  int  fileSize;


  @override
  Widget build(BuildContext context) {

    return Container(child: Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, 0, Dimensions.PADDING_SIZE_DEFAULT, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(getTranslated('product_type', context),
            style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(width: .7,color: Theme.of(context).hintColor.withOpacity(.3)),
              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),

            ),
            child: DropdownButton<String>(
              value: widget.resProvider.productTypeIndex == 0 ? 'physical' : 'digital',
              items: <String>['physical', 'digital'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value != null? getTranslated(value, context): getTranslated('physical', context)),
                );
              }).toList(),
              onChanged: (value) {
                widget.resProvider.setProductTypeIndex(value == 'physical' ? 0 : 1, true);
              },
              isExpanded: true,
              underline: SizedBox(),
            ),
          ),
        ]),
      ),
      SizedBox(height: widget.resProvider.productTypeIndex == 1?Dimensions.PADDING_SIZE_DEFAULT : 0),
      widget.resProvider.productTypeIndex == 1?
      Padding(
        padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, 0, Dimensions.PADDING_SIZE_DEFAULT, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(getTranslated('digital_product_type', context),
            style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(width: .7,color: Theme.of(context).hintColor.withOpacity(.3)),
              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),

            ),
            child: DropdownButton<String>(
              value: widget.resProvider.digitalProductTypeIndex == 0 ? 'ready_after_sell' : 'ready_product',
              items: <String>['ready_after_sell', 'ready_product'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value != null? getTranslated(value, context): getTranslated("ready_after_sell", context)),
                );
              }).toList(),
              onChanged: (value) {
                print('value-======>$value');
                widget.resProvider.setDigitalProductTypeIndex(value == 'ready_after_sell' ? 0 : 1, true);
              },
              isExpanded: true,
              underline: SizedBox(),
            ),
          ),
        ]),
      ):SizedBox(),
      SizedBox(height: widget.resProvider.productTypeIndex == 1?Dimensions.PADDING_SIZE_DEFAULT : 0),

      widget.resProvider.productTypeIndex == 1 && widget.resProvider.digitalProductTypeIndex == 1?
      Padding(
        padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT, 0),
        child: Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)
          ),
          child: InkWell(
            onTap: ()async{
              FilePickerResult result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf', 'zip', 'jpg', 'png', "jpeg", "gif"],
              );
              if (result != null) {
                file = File(result.files.single.path);
                fileSize = await file.length();
                fileNamed = result.files.first;
                widget.resProvider.setSelectedFileName(file);

              } else {

              }
            },
            child: Builder(
                builder: (context) {
                  return Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(width: 50,child: Image.asset(Images.upload)),
                      widget.resProvider.selectedFileForImport !=null ?
                      Text(fileNamed != null? fileNamed.name??'':'${widget.product.digitalFileReady}',maxLines: 2,overflow: TextOverflow.ellipsis):
                      Text(getTranslated('upload_file', context), style: robotoRegular.copyWith()),

                      widget.product !=null && fileNamed == null ?
                      Text(widget.product.digitalFileReady??'', style: robotoRegular.copyWith()):SizedBox(),

                    ],);
                }
            ),
          ),
        ),
      ):SizedBox(),


      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
    ]));
  }
}
