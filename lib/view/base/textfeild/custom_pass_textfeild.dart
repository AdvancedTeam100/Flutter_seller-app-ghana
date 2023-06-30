import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintTxt;
  final FocusNode focusNode;
  final FocusNode nextNode;
  final TextInputAction textInputAction;
  final bool border;
  final String prefixIconImage;

  CustomPasswordTextField({this.controller, this.hintTxt, this.focusNode, this.nextNode, this.textInputAction, this.border = false, this.prefixIconImage});

  @override
  _CustomPasswordTextFieldState createState() => _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _obscureText = true;
  void _toggle() {
    setState(() { _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(height: 42,
      width: double.infinity,
      decoration: BoxDecoration(
        border:widget.border? Border.all(width: 1, color: Theme.of(context).hintColor.withOpacity(.35)):null,
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
        boxShadow: [
          BoxShadow(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).primaryColor.withOpacity(0):
          Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)) // changes position of shadow
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          controller: widget.controller,
          obscureText: _obscureText,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          onFieldSubmitted: (v) {
            setState(() {
              widget.textInputAction == TextInputAction.done
                  ? FocusScope.of(context).consumeKeyboardToken()
                  : FocusScope.of(context).requestFocus(widget.nextNode);
            });
          },
          validator: (value) {
            return null;
          },
          decoration: InputDecoration(
              prefixIconConstraints: BoxConstraints(
                minWidth: 20, minHeight: 20),
              prefixIcon: widget.prefixIconImage != null ?
              Container(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(.135)
                  ),
                  child: Image.asset(widget.prefixIconImage,width: 20, height: 20,)):SizedBox(),

              suffixIcon: GestureDetector(onTap: _toggle,
                  child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, size: 20,)),
              suffixIconConstraints:  BoxConstraints(
                minWidth: 50,
                minHeight: 20,
              ),
              hintText: widget.hintTxt ?? '',
              contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
              isDense: true,
              filled: true,
              focusedBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor)),
              fillColor: Theme.of(context).highlightColor,
              hintStyle: titilliumRegular.copyWith(color: Theme.of(context).hintColor),
              border: InputBorder.none),
        ),
      ),
    );
  }
}
