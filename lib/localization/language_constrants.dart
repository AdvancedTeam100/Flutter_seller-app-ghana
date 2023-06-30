import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/localization/app_localization.dart';

String getTranslated(String key, BuildContext context) {
  return AppLocalization.of(context).translate(key);
}