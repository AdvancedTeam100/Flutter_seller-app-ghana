import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/view/base/paginated_list_view.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/widget/pos_product_card.dart';

class PosProductList extends StatelessWidget {
  final List<Product> productList;
  final ScrollController scrollController;
  final ProductProvider productProvider;
  const PosProductList({Key key, this.productList, this.scrollController, this.productProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      PaginatedListView(
        reverse: true,
        scrollController: scrollController,
        totalSize: productProvider.posProductModel?.totalSize,
        offset: productProvider.posProductModel != null ? int.parse(productProvider.posProductModel.offset.toString()) : null,
        onPaginate: (int offset) async {
          await productProvider.getPosProductList(offset, context, reload: false);
        },

        itemView: ListView.builder(
          itemCount: productList.length,
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return POSProductWidget(productModel: productList[index], index: index,);
          },
        ),
      );
  }
}
