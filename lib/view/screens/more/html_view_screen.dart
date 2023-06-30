import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';

class HtmlViewScreen extends StatelessWidget {
  final String title;
  final String url;
  HtmlViewScreen({@required this.url, @required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: title),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                child: Html(
                  data: url,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
