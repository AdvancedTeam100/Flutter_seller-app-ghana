import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/collected_cash_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/top_delivery_man.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/base/order_shimmer.dart';
import 'package:sixvalley_vendor_app/view/base/paginated_list_view.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/widget/delivery_man_collected_cash_card.dart';



class CollectedCashFromDeliveryMan extends StatefulWidget {
  final DeliveryMan deliveryMan;
  const CollectedCashFromDeliveryMan({Key key, this.deliveryMan}) : super(key: key);

  @override
  State<CollectedCashFromDeliveryMan> createState() => _CollectedCashFromDeliveryManState();
}

class _CollectedCashFromDeliveryManState extends State<CollectedCashFromDeliveryMan> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer<DeliveryManProvider>(
        builder: (context, collectedCashProvider, child) {
          List<CollectedCash> collectedCashList;
          collectedCashList = collectedCashProvider.collectedCashModel.collectedCash;
          return collectedCashList != null ? collectedCashProvider.earningList.length > 0 ?
          RefreshIndicator(
            backgroundColor: Theme.of(context).primaryColor,
            onRefresh: () async {
              await collectedCashProvider.getDeliveryCollectedCashList(context, widget.deliveryMan.id, 1);
            },
            child:
            collectedCashList != null ? collectedCashList.isNotEmpty?
            SingleChildScrollView(
              controller: scrollController,
              child: PaginatedListView(
                reverse: false,
                scrollController: scrollController,
                totalSize: collectedCashProvider.collectedCashModel?.totalSize,
                offset: collectedCashProvider.collectedCashModel != null ? int.parse(collectedCashProvider.collectedCashModel.offset.toString()) : null,
                onPaginate: (int offset) async {
                  print('==========offset========>$offset');
                  await collectedCashProvider.getDeliveryCollectedCashList(context, widget.deliveryMan.id, offset, reload: false);
                },

                itemView: ListView.builder(
                  itemCount: collectedCashList.length,
                  padding: EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return DeliveryManCollectedCashCard(collectedCash: collectedCashList[index], index: index);
                  },
                ),
              ),
            ):NoDataScreen():OrderShimmer(isEnabled: true),

          ) : NoDataScreen(title: 'no_order_found',) : OrderShimmer(isEnabled: true);
        }
    );
  }
}

