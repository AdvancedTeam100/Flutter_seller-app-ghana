import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';


class CustomDatePicker extends StatefulWidget {
  final String title;
  final String text;
  final String image;
  final bool requiredField;
  final Function selectDate;
  CustomDatePicker({this.title,this.text,this.image, this.requiredField = false,this.selectDate});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

        RichText(
          text: TextSpan(
            text: widget.title, style: robotoRegular.copyWith(color: ColorResources.getTextColor(context)),
            children: <TextSpan>[
              widget.requiredField ? TextSpan(text: '  *', style: robotoBold.copyWith(color: Colors.red)) : TextSpan(),
            ],
          ),
        ),

        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

        Container(
          height: 50,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            border: Border.all(color: ColorResources.getPrimary(context),width: 0.1),
            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
          ),
          child:
          InkWell(
            onTap: widget.selectDate,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,children: [
              SizedBox(width: 20,height: 20,child: Image.asset(widget.image)),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text(widget.text, style: robotoRegular.copyWith(),),

            ],
            ),
          ),
        ),

      ],),
    );
  }
}
