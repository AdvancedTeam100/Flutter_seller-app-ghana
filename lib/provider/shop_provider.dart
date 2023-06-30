import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/add_product_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/attr.dart';
import 'package:sixvalley_vendor_app/data/model/response/attribute_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/error_response.dart';
import 'package:sixvalley_vendor_app/data/model/response/brand_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/category_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/config_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/edt_product_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/image_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/variant_type_model.dart';
import 'package:sixvalley_vendor_app/data/repository/seller_repo.dart';
import 'package:sixvalley_vendor_app/helper/api_checker.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/screens/dashboard/dashboard_screen.dart';

class SellerProvider extends ChangeNotifier {
  final SellerRepo shopRepo;

  SellerProvider({@required this.shopRepo});

  int _totalQuantity =0;
  int get totalQuantity => _totalQuantity;
  String _unitValue;
  String get unitValue => _unitValue;


  List<AttributeModel> _attributeList = [];
  int _discountTypeIndex = 0;
  int _taxTypeIndex = 0;
  List<CategoryModel> _categoryList;
  List<BrandModel> _brandList;
  List<SubCategory> _subCategoryList;
  List<SubSubCategory> _subSubCategoryList;
  int _categorySelectedIndex;
  int _subCategorySelectedIndex;
  int _subSubCategorySelectedIndex;
  int _categoryIndex = 0;
  int _subCategoryIndex = 0;
  int _subSubCategoryIndex = 0;
  int _brandIndex = 0;
  int _unitIndex = 0;
  int get unitIndex => _unitIndex;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int get categorySelectedIndex => _categorySelectedIndex;
  int get subCategorySelectedIndex => _subCategorySelectedIndex;
  int get subSubCategorySelectedIndex => _subSubCategorySelectedIndex;
  List<int> _selectedColor = [];
  List<int> get selectedColor =>_selectedColor;

  List<int> _categoryIds = [];
  List<int> _subCategoryIds = [];
  List<int> _subSubCategoryIds = [];
  List<int> get categoryIds => _categoryIds;
  List<int> get subCategoryIds => _subCategoryIds;
  List<int> get subSubCategoryIds => _subSubCategoryIds;




  EditProduct _editProduct;
  EditProduct get editProduct => _editProduct;
  List<VariantTypeModel> _variantTypeList =[];
  List<AttributeModel> get attributeList => _attributeList;
  int get discountTypeIndex => _discountTypeIndex;
  int get taxTypeIndex => _taxTypeIndex;
  List<CategoryModel> get categoryList => _categoryList;
  List<SubCategory> get subCategoryList => _subCategoryList;
  List<SubSubCategory> get subSubCategoryList => _subSubCategoryList;
  List<BrandModel> get brandList => _brandList;
  XFile _pickedLogo;
  XFile _pickedCover;
  XFile _pickedMeta;
  XFile _coveredImage;
  List <XFile>_productImage = [];


  XFile get pickedLogo => _pickedLogo;
  XFile get pickedCover => _pickedCover;
  XFile get pickedMeta => _pickedMeta;
  XFile get coveredImage => _coveredImage;
  List<XFile> get productImage => _productImage;
  int get categoryIndex => _categoryIndex;
  int get subCategoryIndex => _subCategoryIndex;
  int get subSubCategoryIndex => _subSubCategoryIndex;
  int get brandIndex => _brandIndex;
  List<VariantTypeModel> get variantTypeList => _variantTypeList;
  final picker = ImagePicker();
  List<TextEditingController> _titleControllerList = [];
  List<TextEditingController> _descriptionControllerList = [];
  List<String> _colorCodeList =[];
  List<String> get colorCodeList => _colorCodeList;

  List<TextEditingController>  get titleControllerList=> _titleControllerList;
  List<TextEditingController> get descriptionControllerList=> _descriptionControllerList;

  TextEditingController _productCode = TextEditingController();
  TextEditingController get productCode => _productCode;

  List<FocusNode> _titleNode;
  List<FocusNode> _descriptionNode;
  List<FocusNode> get titleNode => _titleNode;
  List<FocusNode> get descriptionNode => _descriptionNode;
  int _productTypeIndex = 0;
  int get productTypeIndex => _productTypeIndex;

  int _digitalProductTypeIndex = 0;
  int get digitalProductTypeIndex => _digitalProductTypeIndex;
  File _selectedFileForImport ;
  File get selectedFileForImport =>_selectedFileForImport;
  String _digitalProductFileName;
  String  get digitalProductFileName =>_digitalProductFileName;





  void setTitle(int index, String title) {
    _titleControllerList[index].text = title;
  }
  void setDescription(int index, String description) {
    _descriptionControllerList[index].text = description;
  }


  getTitleAndDescriptionList(List<Language> languageList, EditProduct edtProduct){

    _titleControllerList = [];
    _descriptionControllerList = [];
    for(int i= 0; i<languageList.length; i++){

      if(edtProduct != null){

        if(i==0){
          _titleControllerList.insert(i,TextEditingController(text: edtProduct.name)) ;
          _descriptionControllerList.add(TextEditingController(text: edtProduct.details)) ;
        } else{
          edtProduct.translations.forEach((lan) {

            if(lan.locale == languageList[i].code && lan.key == 'name'){
              _titleControllerList.add(TextEditingController(text: lan.value)) ;

            }
            if(lan.locale == languageList[i].code && lan.key == 'description'){
              _descriptionControllerList.add(TextEditingController(text: lan.value));
            }
          });

        }

      }
      else{
        _titleControllerList.add(TextEditingController());
        _descriptionControllerList.add(TextEditingController());

      }
    }
    if(edtProduct != null){
      if(_titleControllerList.length < languageList.length) {
        int _l = languageList.length-_titleControllerList.length;
        for(int i=0; i<_l; i++) {
          _titleControllerList.add(TextEditingController(text: editProduct.name));
        }
      }
      if(_descriptionControllerList.length < languageList.length) {
        int _l = languageList.length-_descriptionControllerList.length;
        for(int i=0; i<_l; i++) {
          _descriptionControllerList.add(TextEditingController(text: editProduct.details));
        }
      }
    }else {
      if(_titleControllerList.length < languageList.length) {
        int _l = languageList.length-_titleControllerList.length;
        for(int i=0; i<_l; i++) {
          _titleControllerList.add(TextEditingController());
        }
      }
      if(_descriptionControllerList.length < languageList.length) {
        int _l = languageList.length-_descriptionControllerList.length;
        for(int i=0; i<_l; i++) {
          _descriptionControllerList.add(TextEditingController());
        }
      }
    }
  }

  void getAttributeList(BuildContext context, Product product, String language) async {
    _attributeList = null;
    _discountTypeIndex = 0;
    _categoryIndex = 0;
    _subCategoryIndex = 0;
    _subSubCategoryIndex = 0;
    _pickedLogo = null;
    _pickedMeta = null;
    _pickedCover = null;
    _selectedColor = [];
    _variantTypeList = [];
    ApiResponse response = await shopRepo.getAttributeList(language);
    if (response.response != null && response.response.statusCode == 200) {
      _attributeList = [];
      _attributeList.add(AttributeModel(attribute: Attr(id : 0, name:'ColorX'), active: false,
          controller: TextEditingController(), variants: []));
      response.response.data.forEach((attribute) {
        if (product != null && product.attributes!=null) {
          bool _active = product.attributes.contains(Attr.fromJson(attribute).id);
          print('--------${Attr.fromJson(attribute).id}/$_active/${product.attributes}');
          List<String> _options = [];
          if (_active) {
            _options.addAll(product.choiceOptions[product.attributes.indexOf(Attr.fromJson(attribute).id)].options);
            print('----option---->${_options.length}/${product.toJson()}');
          }
          _attributeList.add(AttributeModel(
            attribute: Attr.fromJson(attribute),
            active: _active,
            controller: TextEditingController(), variants: _options,
          ));
        } else {
          _attributeList.add(
              AttributeModel(attribute: Attr.fromJson(attribute), active: false,
                controller: TextEditingController(), variants: [],
              ));
        }
      });




    } else {
      ApiChecker.checkApi(context, response);
    }
   notifyListeners();

  }


  void setAttributeItemList(int index){
    _attributeList[index].active = true;


  }

  void removeImage(int index,bool fromColor){
    if(fromColor){
      print('==$index/${withColor[index].image}/${withColor[index].color}');
      withColor[index].image = null;
    }else{
      withoutColor.removeAt(index);
    }

    notifyListeners();
  }


  void setAttribute(){
    _attributeList[0].active = true;
  }
  String discountType= 'flat';

  void setDiscountTypeIndex(int index, bool notify) {
    _discountTypeIndex = index;
    if(_discountTypeIndex == 0){
      discountType = 'percent';
    }else{
      discountType = 'flat';
    }
    print('-------bb===>$discountType/$_discountTypeIndex');
    if(notify) {
      notifyListeners();
    }
  }


  void setTaxTypeIndex(int index, bool notify) {
    _taxTypeIndex = index;
    if(notify) {
      notifyListeners();
    }
  }

  void toggleAttribute(BuildContext context,int index, Product product) {
    _attributeList[index].active = !_attributeList[index].active;
    generateVariantTypes(context,product);
    notifyListeners();

  }
  bool _isMultiply = false;
  bool get isMultiply => _isMultiply;
  void toggleMultiply(BuildContext context) {
    _isMultiply = !_isMultiply;
    notifyListeners();

  }

  void addVariant(BuildContext context, int index, String variant, Product product, bool notify) {
    _attributeList[index].variants.add(variant);
    generateVariantTypes(context,product);
    if(notify) {
      notifyListeners();
    }
  }
  void addColorCode(String colorCode){
    _colorCodeList.add(colorCode);
    withColor.add(ImageModel(color: colorCode));
    notifyListeners();

  }
  void removeColorCode(int index){
    _colorCodeList.removeAt(index);
    withColor.removeAt(index);
    notifyListeners();
  }



  void removeVariant(BuildContext context,int mainIndex, int index, Product product) {
    _attributeList[mainIndex].variants.removeAt(index);
    generateVariantTypes(context, product);
    notifyListeners();
  }


  Future<void> getBrandList(BuildContext context, String language) async {
    ApiResponse response = await shopRepo.getBrandList(language);
    if (response.response.statusCode == 200) {
      _brandList = [];
      response.response.data.forEach((brand) => _brandList.add(BrandModel.fromJson(brand)));
    } else {
      ApiChecker.checkApi(context,response);
    }

    notifyListeners();

  }

  List<bool> _selectedCategory = [];
  List<bool> get selectedCategory => _selectedCategory;

  void setSelectedCategoryForFilter(int index, bool selected){
    _selectedCategory[index] = selected;
    notifyListeners();
  }

  Future<void> getCategoryList(BuildContext context, Product product, String language) async {
    _categoryIds =[];
    _subCategoryIds =[];
    _subSubCategoryIds =[];
    _categoryIds.add(0);
    _subCategoryIds.add(0);
    _subSubCategoryIds.add(0);
    _categoryIndex = 0;
    _colorCodeList =[];
    _selectedCategory = [];
    ApiResponse response = await shopRepo.getCategoryList(language);
    if (response.response != null && response.response.statusCode == 200) {
      _categoryList = [];
      response.response.data.forEach((category) => _categoryList.add(CategoryModel.fromJson(category)));
      _categoryIndex = 0;

      for(int index = 0; index < _categoryList.length; index++) {
        _categoryIds.add(_categoryList[index].id);
        _selectedCategory.add(false);
      }

      if(product != null){
        setCategoryIndex(_categoryIds.indexOf(int.parse(product.categoryIds[0].id)), false);
        getSubCategoryList(context,_categoryIds.indexOf(int.parse(product.categoryIds[0].id)), false, product);
        if (_subCategoryList != null) {
          for (int index = 0; index < _subCategoryList.length; index++) {
            _subCategoryIds.add(_subCategoryList[index].id);
          }

          if(product.categoryIds.length>1){
            setSubCategoryIndex(_subCategoryIds.indexOf(int.parse(product.categoryIds[1].id)), false);
            getSubSubCategoryList(context, _subCategoryIds.indexOf(int.parse(product.categoryIds[1].id)), false);

          }
        }

        if (_subSubCategoryList != null) {
          for (int index = 0; index < _subSubCategoryList.length; index++) {
            _subSubCategoryIds.add(_subSubCategoryList[index].id);
          }
          if(product.categoryIds.length>2){
            setSubSubCategoryIndex(_subSubCategoryIds.indexOf(int.parse(product.categoryIds[2].id)), false);
            setSubSubCategoryIndex(_subSubCategoryIds.indexOf(int.parse(product.categoryIds[2].id)), false);
          }
        }
      }



    } else {
      ApiChecker.checkApi(context,response);
    }
    notifyListeners();
  }



  Future<void> getSubCategoryList(BuildContext context, int selectedIndex, bool notify, Product product) async {

    _subCategoryIndex = 0;
    if(categoryIndex != 0) {
      _subCategoryList = [];
      _subCategoryList.addAll(_categoryList[categoryIndex-1].subCategories);
    }
    if(notify){
      _subCategoryIds = [];
      _subCategoryIds.add(0);
      _subCategoryIndex = 0;
      _subSubCategoryIds = [];
      _subSubCategoryIds.add(0);
      _subSubCategoryIndex = 0;
      _subCategoryList.forEach((element) {
        _subCategoryIds.add(element.id);
      });
      notifyListeners();
    }

  }

  Future<void> getEditProduct(BuildContext context,int id) async {
    _editProduct = null;
    ApiResponse response = await shopRepo.getEditProduct(id);
    if (response.response != null && response.response.statusCode == 200) {
      _editProduct = EditProduct.fromJson(response.response.data);
      getTitleAndDescriptionList(Provider.of<SplashProvider>(context,listen: false).configModel.languageList, _editProduct);
    } else {
      ApiChecker.checkApi(context,response);
    }
    notifyListeners();
  }



  Future<void> getSubSubCategoryList(BuildContext context,int selectedIndex, bool notify) async {
    _subSubCategoryIndex = 0;
    if(_subCategoryIndex != 0) {
      _subSubCategoryList = [];
      _subSubCategoryList.addAll(subCategoryList[_subCategoryIndex-1].subSubCategories);
    }
    if(notify){
      _subSubCategoryIds = [];
      _subSubCategoryIds.add(0);
      _subSubCategoryIndex = 0;
      if(_subSubCategoryList.length>0){
        _subSubCategoryList.forEach((element) {
          _subSubCategoryIds.add(element.id);
        });
      }
      notifyListeners();
    }

  }

  ImageModel thumbnail;
  ImageModel metaImage;
  // ImageModel productImage;
  // List<ImageModel> colorWithImage = [];
  List<ImageModel> withColor = [];
  List<ImageModel> withoutColor = [];
  List<ColorImage> colorImageObject = [];



  void pickImage(bool isLogo,bool isMeta, bool isRemove, int index) async {
    print('======>Again=====>');
    if(isRemove) {
      _pickedLogo = null;
      _pickedCover = null;
      _pickedMeta = null;
      _coveredImage = null;
      _productImage = [];
      // colorWithImage = [];
      withColor =[];
      withoutColor =[];
      List<ColorImage> colorImageObject =[];
    }else {
      if (isLogo) {
        _pickedLogo = await ImagePicker().pickImage(source: ImageSource.gallery);
        if(_pickedLogo != null){
          thumbnail = ImageModel(type: 'thumbnail', color: '', image: _pickedLogo);
        }

      } else if(isMeta){
        _pickedMeta = await ImagePicker().pickImage(source: ImageSource.gallery);
        if(_pickedMeta != null){
          metaImage = ImageModel(type: 'meta', color: '', image: _pickedMeta);
        }

      }else {
          _coveredImage = await ImagePicker().pickImage(source: ImageSource.gallery);
          if (_coveredImage != null && index != null) {
            //colorWithImage[index].image =  _coveredImage;
            //colorWithImage[index].type =  'product';
            withColor[index].image =  _coveredImage;
            withColor[index].type =  'product';

          }else if(_coveredImage != null) {
           // colorWithImage.add(ImageModel(image: _coveredImage, type: 'product',color: ''));
            withoutColor.add(ImageModel(image: _coveredImage, type: 'product',color: ''));
          }
      }
    }

    notifyListeners();

  }

  void setSelectedColorIndex(int index, bool notify) {
    if(!_selectedColor.contains(index)) {
      _selectedColor.add(index);
      if(notify) {
        notifyListeners();
      }
    }notifyListeners();
  }


  void setBrandIndex(int index, bool notify) {
    _brandIndex = index;
    if(notify) {
      notifyListeners();
    }
  }
  void setUnitIndex(int index, bool notify) {
    _unitIndex = index;
    if(notify) {
      notifyListeners();
    }
  }

  void setCategoryIndex(int index, bool notify) {
    _categoryIndex = index;
    if(notify) {
      notifyListeners();
    }
  }

  void setSubCategoryIndex(int index, bool notify) {
    _subCategoryIndex = index;
    if(notify) {
      notifyListeners();
    }
  }
  void setSubSubCategoryIndex(int index, bool notify) {
    _subSubCategoryIndex = index;
    if(notify) {
      notifyListeners();
    }
  }


  void setStringImage(int index, String image, String colorCode) {
    withColor[index].imageString = image;
    withColor[index].colorImage = ColorImage(color: colorCode, imageName: image);
  }


  List<String> productReturnImage  = [];

  Future addProductImage(BuildContext context, ImageModel imageForUpload, Function callback) async {

    //print('checkimage=>${colorWithImage.length}');
    productReturnImage = [];
    _isLoading = true;
    notifyListeners();
    ApiResponse response = await shopRepo.addImage(context, imageForUpload, attributeList[0].active);
    if(response.response != null && response.response.statusCode == 200) {
      _isLoading = false;

      Map map = jsonDecode(response.response.data);
      String name = map["image_name"];
      String type = map["type"];
      if(type == 'product'){
        productReturnImage.add(name);
        if(attributeList[0].active){
          colorImageObject.add(ColorImage(color:  map['color_image'] != null ? map['color_image']['color'] : null, imageName: name));
        }else{
          colorImageObject = [];
        }


      }
      callback(true, name, type, map['color_image'] != null ? map['color_image']['color'] : null);
      notifyListeners();
    }else {
      _isLoading = false;
      ApiChecker.checkApi(context, response);
      showCustomSnackBar(getTranslated('image_upload_failed', context), context);

    }
    notifyListeners();


  }




  Future<void> addProduct(BuildContext context, Product product, AddProductModel addProduct, List<String> productImages, List<ColorImage> colorImageObject, String thumbnail, String metaImage, String token, bool isAdd,bool isActiveColor, List<String> tags) async {
    _isLoading = true;
    notifyListeners();
    Map<String, dynamic> _fields = Map();
    if(_variantTypeList.length > 0) {
      List<int> _idList = [];
      List<String> _nameList = [];
      _attributeList.forEach((attributeModel) {
        if(attributeModel.active) {
          if(attributeModel.attribute.id != 0) {
            _idList.add(attributeModel.attribute.id);
            _nameList.add(attributeModel.attribute.name);
          }
          List<String> _variantString = [];
          attributeModel.variants.forEach((variant) {
            _variantString.add(variant);
          });
          _fields.addAll(<String, dynamic>{'choice_options_${attributeModel.attribute.id}': _variantString});
        }
      });
      _fields.addAll(<String, dynamic> {
        'choice_attributes': _idList, 'choice_no': _idList, 'choice': _nameList
      });

      for(int index=0; index<_variantTypeList.length; index++) {
        _fields.addAll(<String, dynamic> {'price_${_variantTypeList[index].variantType}': PriceConverter.systemCurrencyToDefaultCurrency(double.parse(_variantTypeList[index].controller.text), context)});
        _fields.addAll(<String, dynamic> {'qty_${_variantTypeList[index].variantType}': int.parse(_variantTypeList[index].qtyController.text)});
        _fields.addAll(<String, dynamic> {'sku_${_variantTypeList[index].variantType}': ""});

        _totalQuantity += int.parse(_variantTypeList[index].qtyController.text);

      }
      print('=====Total Quantity======>$_totalQuantity');
    }
    ApiResponse response = await shopRepo.addProduct(product,addProduct ,_fields, productImages, thumbnail, metaImage, token, isAdd, isActiveColor,colorImageObject, tags);
    if(response.response != null && response.response.statusCode == 200) {
      _productCode.clear();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => DashboardScreen()), (route) => false);
      showCustomSnackBar(isAdd ? getTranslated('product_added_successfully', context): getTranslated('product_updated_successfully', context),context, isError: false);
       titleControllerList.clear();
      descriptionControllerList.clear();
      _pickedLogo = null;
      _pickedCover = null;
      _coveredImage =null;
      _productImage = [];
      colorImageObject = [];
      productReturnImage=[];
      withColor = [];
      withoutColor = [];
      _isLoading = false;
      _selectedFileForImport = null;
      _digitalProductFileName = '';
        }else {
      //colorWithImage = [];
      productReturnImage =[];
      withColor = [];
      colorImageObject = [];
      withoutColor = [];
      _isLoading = false;
      ApiChecker.checkApi(context, response);
      showCustomSnackBar(getTranslated('product_add_failed', context), context);
    }
    _isLoading = false;

    notifyListeners();

  }

  Future<void> deleteProduct(BuildContext context, int productID) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse response = await shopRepo.deleteProduct(productID);
    if(response.response.statusCode == 200) {
      Navigator.pop(context);
      showCustomSnackBar(getTranslated('product_deleted_successfully', context),context, isError: false);

    }else {
      ApiChecker.checkApi(context,response);
    }
    notifyListeners();
  }

  void generateVariantTypes(BuildContext context, Product product) {
    List<List<String>> _mainList = [];
    int _length = 1;
    bool _hasData = false;
    List<int> _indexList = [];
    _variantTypeList = [];
    _attributeList.forEach((attribute) {
      if(attribute.active) {
        _hasData = true;
        _mainList.add(attribute.variants);
        _length = _length * attribute.variants.length;
        _indexList.add(0);
      }
    });
    if(!_hasData) {
      _length = 0;
    }
    for(int i=0; i<_length; i++) {
      String _value = '';
      for(int j=0; j<_mainList.length; j++) {
        _value = _value + '${_value.isEmpty ? '' : '-'}' + _mainList[j][_indexList[j]].trim();
      }
      if(product != null) {
        double _price = 0;
        int _quantity = 0;
        for(Variation variation in product.variation) {
          if(variation.type == _value) {
            _price = variation.price;
            _quantity = variation.qty;
            break;
          }
        }
        _variantTypeList.add(VariantTypeModel(
          variantType: _value, controller: TextEditingController(text: _price > 0 ? PriceConverter.convertPriceWithoutSymbol(context,_price) : ''), node: FocusNode(),
          qtyController: TextEditingController(text: _quantity.toString()), qtyNode: FocusNode(),
        ));
      }else {
        _variantTypeList.add(VariantTypeModel(variantType: _value, controller: TextEditingController(), node: FocusNode(),qtyController: TextEditingController(),qtyNode: FocusNode()));
      }


      for(int j=0; j<_mainList.length; j++) {
        if(_indexList[_indexList.length-(1+j)] < _mainList[_mainList.length-(1+j)].length-1) {
          _indexList[_indexList.length-(1+j)] = _indexList[_indexList.length-(1+j)] + 1;
          break;
        }else {
          _indexList[_indexList.length-(1+j)] = 0;
        }
      }
    }
  }



  Future<void> updateProductQuantity( BuildContext context, int productId, int currentStock, List<Variation> variations ) async {

    Map<String, dynamic> _fields = Map();
    if(_variantTypeList.length > 0) {
      List<int> _idList = [];
      List<String> _nameList = [];
      _attributeList.forEach((attributeModel) {
        if(attributeModel.active) {
          if(attributeModel.attribute.id != 0) {
            _idList.add(attributeModel.attribute.id);
            _nameList.add(attributeModel.attribute.name);
          }
          List<String> _variantString = [];
          attributeModel.variants.forEach((variant) {
            _variantString.add(variant);
            print('=====variant name======>$variant');
          });
          _fields.addAll(<String, dynamic>{'choice_options_${attributeModel.attribute.id}': _variantString});
        }
      });
      _fields.addAll(<String, dynamic> {
        'choice_attributes': _idList, 'choice_no': _idList, 'choice': _nameList
      });

      for(int index=0; index<_variantTypeList.length; index++) {
        _fields.addAll(<String, dynamic> {'price_${_variantTypeList[index].variantType}': PriceConverter.systemCurrencyToDefaultCurrency(double.parse(_variantTypeList[index].controller.text), context)});
        _fields.addAll(<String, dynamic> {'qty_${_variantTypeList[index].variantType}': int.parse(_variantTypeList[index].qtyController.text)});
        _fields.addAll(<String, dynamic> {'sku_${_variantTypeList[index].variantType}': ""});

        _totalQuantity += int.parse(_variantTypeList[index].qtyController.text);

      }
      print('=====Total Quantity======>$_totalQuantity');
    }

    ApiResponse apiResponse = await shopRepo.updateProductQuantity(productId, currentStock, variations);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      Navigator.pop(context);
      showCustomSnackBar(getTranslated('quantity_updated_successfully', context), context, isError: false);
      Provider.of<ProductProvider>(context, listen: false).getStockOutProductList(1, context, 'en');
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }



  bool hasAttribute() {
    bool _hasData = false;
    for(AttributeModel attribute in _attributeList) {
      if(attribute.active) {
        _hasData = true;
        break;
      }
    }
    return _hasData;
  }

  void setValueForUnit (String setValue){
    print('------$setValue====$_unitValue');
    _unitValue = setValue;

  }

  void setProductTypeIndex(int index, bool notify) {
    _productTypeIndex = index;
    if(notify) {
      notifyListeners();
    }
  }


  void setDigitalProductTypeIndex(int index, bool notify) {
    _digitalProductTypeIndex = index;
    if(notify) {
      notifyListeners();
    }
  }

  void setSelectedFileName(File fileName){
    _selectedFileForImport = fileName;
    print('Here is your file ===>$_selectedFileForImport');
    notifyListeners();
  }


  Future<ApiResponse> uploadDigitalProduct(String token) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse response = await shopRepo.uploadDigitalProduct(_selectedFileForImport, token);

    if(response.response.statusCode == 200) {
      print('digital product uploaded');
      _isLoading = false;

      Map map = jsonDecode(response.response.data);
      _digitalProductFileName = map["digital_file_ready_name"];
      print('--------->$_digitalProductFileName');

    }else {
      _isLoading = false;
    }
    _isLoading = false;
    notifyListeners();
    return response;

  }

  Future<ApiResponse> uploadReadyAfterSellDigitalProduct(BuildContext context, File digitalProductAfterSellFile, String token, String orderId) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse  response = await shopRepo.uploadAfterSellDigitalProduct(digitalProductAfterSellFile, token, orderId);
    if(response.response.statusCode == 200) {
      _isLoading = false;
      showCustomSnackBar(getTranslated("digital_product_uploaded_successfully", context), context, isError: false);

    }else {
      _isLoading = false;
    }
    _isLoading = false;
    notifyListeners();
    return response;

  }

  int _totalVariantQuantity = 0;
  int get totalVariantQuantity => _totalVariantQuantity;

  void setTotalVariantTotalQuantity(int total){
    _totalVariantQuantity = total;
  }

}
