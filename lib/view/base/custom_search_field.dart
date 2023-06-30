import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class CustomSearchField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String prefix;
  final Function iconPressed;
  final Function onSubmit;
  final Function onChanged;
  final Function filterAction;
  final bool isFilter;
  CustomSearchField({
    @required this.controller,
    @required this.hint,
    @required this.prefix,
    @required this.iconPressed,
    this.onSubmit,
    this.onChanged,
    this.filterAction,
    this.isFilter = false,
  });

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: TextField(
          controller: widget.controller,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
                color: Theme.of(context).disabledColor.withOpacity(.5)),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
            ),
            filled: true, fillColor: Theme.of(context).primaryColor.withOpacity(.07),
            isDense: true,
            focusedBorder:OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: .70),
              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_MEDIUM),
              child: SizedBox(width: Dimensions.ICON_SIZE_EXTRA_SMALL,  child: Image.asset(widget.prefix)),
            ),

            // IconButton(
            //   onPressed: widget.iconPressed,
            //   icon: Icon(widget.prefix, color: Theme.of(context).hintColor),
            // ),
          ),
          onSubmitted: widget.onSubmit,
          onChanged: widget.onChanged,
        ),
      ),

      
     widget.isFilter ? Padding(
        padding:  EdgeInsets.only(left :  Provider.of<LocalizationProvider>(context, listen: false).isLtr? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0,
            right :  Provider.of<LocalizationProvider>(context, listen: false).isLtr? 0 : Dimensions.PADDING_SIZE_EXTRA_SMALL),
       child: GestureDetector(
          onTap: widget.filterAction,
          child: Container(decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          ),
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_MEDIUM),
              child: Image.asset(Images.filter_icon, width: Dimensions.PADDING_SIZE_LARGE)),
        ),
      ) : SizedBox(),
    ],);
  }
}
