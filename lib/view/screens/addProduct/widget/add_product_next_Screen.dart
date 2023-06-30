
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/add_product_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/attribute_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/variant_type_model.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/provider/shop_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/attribute_view.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';
import 'package:sixvalley_vendor_app/view/screens/addProduct/widget/add_product_seo_screen.dart';

class AddProductNextScreen extends StatefulWidget {
  final ValueChanged<bool> isSelected;
  final Product product;
  final String categoryId;
  final String subCategoryId;
  final String subSubCategoryId;
  final String brandId;
  final AddProductModel addProduct;
  final String unit;

  AddProductNextScreen({this.isSelected, @required this.product,@required this.addProduct, this.categoryId, this.subCategoryId, this.subSubCategoryId, this.brandId, this.unit});

  @override
  _AddProductNextScreenState createState() => _AddProductNextScreenState();
}

class _AddProductNextScreenState extends State<AddProductNextScreen> {
  bool isSelected = false;
  final FocusNode _discountNode = FocusNode();
  final FocusNode _shippingCostNode = FocusNode();
  final FocusNode _unitPriceNode = FocusNode();
  final FocusNode _purchasePriceNode = FocusNode();
  final FocusNode _taxNode = FocusNode();
  final FocusNode _totalQuantityNode = FocusNode();
  final FocusNode _minimumOrderQuantityNode = FocusNode();


  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _shippingCostController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _purchasePriceController = TextEditingController();
  final TextEditingController _taxController = TextEditingController();
  final TextEditingController _totalQuantityController = TextEditingController();
  final TextEditingController _minimumOrderQuantityController = TextEditingController();


  AutoCompleteTextField searchTextField;


  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  SimpleAutoCompleteTextField textField;
  bool showWhichErrorText = false;
  bool _update;
  Product _product;
  String thumbnailImage ='', metaImage ='';
  List<String> productImage =[];
  int counter = 0, total = 0;
  int addColor = 0;
  int cat=0, subCat=0, subSubCat=0, unit=0, brand=0;


  void _load(){
    String languageCode = Provider.of<LocalizationProvider>(context, listen: false).locale.countryCode == 'US'?
    'en':Provider.of<LocalizationProvider>(context, listen: false).locale.countryCode.toLowerCase();
    Provider.of<SplashProvider>(context,listen: false).getColorList();
    Provider.of<SellerProvider>(context,listen: false).getAttributeList(context, widget.product, languageCode);
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _product = widget.product;
    _update = widget.product != null;
    _taxController.text = '0';
    _discountController.text = '0';
    _shippingCostController.text = '0';
    _totalQuantityController.text = '1';
    _minimumOrderQuantityController.text = '1';
    _load();
    if(_update) {

      _unitPriceController.text = PriceConverter.convertPriceWithoutSymbol(context, _product.unitPrice);
      _taxController.text = _product.tax.toString();
      _totalQuantityController.text = _product.currentStock.toString();
      _shippingCostController.text = _product.shippingCost.toString();
      _minimumOrderQuantityController.text = _product.minimumOrderQty.toString();
      Provider.of<SellerProvider>(context, listen: false).setDiscountTypeIndex(_product.discountType == 'percent' ? 0 : 1, false);
      _discountController.text = _product.discountType == 'percent' ?
      _product.discount.toString() : PriceConverter.convertPriceWithoutSymbol(context, _product.discount);
      _purchasePriceController.text = PriceConverter.convertPriceWithoutSymbol(context, _product.purchasePrice);
      thumbnailImage = _product.thumbnail;
      metaImage = _product.metaImage;
      productImage = _product.images;
      Provider.of<SellerProvider>(context, listen: false).setTaxTypeIndex(_product.taxModel == 'include' ? 0 : 1, false);

    }else {
      _product = Product();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title:  widget.product != null ?
      getTranslated('update_product', context):
      getTranslated('add_product', context),),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
        ),
        padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: Consumer<SellerProvider>(
            builder: (context, resProvider, child){
              List<int> _brandIds = [];
              List<int> _colors = [];
              _brandIds.add(0);
              _colors.add(0);


                if (_update && Provider.of<SellerProvider>(context, listen: false).attributeList != null &&
                    Provider.of<SellerProvider>(context, listen: false).attributeList.length > 0) {
                  if(addColor==0) {
                    addColor++;
                    if ( widget.product.colors != null && widget.product.colors.length > 0) {
                      Future.delayed(Duration.zero, () async {
                        Provider.of<SellerProvider>(context, listen: false).setAttribute();
                      });
                    }
                    for (int index = 0; index < widget.product.colors.length; index++) {
                      _colors.add(index);
                      Future.delayed(Duration.zero, () async {
                        resProvider.addVariant(context,0, widget.product.colors[index].name, widget.product, false);
                        resProvider.addColorCode(widget.product.colors[index].code);
                      });
                    }
                  }

                }



              return SingleChildScrollView(
                child: (resProvider.attributeList != null &&
                    resProvider.attributeList.length > 0 &&
                    resProvider.categoryList != null &&
                    Provider.of<SplashProvider>(context,listen: false).colorList!= null) ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    resProvider.productTypeIndex == 0?
                   Container(child: Column(children: [
                     Padding(
                       padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                       child: Row(mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(getTranslated('variations', context),
                               style: robotoBold.copyWith(color: ColorResources.getHeadTextColor(context),
                                   fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)),
                         ],
                       ),
                     ),
                     SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                     Row(children: [
                       Text(getTranslated('add_color_variation', context),
                           style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                       Spacer(),

                       FlutterSwitch(width: 60.0, height: 30.0, toggleSize: 28.0,
                         value: resProvider.attributeList[0].active,
                         borderRadius: 20.0,
                         activeColor: Theme.of(context).primaryColor,
                         padding: 1.0,
                         onToggle:(bool isActive) =>resProvider.toggleAttribute(context, 0, widget.product),
                       ),
                     ],),
                     SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                     resProvider.attributeList[0].active?
                     Consumer<SplashProvider>(builder: (ctx, colorProvider, child){
                       if (colorProvider.colorList != null) {
                         for (int index = 0; index < colorProvider.colorList.length; index++) {
                           _colors.add(index);
                         }
                       }
                       return Autocomplete<int>(
                         optionsBuilder: (TextEditingValue value) {
                           if (value.text.isEmpty) {
                             return Iterable<int>.empty();
                           } else {
                             return _colors.where((color) => colorProvider.colorList[color].
                             name.toLowerCase().contains(value.text.toLowerCase()));
                           }
                         },
                         fieldViewBuilder:
                             (context, controller, node, onComplete) {
                           return Container(
                             height: 50,
                             decoration: BoxDecoration(color: Theme.of(context).cardColor,
                               border: Border.all(width: 1, color: Theme.of(context).hintColor.withOpacity(.50)),
                               borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                             ),
                             child: TextField(
                               controller: controller,
                               focusNode: node, onEditingComplete: onComplete,
                               decoration: InputDecoration(
                                 hintText: getTranslated('type_color_name', context),
                                 border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(
                                         Dimensions.PADDING_SIZE_SMALL),
                                     borderSide: BorderSide.none),
                               ),
                             ),
                           );
                         },
                         displayStringForOption: (value) => colorProvider.colorList[value].name,
                         onSelected: (int value) {
                           resProvider.addVariant(context, 0,colorProvider.colorList[value].name, widget.product, true);
                           resProvider.addColorCode(colorProvider.colorList[value].code);
                         },
                       );
                     }):SizedBox(),


                     SizedBox(height: resProvider.selectedColor.length != null ? Dimensions.PADDING_SIZE_SMALL : 0),

                     SizedBox(height: (resProvider.attributeList[0].variants.length != null &&
                         resProvider.attributeList[0].variants.length > 0) ? 40 : 0,
                       child: (resProvider.attributeList[0].variants.length != null &&
                           resProvider.attributeList[0].variants.length > 0) ?

                       ListView.builder(
                         itemCount: resProvider.attributeList[0].variants.length,
                         scrollDirection: Axis.horizontal,
                         itemBuilder: (context, index) {
                           return Padding(
                             padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_VERY_TINY),
                             child: Container(
                               padding: EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_MEDIUM),
                               margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                               decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(.20),
                                 borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
                               ),
                               child: Row(children: [
                                 Consumer<SplashProvider>(builder: (ctx, colorP,child){
                                   return Text(resProvider.attributeList[0].variants[index],
                                     style: robotoRegular.copyWith(color: ColorResources.titleColor(context)),);
                                 }),
                                 SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                                 InkWell(
                                   onTap: (){resProvider.removeVariant(context, 0, index, widget.product);
                                   resProvider.removeColorCode(index);},
                                   child: Icon(Icons.close, size: 15, color: ColorResources.titleColor(context)),
                                 ),
                               ]),
                             ),
                           );
                         },
                       ):SizedBox(),
                     ),



                     /*------------------Attribute View-------------------*/

                     SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                     AttributeView(product: widget.product, colorOn: resProvider.attributeList[0].active),
                   ],)):SizedBox(),



                    SizedBox(height: resProvider.productTypeIndex == 0? 0 : Dimensions.PADDING_SIZE_DEFAULT),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(getTranslated('product_price_and_stock',context),
                            style: robotoBold.copyWith(color: ColorResources.getHeadTextColor(context),
                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)),
                      ],
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    Text(getTranslated('unit_price', context),
                        style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    CustomTextField(
                      border: true,
                      controller: _unitPriceController,
                      focusNode: _unitPriceNode,
                      nextNode: _purchasePriceNode,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      isAmount: true,
                      hintText: 'Ex: \$129',
                    ),

                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),



                    Text(getTranslated('purchase_price', context),
                        style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    CustomTextField(
                      border: true,
                      controller: _purchasePriceController,
                      focusNode: _purchasePriceNode,
                      nextNode: _taxNode,
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      isAmount: true,
                      hintText: 'Ex: \$120',
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),



                    Row(children: [
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(getTranslated('tax_model', context),
                          style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),),
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),



                        Container(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                          decoration: BoxDecoration(color: Theme.of(context).cardColor,
                            border: Border.all(width: .7,color: Theme.of(context).hintColor.withOpacity(.3)),
                            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),

                          ),
                          child: DropdownButton<String>(
                            value: resProvider.taxTypeIndex == 0 ? 'include' : 'exclude',
                            items: <String>['include', 'exclude'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              resProvider.setTaxTypeIndex(value == 'include' ? 0 : 1, true);
                            },
                            isExpanded: true,
                            underline: SizedBox(),
                          ),
                        ),
                      ])),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),



                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getTranslated('tax_p',context),
                              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          CustomTextField(
                            border: true,
                            controller: _taxController,
                            focusNode: _taxNode,
                            nextNode: _discountNode,
                            isAmount: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            hintText: 'Ex: \$10',
                          ),
                        ],
                      )),
                    ]),



                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),





                    Row(children: [
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(getTranslated('discount_type', context),
                          style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),),
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),



                        Container(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                          decoration: BoxDecoration(color: Theme.of(context).cardColor,
                            border: Border.all(width: .7,color: Theme.of(context).hintColor.withOpacity(.3)),
                            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),

                          ),
                          child: DropdownButton<String>(
                            value: resProvider.discountTypeIndex == 0 ? 'percent' : 'flat',
                            items: <String>['percent', 'flat'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              resProvider.setDiscountTypeIndex(value == 'percent' ? 0 : 1, true);
                            },
                            isExpanded: true,
                            underline: SizedBox(),
                          ),
                        ),
                      ])),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),



                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getTranslated('discount_amount', context),
                            style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          CustomTextField(
                            border: true,
                            hintText: getTranslated('discount', context),
                            controller: _discountController,
                            focusNode: _discountNode,
                            nextNode: _shippingCostNode,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            isAmount: true,
                            // isAmount: true,
                          ),
                        ],
                      )),
                    ]),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),



                    Row(children: [
                      resProvider.productTypeIndex == 0?
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(getTranslated('total_quantity', context),
                            style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        CustomTextField(
                          border: true,
                          textInputType: TextInputType.number,
                          focusNode: _totalQuantityNode,
                          controller: _totalQuantityController,
                          textInputAction: TextInputAction.next,
                          isAmount: true,
                          hintText: 'Ex: 500',
                        ),
                      ],)): SizedBox(),

                      SizedBox(width: resProvider.productTypeIndex == 0? Dimensions.PADDING_SIZE_DEFAULT:0),

                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(getTranslated('minimum_order_quantity', context),
                            style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        CustomTextField(
                          border: true,
                          textInputType: TextInputType.number,
                          focusNode: _minimumOrderQuantityNode,
                          controller: _minimumOrderQuantityController,
                          textInputAction: TextInputAction.next,
                          isAmount: true,
                          hintText: 'Ex: 500',
                        ),
                      ],)),
                    ],),



                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),



                    //__________Shipping__________
                    resProvider.productTypeIndex == 0?
                    Container(child: Column(children: [
                      Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                        Text(getTranslated('shipping',context),
                            style: robotoBold.copyWith(color: ColorResources.getHeadTextColor(context),
                                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)),
                      ],),

                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getTranslated('shipping_cost', context),
                            style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          CustomTextField(
                            border: true,
                            controller: _shippingCostController,
                            focusNode: _shippingCostNode,
                            nextNode: _totalQuantityNode,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            isAmount: true,
                            // isAmount: true,
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(getTranslated('shipping_cost_multiply', context),
                                style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),
                              ),
                              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                              Text(getTranslated('shipping_cost_multiply_by_item', context),
                                style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                                    color: Theme.of(context).hintColor),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                        FlutterSwitch(width: 60.0, height: 30.0, toggleSize: 30.0,
                          value: resProvider.isMultiply,
                          borderRadius: 20.0,
                          activeColor: Theme.of(context).primaryColor,
                          padding: 1.0,
                          onToggle:(bool isActive) =>resProvider.toggleMultiply(context),
                        ),

                      ]),
                      SizedBox(height: Dimensions.ICON_SIZE_LARGE),
                    ],),):SizedBox(),

                  ],):

                Padding(padding: const EdgeInsets.only(top: 300.0),
                  child: Center(child: CircularProgressIndicator()),),
              );
            },

          ),
        ),
      ),


      bottomNavigationBar: Container(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200],
              spreadRadius: 0.5, blurRadius: 0.3)],
        ),
        height: 80,child: Row(children: [
          Expanded(child: InkWell(
            onTap: ()=>Navigator.pop(context),
            child: CustomButton(
              isColor: true,
              btnTxt: '${getTranslated('back', context)}',
              backgroundColor: Theme.of(context).hintColor,),
          )),
        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),


        Expanded(child: Consumer<SellerProvider>(
          builder: (context,resProvider, _) {
            return CustomButton(
              btnTxt:  getTranslated('next', context),
              onTap: (){
                String _unitPrice =_unitPriceController.text.trim();
                String _purchasePrice =_purchasePriceController.text.trim();
                String _currentStock = _totalQuantityController.text.trim();
                String _orderQuantity = _minimumOrderQuantityController.text.trim();
                String _tax = _taxController.text.trim();
                String _discount = _discountController.text.trim();
                String _shipping = _shippingCostController.text.trim();
                bool _haveBlankVariant = false;
                bool _blankVariantPrice = false;
                bool _blankVariantQuantity = false;
                for (AttributeModel attr in resProvider.attributeList) {
                  if (attr.active && attr.variants.length == 0) {
                    _haveBlankVariant = true;
                    break;
                  }
                }

                for (VariantTypeModel variantType in resProvider.variantTypeList) {
                  if (variantType.controller.text.isEmpty) {
                    _blankVariantPrice = true;
                    break;
                  }
                }
                for (VariantTypeModel variantType in resProvider.variantTypeList) {
                  if (variantType.qtyController.text.isEmpty) {
                    _blankVariantQuantity = true;
                    break;
                  }
                }
                if (_unitPrice.isEmpty) {
                  showCustomSnackBar(getTranslated('enter_unit_price', context),context);
                }

                else if (_purchasePrice.isEmpty) {
                  showCustomSnackBar(getTranslated('enter_purchase_price', context),context);
                }
                else if (_currentStock.isEmpty &&  resProvider.productTypeIndex == 0) {
                  showCustomSnackBar(getTranslated('enter_total_quantity', context),context);
                }
                else if (_orderQuantity.isEmpty) {
                  showCustomSnackBar(getTranslated('enter_minimum_order_quantity', context),context);
                }

                else if (_haveBlankVariant) {
                  showCustomSnackBar(getTranslated('add_at_least_one_variant_for_every_attribute',context),context);
                } else if (_blankVariantPrice) {
                  showCustomSnackBar(getTranslated('enter_price_for_every_variant', context),context);
                }else if (_blankVariantQuantity) {
                  showCustomSnackBar(getTranslated('enter_quantity_for_every_variant', context),context);
                }

                else {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => AddProductSeoScreen(
                      unitPrice: _unitPrice,
                      purchasePrice: _purchasePrice,
                      tax: _tax,
                      unit: widget.unit,
                      categoryId: widget.categoryId,
                      subCategoryId: widget.subCategoryId,
                      subSubCategoryId: widget.subSubCategoryId,
                      brandyId: widget.brandId,
                      discount: _discount,
                      currentStock: _currentStock,
                      minimumOrderQuantity: _orderQuantity,
                      shippingCost: _shipping,
                      product: widget.product, addProduct: widget.addProduct)));
                }
              },
            );
          }
        )),
      ],),),
    );
  }
}
