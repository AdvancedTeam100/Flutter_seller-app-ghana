import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/base/title_row.dart';
import 'package:sixvalley_vendor_app/view/screens/product/product_list_view_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/product/widget/top_most_product_card.dart';

class MostPopularProductScreen extends StatelessWidget {
  final bool isMain;
  const MostPopularProductScreen({Key key, this.isMain = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        Provider.of<ProductProvider>(context,listen: false).getMostPopularProductList(1, context, 'en');
      },
      child: Consumer<ProductProvider>(
        builder: (context, prodProvider, child) {
          List<Product> productList;
          productList = prodProvider.mostPopularProductList;


          return Column(mainAxisSize: MainAxisSize.min, children: [

            isMain?
            Padding(
              padding: const EdgeInsets.fromLTRB( Dimensions.PADDING_SIZE_DEFAULT,
                   Dimensions.PADDING_SIZE_LARGE, Dimensions.PADDING_SIZE_DEFAULT, 0,),
              child: Row(
                children: [
                  SizedBox(width: Dimensions.ICON_SIZE_DEFAULT, child: Image.asset(Images.popular_product_icon)),
                  SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Expanded(
                    child: TitleRow(color: Colors.white, title: '${getTranslated('most_popular_products', context)}',
                        isPopular: true,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductListScreen(isPopular: true, title: 'most_popular_products')))),
                  ),
                ],
              ),
            ):SizedBox(),

            !prodProvider.isLoading ? productList.length != 0 ?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_SMALL,
                  vertical: Dimensions.PADDING_SIZE_SMALL),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 9,
                  crossAxisSpacing: 5,
                  childAspectRatio: MediaQuery.of(context).size.width < 400? 1/1.20 :MediaQuery.of(context).size.width < 415? 1/1.23: 1/1.23,
                ),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: isMain && productList.length >4? 4 : productList.length,
                itemBuilder: (context, index) {

                  return TopMostProductWidget(productModel: productList[index], isPopular: true);
                },
              ),
            ): NoDataScreen() :SizedBox.shrink(),

            prodProvider.isLoading ? Center(child: Padding(
              padding: EdgeInsets.all(Dimensions.ICON_SIZE_EXTRA_SMALL),
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
            )) : SizedBox.shrink(),

          ]);
        },
      ),
    );
  }
}
