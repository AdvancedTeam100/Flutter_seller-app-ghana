import 'dart:io';
import 'package:country_code_picker/country_code.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_pass_textfeild.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';
import 'package:sixvalley_vendor_app/view/screens/forgetPassword/widget/code_picker_widget.dart';
import 'package:sixvalley_vendor_app/data/model/response/top_delivery_man.dart';



class DeliveryManInfo extends StatefulWidget {
  final bool isPassword;
  final DeliveryMan deliveryMan;
  const DeliveryManInfo({Key key, this.isPassword = false, this.deliveryMan}) : super(key: key);

  @override
  State<DeliveryManInfo> createState() => _DeliveryManInfoState();
}

class _DeliveryManInfoState extends State<DeliveryManInfo> {
  String _countryDialCode = "+880";

  @override
  void initState() {
    super.initState();


    if(widget.deliveryMan != null){
      Provider.of<DeliveryManProvider>(context, listen: false).firstNameController.text = widget.deliveryMan.fName;
      Provider.of<DeliveryManProvider>(context, listen: false).lastNameController.text = widget.deliveryMan.lName;
      Provider.of<DeliveryManProvider>(context, listen: false).emailController.text = widget.deliveryMan.email;
      Provider.of<DeliveryManProvider>(context, listen: false).phoneController.text = widget.deliveryMan.phone;
      Provider.of<DeliveryManProvider>(context, listen: false).addressController.text = widget.deliveryMan.address;
      Provider.of<DeliveryManProvider>(context, listen: false).identityNumber.text = widget.deliveryMan.identityNumber;
      Provider.of<DeliveryManProvider>(context, listen: false).setIdentityType(widget.deliveryMan.identityType );
    }

  }
  @override
  Widget build(BuildContext context) {
    String baseUrl = '${Provider.of<SplashProvider>(context, listen: false).baseUrls.deliveryManImageUrl}';
    return Consumer<DeliveryManProvider>(
        builder: (authContext, deliveryManProvider, _) {
          return SingleChildScrollView(
            child: Column( crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(!widget.isPassword) Container(child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                    child: Align(alignment: Alignment.center, child: DottedBorder(
                      strokeWidth: 2,
                      dashPattern: [10,5],
                      color: Theme.of(context).hintColor,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(Dimensions.PADDING_SIZE_SMALL),
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                          child: deliveryManProvider.profileImage != null ?  Image.file(File(deliveryManProvider.profileImage.path),
                            width: 150, height: 150, fit: BoxFit.cover,
                          ) :widget.deliveryMan!=null? FadeInImage.assetNetwork(
                            placeholder: Images.placeholder_image,
                            image: '${Provider.of<SplashProvider>(context).configModel.
                            baseUrls.deliveryManImageUrl}/${widget.deliveryMan.image != null ? widget.deliveryMan.image : ''}',
                            height: 150, width: 150, fit: BoxFit.cover,
                            imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder_image,
                                height: 150, width: 150, fit: BoxFit.cover),
                          ):Container(height: 150,
                              width: 150,
                              child: Image.asset(Images.camera_placeholder,scale: 3,)),
                        ),
                        Positioned(
                          bottom: 0, right: 0, top: 0, left: 0,
                          child: InkWell(
                            onTap: () => deliveryManProvider.pickImage(true,false),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).hintColor.withOpacity(.08),
                                borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                              ),

                            ),
                          ),
                        ),
                      ]),
                    )),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(getTranslated('profile_image', context), style: robotoRegular),
                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Text('(1:1)', style: robotoRegular.copyWith(color: Theme.of(context).errorColor),),
                      ],
                    ),
                  ),


                  Container(margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE, right: Dimensions.PADDING_SIZE_LARGE,
                      bottom: Dimensions.PADDING_SIZE_SMALL),
                      child: CustomTextField(
                        border: true,
                        hintText: getTranslated('first_name', context),
                        focusNode: deliveryManProvider.firstNameNode,
                        nextNode: deliveryManProvider.lastNameNode,
                        textInputType: TextInputType.name,
                        controller: deliveryManProvider.firstNameController,
                        textInputAction: TextInputAction.next,
                      )),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                  Container(margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE, right: Dimensions.PADDING_SIZE_LARGE,
                      bottom: Dimensions.PADDING_SIZE_SMALL),
                      child: CustomTextField(
                        border: true,
                        hintText: getTranslated('last_name', context),
                        focusNode: deliveryManProvider.lastNameNode,
                        nextNode: deliveryManProvider.emailNode,
                        textInputType: TextInputType.name,
                        controller: deliveryManProvider.lastNameController,
                        textInputAction: TextInputAction.next,
                      )),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),



                  Container(margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE, right: Dimensions.PADDING_SIZE_LARGE,
                      bottom: Dimensions.PADDING_SIZE_SMALL),
                      child: CustomTextField(
                        border: true,
                        hintText: getTranslated('email_address', context),
                        focusNode: deliveryManProvider.emailNode,
                        nextNode: deliveryManProvider.phoneNode,
                        textInputType: TextInputType.name,
                        controller: deliveryManProvider.emailController,
                        textInputAction: TextInputAction.next,
                      )),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                  Container(
                    margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,
                        right: Dimensions.PADDING_SIZE_DEFAULT),
                    child: Row(children: [
                      CodePickerWidget(
                        onChanged: (CountryCode countryCode) {
                          _countryDialCode = countryCode.dialCode;
                          deliveryManProvider.setCountryDialCode(_countryDialCode);
                        },
                        initialSelection: deliveryManProvider.countryDialCode,
                        favorite: [deliveryManProvider.countryDialCode],
                        showDropDownButton: true,
                        padding: EdgeInsets.zero,
                        showFlagMain: true,
                        textStyle: TextStyle(color: Theme.of(context).textTheme.headline1.color),

                      ),



                      Expanded(child: CustomTextField(
                        hintText: getTranslated('ENTER_MOBILE_NUMBER', context),
                        controller: deliveryManProvider.phoneController,
                        focusNode: deliveryManProvider.phoneNode,
                        nextNode: deliveryManProvider.addressNode,
                        isPhoneNumber: true,
                        border: true,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.phone,

                      )),
                    ]),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_MEDIUM),

                  Container(margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE, right: Dimensions.PADDING_SIZE_LARGE,
                      bottom: Dimensions.PADDING_SIZE_SMALL),
                      child: CustomTextField(
                        border: true,
                        maxLine: 2,
                        hintText: getTranslated('address', context),
                        focusNode: deliveryManProvider.addressNode,
                        textInputType: TextInputType.name,
                        controller: deliveryManProvider.addressController,
                        textInputAction: TextInputAction.done,
                      )),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                    child: Container(height: 40,
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                      decoration: BoxDecoration(color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        border: Border.all(width: .5, color: Theme.of(context).hintColor.withOpacity(.7)),
                      ),
                      child: DropdownButton<String>(
                        hint: deliveryManProvider.identityType == null ? Text(getTranslated('select_identity_type', context)) :
                        Text(deliveryManProvider.identityType, style: TextStyle(color: ColorResources.getTextColor(context)),),
                        items: deliveryManProvider.identityTypeList.map((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value));}).toList(),
                        onChanged: (val) {
                          setState(() {deliveryManProvider.setIdentityType(val);},);},
                        isExpanded: true,
                        underline: SizedBox(),
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Container(margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE, right: Dimensions.PADDING_SIZE_LARGE,
                      bottom: Dimensions.PADDING_SIZE_SMALL),
                      child: CustomTextField(
                        border: true,
                        hintText: getTranslated('identity_number', context),
                        focusNode: deliveryManProvider.identityNumberNode,
                        textInputType: TextInputType.name,
                        controller: deliveryManProvider.identityNumber,
                        textInputAction: TextInputAction.done,
                      )),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, 0,Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_SMALL),
                    child: Row(
                      children: [
                        Text(getTranslated('identity_image', context),
                            style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                      ],
                    ),
                  ),


                  widget.deliveryMan != null && widget.deliveryMan.identityImage.isNotEmpty?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.FONT_SIZE_EXTRA_SMALL),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount : widget.deliveryMan.identityImage.length,

                        itemBuilder: (BuildContext context, index){
                          print('==>image path==$baseUrl/${widget.deliveryMan.identityImage[index]}');
                          return Stack(children: [
                            Container(child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                              child: CustomImage(
                              height: MediaQuery.of(context).size.width/4.3,
                              width: MediaQuery.of(context).size.width,
                              image: '$baseUrl/${widget.deliveryMan.identityImage[index]}',
                            ),) ,
                              decoration: BoxDecoration(color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20)),),),

                          ],
                          );

                        } ),
                  ):SizedBox(),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount : deliveryManProvider.identityImages.length + 1 ,
                      itemBuilder: (BuildContext context, index){
                        return index ==  deliveryManProvider.identityImages.length ?
                        GestureDetector(
                          onTap: ()=> deliveryManProvider.pickImage(false, false,),
                          child: DottedBorder(
                            strokeWidth: 2,
                            dashPattern: [10,5],
                            color: Theme.of(context).hintColor,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(Dimensions.PADDING_SIZE_SMALL),
                            child: Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                                child:  Container(height: MediaQuery.of(context).size.width/4.3,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.asset(Images.camera_placeholder, scale: 3,
                                     ),
                                ),
                              ),
                              Positioned(bottom: 0, right: 0, top: 0, left: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).hintColor.withOpacity(0.07),
                                    borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),

                                  ),

                                ),
                              ),
                            ],
                            ),
                          ),
                        ) :
                        Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                            child: Container(child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                              child:  Image.file(File(deliveryManProvider.identityImages[index].path),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width/4.3,
                                fit: BoxFit.cover,),) ,
                              decoration: BoxDecoration(color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20)),),),
                          ),
                          Positioned(top:0,right:0,
                            child: InkWell(
                              onTap :() => deliveryManProvider.removeImage(index),
                              child: Container(decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_DEFAULT))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(Icons.delete_forever_rounded,color: Colors.red,size: 15,),)),
                            ),
                          ),
                        ],
                        );

                      } ),
                  ),



                ],)),


                if(widget.isPassword)Container(child: Column(children: [

                  Container(margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE, right: Dimensions.PADDING_SIZE_LARGE,
                      bottom: Dimensions.PADDING_SIZE_SMALL),
                      child: CustomTextField(
                        border: true,
                        idDate: true,
                        fillColor: Theme.of(context).hintColor.withOpacity(.25),
                        hintText: '${deliveryManProvider.countryDialCode} ${deliveryManProvider.phoneController.text}',
                      )),

                  Container(margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE,
                      right: Dimensions.PADDING_SIZE_LARGE, bottom: Dimensions.PADDING_SIZE_DEFAULT),
                      child: CustomPasswordTextField(border: true,
                        hintTxt: getTranslated('password', context),
                        textInputAction: TextInputAction.next,
                        focusNode: deliveryManProvider.passwordNode,
                        nextNode: deliveryManProvider.confirmPasswordNode,
                        controller: deliveryManProvider.passwordController)),



                  Container(margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE,
                      right: Dimensions.PADDING_SIZE_LARGE, bottom: Dimensions.PADDING_SIZE_DEFAULT),
                      child: CustomPasswordTextField(
                        border: true,
                        hintTxt: getTranslated('confirm_password', context),
                        textInputAction: TextInputAction.done,
                        focusNode: deliveryManProvider.confirmPasswordNode,
                        controller: deliveryManProvider.confirmPasswordController)),

                  SizedBox(height: MediaQuery.of(context).size.height-420),

                ],),)


              ],
            ),
          );
        }
    );
  }
}
