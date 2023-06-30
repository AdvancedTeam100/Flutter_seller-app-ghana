import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/top_selling_product_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/base/paginated_list_view.dart';
import 'package:sixvalley_vendor_app/view/base/title_row.dart';
import 'package:sixvalley_vendor_app/view/screens/product/product_list_view_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/product/widget/top_most_product_card.dart';

class TopSellingProductScreen extends StatelessWidget {
  final bool isMain;
  final ScrollController scrollController;
  const TopSellingProductScreen({Key key, this.isMain = false, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        Provider.of<ProductProvider>(context,listen: false).getTopSellingProductList(1, context, 'en');
      },
      child: Consumer<ProductProvider>(
        builder: (context, prodProvider, child) {
          print(MediaQuery.of(context).size.width);
          List<Products> productList;
          productList = prodProvider.topSellingProductModel?.products;


          return Column(mainAxisSize: MainAxisSize.min, children: [

            isMain?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_DEFAULT,
                  vertical: Dimensions.PADDING_SIZE_SMALL),
              child: Row(
                children: [
                  SizedBox(width: Dimensions.ICON_SIZE_DEFAULT, child: Image.asset(Images.top_selling_icon)),
                  SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Expanded(
                    child: TitleRow(title: '${getTranslated('top_selling_products', context)}',
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductListScreen(title: 'top_selling_products')))),
                  ),
                ],
              ),
            ):SizedBox(),

            productList != null ? productList.length != 0 ?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_SMALL,
                  vertical: Dimensions.PADDING_SIZE_SMALL),
              child: PaginatedListView(
                reverse: false,
                scrollController: scrollController,
                totalSize: prodProvider.topSellingProductModel.totalSize,
                offset: prodProvider.topSellingProductModel != null ? int.parse(prodProvider.topSellingProductModel.offset) : null,
                onPaginate: (int offset) async {
                  await prodProvider.getTopSellingProductList(offset, context,'en', reload: false);
                },

                itemView: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 9,
                    crossAxisSpacing: 5,
                    childAspectRatio: MediaQuery.of(context).size.width < 400? 1/1.23: MediaQuery.of(context).size.width < 415? 1/1.22 : 1/1.28,
                  ),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: isMain && productList.length >4? 4 : productList.length,
                  itemBuilder: (context, index) {

                    return TopMostProductWidget(productModel: productList[index].product, totalSold: productList[index].count);
                  },
                ),
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
