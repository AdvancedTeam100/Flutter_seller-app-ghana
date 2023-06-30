import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/provider/bank_info_provider.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/provider/order_provider.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/provider/shipping_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/custom_loader.dart';
import 'package:sixvalley_vendor_app/view/screens/home/widget/chart_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/home/widget/completed_order_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/home/widget/on_going_order_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/home/widget/stock_out_product_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/product/most_popular_product.dart';
import 'package:sixvalley_vendor_app/view/screens/product/top_selling_product.dart';
import 'package:sixvalley_vendor_app/view/screens/top_delivery_man/top_delivery_man_view.dart';


class HomePageScreen extends StatefulWidget {
  final Function callback;
  const HomePageScreen({Key key, this.callback}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final ScrollController _scrollController = ScrollController();
  Future<void> _loadData(BuildContext context, bool reload) async {
    Provider.of<ProfileProvider>(context, listen: false).getSellerInfo(context);
    Provider.of<BankInfoProvider>(context, listen: false).getBankInfo(context);
    Provider.of<OrderProvider>(context, listen: false).getOrderList(context,1,'all');
    Provider.of<OrderProvider>(context, listen: false).getAnalyticsFilterData(context, 'overall');
    Provider.of<SplashProvider>(context,listen: false).getColorList();
    Provider.of<ProductProvider>(context,listen: false).getStockOutProductList(1, context, 'en');
    Provider.of<ProductProvider>(context,listen: false).getMostPopularProductList(1, context, 'en');
    Provider.of<ProductProvider>(context,listen: false).getTopSellingProductList(1, context, 'en');
    Provider.of<ShippingProvider>(context,listen: false).getCategoryWiseShippingMethod(context);
    Provider.of<ShippingProvider>(context,listen: false).getSelectedShippingMethodType(context);
    Provider.of<DeliveryManProvider>(context, listen: false).getTopDeliveryManList(context);
    Provider.of<BankInfoProvider>(context, listen: false).getDashboardRevenueData(context,'yearEarn');


  }

  @override
  void initState() {
    _loadData(context, false);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double limitedStockCardHeight = MediaQuery.of(context).size.width/1.4;
    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      body: Consumer<OrderProvider>(builder: (context, order, child) {
        return order.orderModel != null ?
        RefreshIndicator(
          onRefresh: () async {
            Provider.of<OrderProvider>(context, listen: false).setAnalyticsFilterName(context, 'overall',true);
            Provider.of<OrderProvider>(context, listen: false).setAnalyticsFilterType(0,true);
            await _loadData(context, true);

          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                elevation: 0,
                centerTitle: false,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).highlightColor,
                title: Image.asset(Images.logo_with_app_name, height: 35),
              ),
              SliverToBoxAdapter(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    OngoingOrderWidget(callback: widget.callback,),


                    CompletedOrderWidget(callback: widget.callback),
                   SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                    Consumer<ProductProvider>(
                        builder: (context, prodProvider, child) {
                          List<Product> productList;
                          productList = prodProvider.stockOutProductList;
                        return productList.isNotEmpty?
                        Container(height: limitedStockCardHeight,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              boxShadow: [
                                BoxShadow(color: ColorResources.getPrimary(context).withOpacity(.05),
                                    spreadRadius: -3, blurRadius: 12, offset: Offset.fromDirection(0,6))],
                            ),
                            child: StockOutProductView(scrollController: _scrollController, isHome: true)):SizedBox();
                      }
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                    ChartWidget(),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                    TopSellingProductScreen(isMain: true),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                    Container(
                      color: Theme.of(context).primaryColor,
                        child: MostPopularProductScreen(isMain: true)),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                    TopDeliveryManView(isMain: true)

                  ],
                ),
              )
            ],


          ),
        ) : CustomLoader();
      },
      ),
    );
  }
}
