import 'package:flutter/material.dart';

class TitleCategoryModel {
  String titleType;
  String categoryType;
  TextEditingController titleController;
  TextEditingController categoryController;
  FocusNode node;
  FocusNode categoryNode;
  TitleCategoryModel({@required this.titleType,this.categoryType ,@required this.titleController, @required this.node, @required this.categoryController, this.categoryNode});
}