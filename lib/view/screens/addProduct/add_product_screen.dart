import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/add_product_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/edt_product_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/auth_provider.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/provider/shop_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';
import 'package:sixvalley_vendor_app/view/screens/addProduct/widget/add_product_next_Screen.dart';
import 'package:sixvalley_vendor_app/view/screens/addProduct/widget/digital_product_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/addProduct/widget/select_category_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/addProduct/widget/title_and_description_widget.dart';

class AddProductScreen extends StatefulWidget {
  final Product product;
  final AddProductModel addProduct;
  final EditProduct editProduct;
  AddProductScreen({Key key, this.product,  this.addProduct, this.editProduct}): super(key: key);
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> with TickerProviderStateMixin {
  TabController _tabController;
  int length;
  bool _update;
  int cat=0, subCat=0, subSubCat=0, unit=0, brand=0;
  String unitValue = '';
  List<String> titleList = [];
  List<String> descriptionList = [];



  void _load(){
    String languageCode = Provider.of<LocalizationProvider>(context, listen: false).locale.countryCode == 'US'?
    'en':Provider.of<LocalizationProvider>(context, listen: false).locale.countryCode.toLowerCase();
    Provider.of<SplashProvider>(context,listen: false).getColorList();
    Provider.of<SellerProvider>(context,listen: false).getAttributeList(context, widget.product, languageCode);
    Provider.of<SellerProvider>(context,listen: false).getCategoryList(context,widget.product, languageCode);
    Provider.of<SellerProvider>(context,listen: false).getBrandList(context, languageCode);
    Provider.of<SellerProvider>(context,listen: false).setBrandIndex(0, false);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: Provider.of<SplashProvider>(context,listen: false).configModel.languageList.length,
        initialIndex: 0,vsync: this);

    _tabController?.addListener((){
      print('my index is'+ _tabController.index.toString());
    });

    _load();
    length = Provider.of<SplashProvider>(context,listen: false).configModel.languageList.length;
    _update = widget.product != null;



    if(widget.product != null){
      unitValue = widget.product.unit;
      Provider.of<SellerProvider>(context,listen: false).productCode.text = widget.product.code;
      Provider.of<SellerProvider>(context,listen: false).getEditProduct(context, widget.product.id);
      Provider.of<SellerProvider>(context,listen: false).setValueForUnit(widget.product.unit.toString()) ;
      Provider.of<SellerProvider>(context,listen: false).setProductTypeIndex(widget.product.productType == "physical"? 0 : 1, false) ;
      Provider.of<SellerProvider>(context,listen: false).setDigitalProductTypeIndex(widget.product.digitalProductType == "ready_after_sell"? 0 : 1, false) ;
    }else{
      Provider.of<SellerProvider>(context,listen: false).
      getTitleAndDescriptionList(Provider.of<SplashProvider>(context,listen: false).configModel.languageList, null);
    }

  }

  @override
  Widget build(BuildContext context) {
    List<int> _brandIds;
     return Scaffold(
      appBar: CustomAppBar(title: widget.product != null ?
      getTranslated('update_product', context):getTranslated('add_product', context),),

      body: Container(
        child: Consumer<SellerProvider>(
          builder: (context, resProvider, child){
             _brandIds = [];
            _brandIds.add(0);
            if(resProvider.brandList != null) {
              for(int index=0; index<resProvider.brandList.length; index++) {
                _brandIds.add(resProvider.brandList[index].id);
              }
              if(_update && widget.product.brandId != null) {
                if(brand ==0){
                  resProvider.setBrandIndex(_brandIds.indexOf(widget.product.brandId), false);
                  brand++;
                }

              }
            }
            return widget.product !=null && resProvider.editProduct == null?
            Center(child: CircularProgressIndicator()):
            length != null? Consumer<SplashProvider>(
              builder: (context,splashController,_) {
                return SingleChildScrollView(
                  child: Column(children: [
                    Container(height: 50,width: MediaQuery.of(context).size.width,
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: Theme.of(context).primaryColor,
                        indicatorWeight: 5,
                        indicator: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Theme.of(context).primaryColor, width: 2))),
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: ColorResources.getTextColor(context),
                        unselectedLabelStyle: robotoRegular.copyWith(color: Theme.of(context).disabledColor,
                            fontSize: Dimensions.FONT_SIZE_LARGE),
                        labelStyle: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                            color: Theme.of(context).primaryColor),
                        tabs: _generateTabChildren(),
                      ),
                    ),
                    Container(height: 280,
                      child: TabBarView(
                        controller: _tabController,
                        children: _generateTabPage(resProvider),
                      ),
                    ),

                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    Provider.of<SplashProvider>(context, listen: false).configModel.digitalProductSetting == "1"?
                    DigitalProductWidget(resProvider: resProvider, product: widget.product):SizedBox(),

                    Container(padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, 0, Dimensions.PADDING_SIZE_DEFAULT, 0),
                      child: Column(children: [
                      Row(
                        children: [
                          Text(getTranslated('product_code_sku', context), style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                          Text('*',style: robotoBold.copyWith(color: ColorResources.mainCardFourColor(context),
                              fontSize: Dimensions.FONT_SIZE_DEFAULT),),
                          Spacer(),
                          InkWell(
                            onTap: (){
                              var rng = new Random();
                              var code = rng.nextInt(900000) + 100000;
                              resProvider.productCode.text = code.toString();
                            },
                              child: Text(getTranslated('generate_code', context), style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.mainCardFourColor(context)))),
                        ],
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      CustomTextField(
                        border: true,
                        controller: resProvider.productCode,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                        isAmount: true,
                        hintText: 'Ex: 456565',
                      ),
                    ],),),



                    SizedBox(height:  Provider.of<SplashProvider>(context, listen: false).configModel.brandSetting == "1" ? Dimensions.PADDING_SIZE_SMALL:0),
                    Provider.of<SplashProvider>(context, listen: false).configModel.brandSetting == "1"?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(getTranslated('select_brand', context) , style: robotoRegular.copyWith(
                                  color: ColorResources.titleColor(context), fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                              Text('*',style: robotoBold.copyWith(color: ColorResources.mainCardFourColor(context),
                                  fontSize: Dimensions.FONT_SIZE_DEFAULT),),
                            ],
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              border: Border.all(width: .5, color: Theme.of(context).hintColor.withOpacity(.7)),
                            ),
                            child: DropdownButton<int>(
                              value: resProvider.brandIndex,
                              items: _brandIds.map((int value) {
                                return DropdownMenuItem<int>(
                                  value: _brandIds.indexOf(value),
                                  child: Text(value != 0 ? resProvider.brandList[(_brandIds.indexOf(value)-1)].name : getTranslated('select', context)),
                                );
                              }).toList(),
                              onChanged: (int value) {
                                resProvider.setBrandIndex(value, true);
                                // resProvider.changeBrandSelectedIndex(value);
                              },
                              isExpanded: true,
                              underline: SizedBox(),
                            ),
                          ),

                        ],
                      ),
                    ):SizedBox(),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      child: SelectCategoryWidget(product: widget.product),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                    resProvider.productTypeIndex == 0?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text(getTranslated('select_unit', context), style: robotoRegular.copyWith(
                                color: ColorResources.titleColor(context), fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                            Text('*',style: robotoBold.copyWith(color: ColorResources.mainCardFourColor(context),
                                fontSize: Dimensions.FONT_SIZE_DEFAULT),),
                          ],),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),


                          Container(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                            decoration: BoxDecoration(color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              border: Border.all(width: .5, color: Theme.of(context).hintColor.withOpacity(.7)),
                            ),
                            child: DropdownButton<String>(
                              hint: resProvider.unitValue == null ? Text(getTranslated('select', context)) :
                              Text(resProvider.unitValue, style: TextStyle(color: ColorResources.getTextColor(context)),),
                              items: Provider.of<SplashProvider>(context,listen: false).configModel.unit.map((String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value));}).toList(),
                              onChanged: (val) {
                                unitValue = val;
                                setState(() {resProvider.setValueForUnit(val);},);},
                              isExpanded: true,
                              underline: SizedBox(),
                            ),
                          ),

                        ],
                      ),
                    ):SizedBox(),

                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,)

                  ],),
                );
              }
            ):SizedBox();
          },

        ),),
       bottomNavigationBar: Container(
         padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
         height: 80,
         decoration: BoxDecoration(
           color: Theme.of(context).cardColor,
           boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200],
               spreadRadius: 0.5, blurRadius: 0.3)],
         ),
         child: Consumer<SellerProvider>(
           builder: (context,resProvider, _) {

             return!resProvider.isLoading? Container(height: 50,
               child: InkWell(
               onTap: (){
                 bool _haveBlankTitle = false;
                 bool _haveBlankDes = false;
                 for(TextEditingController title in resProvider.titleControllerList){
                   if(title.text.isEmpty){
                     _haveBlankTitle = true;
                     break;
                   }
                 }
                 for(TextEditingController des in resProvider.descriptionControllerList){
                   if(des.text.isEmpty){
                     _haveBlankDes = true;
                     break;}}

                 if(_haveBlankTitle){
                   showCustomSnackBar(getTranslated('please_input_all_title',context),context);
                 }else if(_haveBlankDes){
                   showCustomSnackBar(getTranslated('please_input_all_des',context),context);
                 }
                 else if ((resProvider.productTypeIndex == 1 &&resProvider.digitalProductTypeIndex == 1 &&
                     resProvider.selectedFileForImport == null) && widget.product == null ) {
                   showCustomSnackBar(getTranslated('please_choose_digital_product',context),context);
                 }

                 else if (resProvider.categoryIndex == 0) {
                   showCustomSnackBar(getTranslated('select_a_category',context),context);
                 }
                 else if (resProvider.brandIndex == 0 && Provider.of<SplashProvider>(context, listen: false).configModel.brandSetting == "1") {
                   showCustomSnackBar(getTranslated('select_a_brand',context),context);
                 }
                 else if (resProvider.unitValue == '' || resProvider.unitValue == null &&  resProvider.productTypeIndex == 0) {
                   showCustomSnackBar(getTranslated('select_a_unit',context),context);
                 }
                 else if (resProvider.productCode.text == '' || resProvider.productCode.text.isEmpty) {
                   showCustomSnackBar(getTranslated('product_code_is_required',context),context);
                 }
                 else if (resProvider.productCode.text.length < 6 || resProvider.productCode.text == '000000') {
                   showCustomSnackBar(getTranslated('product_code_minimum_6_digit',context),context);
                 }
                 else{
                   for(TextEditingController textEditingController in resProvider.titleControllerList) {
                     titleList.add(textEditingController.text.trim());

                   }
                   if((resProvider.productTypeIndex == 1 &&resProvider.digitalProductTypeIndex == 1 &&
                       resProvider.selectedFileForImport == null) && widget.product == null )
                   resProvider.uploadDigitalProduct(Provider.of<AuthProvider>(context,listen: false).getUserToken());


                   Navigator.push(context, MaterialPageRoute(builder: (_) => AddProductNextScreen(
                       categoryId: resProvider.categoryList[resProvider.categoryIndex-1].id.toString(),
                       subCategoryId: resProvider.subCategoryIndex != 0? resProvider.subCategoryList[resProvider.subCategoryIndex-1].id.toString(): "-1",
                       subSubCategoryId: resProvider.subSubCategoryIndex != 0? resProvider.subSubCategoryList[resProvider.subSubCategoryIndex-1].id.toString():"-1",
                       brandId: _brandIds[resProvider.brandIndex].toString(),
                       unit: unitValue,
                       product: widget.product, addProduct: widget.addProduct)));

                 }},
                 child: Container(width: MediaQuery.of(context).size.width, height: 40,
                   decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                     borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                   ),
                   child: Center(child: Text('Continue', style: TextStyle(
                       color: Colors.white,fontWeight: FontWeight.w600,
                       fontSize: Dimensions.FONT_SIZE_LARGE),)),
                 ),
               ),):Row(
               mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Container(width: 40,height: 40, child: CircularProgressIndicator()),
                 ],
               );
           }
         ),
       ),
     );
  }

  List<Widget> _generateTabChildren() {
    List<Widget> _tabs = [];
    for(int index=0; index < Provider.of<SplashProvider>(context, listen: false).configModel.languageList.length; index++) {
      _tabs.add(Text(Provider.of<SplashProvider>(context, listen: false).configModel.languageList[index].name.capitalize(),
          style: robotoBold.copyWith()));
    }
    return _tabs;
  }

  List<Widget> _generateTabPage(SellerProvider resProvider) {
    List<Widget> _tabView = [];
    for(int index=0; index < Provider.of<SplashProvider>(context, listen: false).configModel.languageList.length; index++) {
      _tabView.add(TitleAndDescriptionWidget(resProvider: resProvider, index: index));
    }
    return _tabView;
  }
}


extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}