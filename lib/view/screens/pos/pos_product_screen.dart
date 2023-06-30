import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/provider/shop_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_delegate.dart';
import 'package:sixvalley_vendor_app/view/base/custom_search_field.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/widget/category_filter_botto_sheet.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/widget/pos_product_list.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/widget/pos_product_shimmer.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/widget/product_search_dialog.dart';

class POSProductScreen extends StatefulWidget {
  const POSProductScreen({Key key}) : super(key: key);

  @override
  State<POSProductScreen> createState() => _POSProductScreenState();
}

class _POSProductScreenState extends State<POSProductScreen> {
  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).getPosProductList(1, context);
    Provider.of<SellerProvider>(context,listen: false).getCategoryList(context,null, 'en');

    super.initState();
  }
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var searchController;
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('product_list', context), isCart: true, isAction: true,),
        body: RefreshIndicator(
          onRefresh: () async{
            Provider.of<ProductProvider>(context, listen: false).getPosProductList(1, context);
            return true;
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                  delegate: SliverDelegate(
                  height: 85,
                  child : Consumer<ProductProvider>(
                    builder: (context, searchProductController, _) {
                      return Container(
                        color: Theme.of(context).cardColor,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT),
                          child: CustomSearchField(
                            controller: searchController,
                            hint: getTranslated('search', context),
                            prefix: Images.icons_search,
                            iconPressed: () => (){},
                            onSubmit: (text) => (){},
                            onChanged: (value){
                              if(value.toString().isNotEmpty){
                                searchProductController.getSearchedPosProductList(context, value, []);
                              }else{
                                print('is it called');
                                searchProductController.shoHideDialog(false);
                              }

                            },
                            isFilter: true,
                            filterAction: (){
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  context: context, builder: (_) => CategoryFilterBottomSheet());
                            },
                          ),
                        ),
                      );
                    }
                  )
              )),
              SliverToBoxAdapter(
                child: Consumer<ProductProvider>(
                    builder: (context, prodProvider, child) {
                      List<Product> productList =[];
                      productList = prodProvider.posProductModel?.products;
                      return Stack(
                        children: [
                          Column(children: [
                            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

                            productList != null ? productList.length != 0 ?
                            PosProductList(productList : productList, scrollController: _scrollController,productProvider: prodProvider) : Padding(
                              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/4),
                              child: NoDataScreen(),
                            ) : PosProductShimmer(),

                            prodProvider.isLoading ? Center(child: Padding(
                              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
                            )) : SizedBox.shrink(),

                            SizedBox(height: Dimensions.PADDING_SIZE_BOTTOM_SPACE,),

                          ]),
                          prodProvider.showDialog?
                          ProductSearchDialog():SizedBox(),
                        ],
                      );
                    }
                ),
              )
            ],
          ),),
    );
  }
}
