
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/shop_info_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';
import 'package:sixvalley_vendor_app/view/screens/shop/widget/vacation_calender.dart';


class VacationDialog extends StatelessWidget {
  final String icon;
  final String title;
  final TextEditingController vacationNote;
  final Function onYesPressed;


  final TextEditingController note;
  VacationDialog({@required this.icon, this.title, @required this.vacationNote, @required this.onYesPressed, this.note,});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL)),
        insetPadding: EdgeInsets.all(30),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Consumer<ShopProvider>(
          builder: (context, shop,_) {
            return SizedBox(width: 500, child: Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                child: Column(mainAxisSize: MainAxisSize.min, children: [


                  Padding(
                    padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT, bottom: Dimensions.PADDING_SIZE_SMALL),
                    child: Row(
                      children: [
                        Text(getTranslated('please_select_vacation_date_range', context)),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: ()=> showDialog(context: context, builder: (_)=> VacationCalender()),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical : Dimensions.PADDING_SIZE_SMALL, horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                        decoration: BoxDecoration(
                            color:  Theme.of(context).primaryColor.withOpacity(.08),
                            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(shop.startDate??'start_date'),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: Icon(Icons.arrow_forward_rounded,size: Dimensions.ICON_SIZE_DEFAULT,

                                  color:  Theme.of(context).primaryColor),
                            ),
                            Text(shop.endDate??'end_date'),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getTranslated('vacation_note', context)),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                      CustomTextField(border: true,
                        hintText: 'note',
                        maxLine: 2,
                        controller: vacationNote,
                      ),
                    ],
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  Row(children: [
                    Expanded(child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: CustomButton(
                        btnTxt: getTranslated('no',context),
                        backgroundColor: ColorResources.getHint(context),
                        isColor: true,
                      ),
                    )),
                    SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
                    Expanded(child: CustomButton(
                      btnTxt: getTranslated('yes',context),
                      onTap: () =>  onYesPressed(),
                    )),

                  ])
                ])),
            );
          }
        ));
  }
}