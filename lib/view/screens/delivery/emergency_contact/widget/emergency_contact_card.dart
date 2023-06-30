import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/emergency_contact_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/emergency_contact_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/emergency_contact/widget/add_emergency_contact.dart';


class EmergencyContactCardWidget extends StatelessWidget {
  final ContactList contactList;
  final int index;
  const EmergencyContactCardWidget({Key key, this.contactList, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EmergencyContactProvider>(
      builder: (context, emergencyContactProvider, _) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_EXTRA_SMALL,0,Dimensions.PADDING_SIZE_EXTRA_SMALL,Dimensions.PADDING_SIZE_MEDIUM),
          child: Slidable(

            key: const ValueKey(0),

            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              dragDismissible: false,
              children:  [
                SlidableAction(
                  onPressed: (value){
                    emergencyContactProvider.deleteEmergencyContact(context, contactList.id);
                  },
                  backgroundColor: Theme.of(context).errorColor.withOpacity(.05),
                  foregroundColor: Theme.of(context).errorColor,
                  icon: Icons.delete_forever_rounded,
                  label: getTranslated('delete', context),
                ),
                SlidableAction(
                  onPressed: (value){
                    showDialog(context: context, builder: (_){
                      return AddEmergencyContact(index: index, contactList: contactList,);});
                  },
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(.05),
                  foregroundColor: Theme.of(context).primaryColor,
                  icon: Icons.edit,
                  label: getTranslated('edit', context),
                ),
              ],
            ),

            // The end action pane is the one at the right or the bottom side.
            endActionPane: ActionPane(

              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (value){
                    emergencyContactProvider.deleteEmergencyContact(context, contactList.id);
                  },
                  backgroundColor: Theme.of(context).errorColor.withOpacity(.05),
                  foregroundColor: Theme.of(context).errorColor,
                  icon: Icons.delete_forever_rounded,
                  label: getTranslated('delete', context),

                ),
                SlidableAction(
                  onPressed: (value){
                    showDialog(context: context, builder: (_){
                      return AddEmergencyContact(index: index, contactList: contactList,);});
                  },
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(.05),
                  foregroundColor: Theme.of(context).primaryColor,
                  icon: Icons.edit,
                  label: getTranslated('edit', context),
                ),
              ],
            ),

            child: Stack(
              children: [
                Container(padding: EdgeInsets.symmetric(vertical:Dimensions.PADDING_SIZE_MEDIUM),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                      boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.05), blurRadius: 1,spreadRadius: 1,offset: Offset(1,2))]),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Padding(padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        child: SizedBox(width: Dimensions.ICON_SIZE_EXTRA_LARGE,
                            child: Image.asset(Images.e_call))),


                      Expanded(
                        child: Column(children: [
                          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(contactList.name ?? '', style: robotoRegular.copyWith(
                                        color: ColorResources.titleColor(context),fontSize: Dimensions.FONT_SIZE_DEFAULT),
                                        maxLines: 2, overflow: TextOverflow.ellipsis),

                                  ),

                                  SizedBox(width: 100)
                                ],
                              ),

                              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                              Container(padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
                                decoration: BoxDecoration(
                                    color: ColorResources.getEmergencyContactColor(context),
                                    borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),


                                child: Text(contactList.phone ?? '',
                                  style: robotoRegular.copyWith(color: Theme.of(context).cardColor),),
                              )

                            ],),
                          ),
                        ],),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Consumer<EmergencyContactProvider>(
                          builder: (context, emergencyContactProvider, _) {
                            return FlutterSwitch(value: contactList.status == 1, activeColor: Theme.of(context).primaryColor,
                              width: 48,height: 25,toggleSize: 20,padding: 2,onToggle: (value){
                              emergencyContactProvider.statusOnOffEmergencyContact(context, contactList.id, value ? 1 : 0, index);
                              },);
                          }
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );

  }
}
