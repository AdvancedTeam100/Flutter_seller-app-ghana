import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/emergency_contact_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_delegate.dart';
import 'package:sixvalley_vendor_app/view/base/custom_search_field.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/emergency_contact/widget/add_emergency_contact.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/emergency_contact/widget/emergency_contact_list.dart';

class EmergencyContactScreen extends StatefulWidget {
  const EmergencyContactScreen({Key key}) : super(key: key);

  @override
  State<EmergencyContactScreen> createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    Provider.of<EmergencyContactProvider>(context, listen: false).getEmergencyContactListList(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('emergency_contact', context),isBackButtonExist: true,),
      body: RefreshIndicator(
        onRefresh: () async{
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(delegate: SliverDelegate(
                height: 90,
                child : Padding(
                  padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT),
                  child: CustomSearchField(
                    controller: searchController,
                    hint: getTranslated('search', context),
                    prefix: Images.icons_search,
                    iconPressed: () => (){},
                    onSubmit: (text) => (){},
                    onChanged: (value){

                    },
                    isFilter: false,
                  ),
                )
            )),
            SliverToBoxAdapter(
              child: Column(
                children: [

                  EmergencyContactListView(),
                ],
              ),
            )
          ],
        ),),
      floatingActionButton:FloatingActionButton(
        backgroundColor: Theme.of(context).cardColor,
        child: Icon(Icons.add_circle, size: Dimensions.ICON_SIZE_EXTRA_LARGE,
          color: Theme.of(context).primaryColor,),
        onPressed: (){
          showDialog(context: context, builder: (_){
            return AddEmergencyContact();});
        },
      ) ,
    );
  }
}

