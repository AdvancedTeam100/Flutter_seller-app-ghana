import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_delegate.dart';
import 'package:sixvalley_vendor_app/view/base/custom_search_field.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/widget/delivery_man_list_view.dart';

class DeliveryManListScreen extends StatefulWidget {
  const DeliveryManListScreen({Key key}) : super(key: key);

  @override
  State<DeliveryManListScreen> createState() => _DeliveryManListScreenState();
}

class _DeliveryManListScreenState extends State<DeliveryManListScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    Provider.of<DeliveryManProvider>(context, listen: false).deliveryManListURI(context, 1,'');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('delivery_man_list', context),isBackButtonExist: true,),
      body: RefreshIndicator(
        onRefresh: () async{
          Provider.of<DeliveryManProvider>(context, listen: false).deliveryManListURI(context, 1,'');
          return true;
        },
        child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(delegate: SliverDelegate(
            height: 80,
            child : Padding(
              padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_MEDIUM, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_MEDIUM, Dimensions.PADDING_SIZE_DEFAULT),
              child: CustomSearchField(
                controller: searchController,
                hint: getTranslated('search', context),
                prefix: Images.icons_search,
                iconPressed: () => (){},
                onSubmit: (text) => (){},
                onChanged: (value){
                  Provider.of<DeliveryManProvider>(context, listen: false).deliveryManListURI(context, 1, value);
                },
                isFilter: false,
              ),
            )
          )),
          SliverToBoxAdapter(
            child: Column(
               children: [

                 DeliveryManListView(),
                 SizedBox(height: Dimensions.PADDING_SIZE_SMALL)
               ],
            ),
          )
        ],
      ),),
    );
  }
}


