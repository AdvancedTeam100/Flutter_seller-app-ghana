import 'package:flutter/material.dart';

class VariantTypeModel {
  String variantType;

  TextEditingController controller;
  TextEditingController qtyController;
  FocusNode node;
  FocusNode qtyNode;
  VariantTypeModel({@required this.variantType,@required this.controller, @required this.node, @required this.qtyController, this.qtyNode});
}