import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';

const titilliumRegular = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
);


const titilliumSemiBold = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: Dimensions.FONT_SIZE_LARGE,
  fontWeight: FontWeight.w500,
);

const titilliumBold = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w600,
);
const titilliumItalic = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontStyle: FontStyle.italic,
);

const robotoHintRegular = TextStyle(
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w400,
    fontSize: Dimensions.FONT_SIZE_SMALL,
    color: Colors.grey
);
const robotoRegular = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
);
const robotoRegularMainHeadingAddProduct = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
);

const robotoRegularForAddProductHeading = TextStyle(
  fontFamily: 'Ubuntu',
  color: Color(0xFF9D9D9D),
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.FONT_SIZE_SMALL,
);

const robotoTitleRegular = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.FONT_SIZE_LARGE,
);

const robotoSmallTitleRegular = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.FONT_SIZE_SMALL,
);

const robotoBold = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w600,
);

const robotoMedium = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w500,
);


class ThemeShadow {
  static List <BoxShadow> getShadow(BuildContext context) {
    List<BoxShadow> boxShadow =  [BoxShadow(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Colors.black26:
    Theme.of(context).primaryColor.withOpacity(.2), blurRadius: 5,spreadRadius: 1,offset: Offset(1,1))];
    return boxShadow;
  }
}
