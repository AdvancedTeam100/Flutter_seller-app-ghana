import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/provider/shop_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/confirmation_dialog.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/screens/addProduct/add_product_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/product/product_details.dart';
import 'package:sixvalley_vendor_app/view/screens/shop/widget/bar_code_generator.dart';
import 'package:sixvalley_vendor_app/view/screens/stockOut/widget/quantity_change_dialog.dart';



class StockOutProductWidget extends StatefulWidget {
  final Product productModel;
   StockOutProductWidget({@required this.productModel});

  @override
  State<StockOutProductWidget> createState() => _StockOutProductWidgetState();
}

class _StockOutProductWidgetState extends State<StockOutProductWidget> {
  TextEditingController _stockQuantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    int variationLength = 0;
    variationLength = widget.productModel.variation.length;
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_EXTRA_SMALL,
          0, Dimensions.PADDING_SIZE_EXTRA_SMALL,Dimensions.PADDING_SIZE_SMALL,),
      child: Slidable(
        key: const ValueKey(0),

        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dragDismissible: false,
          dismissible: DismissiblePane(onDismissed: () {
            ConfirmationDialog(icon: Images.delete_product,
                refund: false,
                description: getTranslated('are_you_sure_want_to_delete_this_product', context),
                onYesPressed: () {
                  Provider.of<SellerProvider>(context, listen:false).deleteProduct(context ,widget.productModel.id).then((value) {
                    Provider.of<ProductProvider>(context,listen: false).getStockOutProductList(1, context, 'en');
                    Provider.of<ProductProvider>(context, listen: false).initSellerProductList(Provider.of<ProfileProvider>(context, listen: false).
                    userInfoModel.id.toString(), 1, context, 'en','', reload: true);
                  });
                }

            );
          }),
          children:  [
            SlidableAction(
              onPressed: (value){
                showDialog(context: context, builder: (BuildContext context){
                  return ConfirmationDialog(icon: Images.delete_product,
                      refund: false,
                      description: getTranslated('are_you_sure_want_to_delete_this_product', context),
                      onYesPressed: () {
                        Provider.of<SellerProvider>(context, listen:false).deleteProduct(context ,widget.productModel.id).then((value) {
                          Provider.of<ProductProvider>(context,listen: false).getStockOutProductList(1, context, 'en');
                          Provider.of<ProductProvider>(context, listen: false).initSellerProductList(Provider.of<ProfileProvider>(context, listen: false).
                          userInfoModel.id.toString(), 1, context, 'en','', reload: true);
                        });
                      }

                  );});
              },
              backgroundColor: Theme.of(context).errorColor.withOpacity(.05),
              foregroundColor: Theme.of(context).errorColor,
              icon: Icons.delete_forever_rounded,
              label: getTranslated('delete', context),
            ),
            SlidableAction(
              onPressed: (value){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddProductScreen(product: widget.productModel)));
              },
              backgroundColor: Theme.of(context).primaryColor.withOpacity(.05),
              foregroundColor: Theme.of(context).primaryColor,
              icon: Icons.edit,
              label: getTranslated('edit', context),
            ),
          ],
        ),

        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (value){
                showDialog(context: context, builder: (BuildContext context){
                  return ConfirmationDialog(icon: Images.delete_product,
                      refund: false,
                      description: getTranslated('are_you_sure_want_to_delete_this_product', context),
                      onYesPressed: () {
                        Provider.of<SellerProvider>(context, listen:false).deleteProduct(context ,widget.productModel.id).then((value) {
                          Provider.of<ProductProvider>(context,listen: false).getStockOutProductList(1, context, 'en');
                          Provider.of<ProductProvider>(context, listen: false).initSellerProductList(Provider.of<ProfileProvider>(context, listen: false).
                          userInfoModel.id.toString(), 1, context, 'en','', reload: true);
                        });
                      }

                  );});
              },
              backgroundColor: Theme.of(context).errorColor.withOpacity(.05),
              foregroundColor: Theme.of(context).errorColor,
              icon: Icons.delete_forever_rounded,
              label: getTranslated('delete', context),
            ),
            SlidableAction(
              onPressed: (value){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddProductScreen(product: widget.productModel)));
              },
              backgroundColor: Theme.of(context).primaryColor.withOpacity(.05),
              foregroundColor: Theme.of(context).primaryColor,
              icon: Icons.edit,
              label: getTranslated('edit', context),
            ),
          ],
        ),

        child: Container(
          padding: EdgeInsets.only(left : Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
            color: Theme.of(context).cardColor,
            boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200],
                spreadRadius: 0.5, blurRadius: 0.3)],
          ),
          child: Stack(
            children: [
              GestureDetector(
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetailsScreen(productModel: widget.productModel))),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            right: Provider.of<LocalizationProvider>(context, listen: false).isLtr? 0: Dimensions.FONT_SIZE_SMALL
                        ),
                        child: Container(

                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(.10),
                            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),),
                          width: Dimensions.stock_out_image_size,
                          height: Dimensions.stock_out_image_size,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).
                              baseUrls.productThumbnailUrl}/${widget.productModel.thumbnail}')

                          ),
                        ),
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),


                      Flexible(child: Padding(padding: const EdgeInsets.all(8.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(widget.productModel.name ?? '', style: robotoRegular.copyWith(color: ColorResources.titleColor(context)),
                              maxLines: 2, overflow: TextOverflow.ellipsis),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                          Row(
                            children: [

                              Container(
                                padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                    Dimensions.PADDING_SIZE_VERY_TINY, Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                    Dimensions.PADDING_SIZE_VERY_TINY),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  color :widget.productModel.currentStock == 0?
                                  Theme.of(context).errorColor:
                                  Theme.of(context).colorScheme.onSecondary,
                                ),


                                child:widget.productModel.currentStock == 0?
                                Text('${widget.productModel.currentStock.toString()} ${getTranslated('stock_out', context)}'
                                    , style: robotoRegular.copyWith(color: Colors.white),
                                    maxLines: 1, overflow: TextOverflow.ellipsis):
                                Text('${widget.productModel.currentStock.toString()} ${getTranslated('in_stock', context)}'
                                    , style: robotoRegular.copyWith(color: Colors.white),
                                    maxLines: 1, overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                          variationLength != 0?
                          Text('$variationLength ${getTranslated('variation', context)}'):SizedBox(),

                        ],),
                      ),
                      ),
                    ],),
                ),
              ),


              Positioned(bottom: 15, right: Provider.of<LocalizationProvider>(context, listen: false).isLtr? 70 : null,
                left: Provider.of<LocalizationProvider>(context, listen: false).isLtr? null : 70,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Center(child:  InkWell(onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => BarCodeGenerateScreen(product: widget.productModel)));
                    Provider.of<ProductProvider>(context, listen: false).setBarCodeQuantity(4);
                  },
                    child: Image.asset(Images.barcode_icon, width: 30,),),
                  ),
                ),) ,

              Consumer<ProductProvider>(
                  builder: (context, productProvider, _) {
                    return Positioned(bottom: 13, right: Provider.of<LocalizationProvider>(context, listen: false).isLtr? 15 : null,
                      left: Provider.of<LocalizationProvider>(context, listen: false).isLtr? null : 5,
                      child: Container(height: 35, width: 35,
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.75),
                        borderRadius: BorderRadius.circular(20),),
                      child: Center(child:  InkWell(
                          onTap: (){
                            showDialog(

                              context: context,
                              builder: (BuildContext context) {

                                return QuantityUpdateDialog(
                                    stockQuantityController: _stockQuantityController,
                                    product: widget.productModel,
                                    title: getTranslated('product_variations', context),
                                    onYesPressed: () {
                                      if(_stockQuantityController.text.toString().isEmpty){
                                        showCustomSnackBar('product_quantity_is_required', context);
                                        print(widget.productModel.id);
                                      }else{
                                        productProvider.updateProductQuantity(context, widget.productModel.id, int.parse(_stockQuantityController.text.toString()),[]);

                                      }

                                    }

                                );
                              },
                            );
                          },
                          child: Center(child: Icon(Icons.add, color: Colors.white))),
                      ),
                    ),);
                  }
              ),


            ],
          ),
        ),
      ),
    );

  }
}
