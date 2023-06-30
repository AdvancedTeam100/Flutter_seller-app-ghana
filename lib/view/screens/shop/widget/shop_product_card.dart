import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/provider/shop_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/confirmation_dialog.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/base/image_diaglog.dart';
import 'package:sixvalley_vendor_app/view/screens/addProduct/add_product_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/product/product_details.dart';



class ShopProductWidget extends StatefulWidget {
  final Product productModel;
  final bool isDetails;
  ShopProductWidget({@required this.productModel, this.isDetails = false});

  @override
  State<ShopProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ShopProductWidget> {
  var renderOverlay = true;
  var visible = true;
  var switchLabelPosition = false;
  var extend = false;
  var mini = false;
  var customDialRoot = false;
  var closeManually = false;
  var useRAnimation = true;
  var isDialOpen = ValueNotifier<bool>(false);
  var speedDialDirection = SpeedDialDirection.left;
  var buttonSize = const Size(35.0, 35.0);
  var childrenButtonSize = const Size(45.0, 45.0);
  @override
  Widget build(BuildContext context) {
    String baseUrl = Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl;
    return Container(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
            child: GestureDetector(
              onTap:  widget.isDetails? null: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetailsScreen(productModel: widget.productModel))),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_MEDIUM, vertical: Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.05),
                      spreadRadius: 1, blurRadius: 1, offset: Offset(1,2))],
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                          child: Column(
                            children: [
                              Container(decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(.10),
                                borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),),
                                width: 100,
                                height: 100,
                                child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                                  child: CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).
                                  baseUrls.productThumbnailUrl}/${widget.productModel?.thumbnail}'))),
                              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              widget.isDetails?SizedBox():
                              Text(getTranslated(widget.productModel?.productType, context), style: robotoRegular.copyWith(color: Theme.of(context).primaryColor),),
                            ],
                          ),
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),


                        Expanded(flex: 6,
                          child: Padding(padding: const EdgeInsets.all(8.0),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Padding(
                                padding: EdgeInsets.only(right: Provider.of<LocalizationProvider>(context, listen: false).isLtr? 30:0,
                                  left: Provider.of<LocalizationProvider>(context, listen: false).isLtr? 0:30,
                                ),
                                child: Text(widget.productModel.name ?? '', style: robotoRegular.copyWith(color: ColorResources.titleColor(context)),
                                  maxLines: 2, overflow: TextOverflow.ellipsis),
                              ),
                              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                              Container(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      color: widget.productModel.requestStatus == 0? ColorResources.COLUMBIA_BLUE :
                                      widget.productModel.requestStatus == 1? ColorResources.GREEN : ColorResources.getRed(context)),
                                  child: Text(widget.productModel.requestStatus == 0? '${getTranslated('new_request', context)}':
                                  widget.productModel.requestStatus == 1? '${getTranslated('approved', context)}' : '${getTranslated('denied', context)}',
                                      style: robotoRegular.copyWith(color: Colors.white),
                                      maxLines: 1, overflow: TextOverflow.ellipsis)),
                              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                              widget.isDetails && widget.productModel.images != null?
                              Container(height: Dimensions.PRODUCT_IMAGE_SIZE,
                                child: ListView.builder(
                                  itemCount: widget.productModel.images?.length,
                                  shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index){
                                  return GestureDetector(
                                    onTap: (){
                                      showDialog(context: context, builder: (_){
                                        return ImageDialog(imageUrl: '$baseUrl/${widget.productModel.images[index]}');
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      child: Container(decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                      ),
                                      width: Dimensions.PRODUCT_IMAGE_SIZE,height: Dimensions.image_size,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                            child: CustomImage(image: '$baseUrl/${widget.productModel.images[index]}',
                                              width: Dimensions.PRODUCT_IMAGE_SIZE,height: Dimensions.PRODUCT_IMAGE_SIZE,),
                                          )),
                                    ),
                                  );
                              }),):
                              Container(child: Column(children: [
                                Row(children: [
                                  Text('${getTranslated('purchase_price', context)} : ',
                                    style: robotoRegular.copyWith(color: Theme.of(context).hintColor),),

                                  Text(PriceConverter.convertPrice(context, widget.productModel.purchasePrice),
                                    style: robotoMedium.copyWith(color: ColorResources.titleColor(context)),)]),
                                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                Row(children: [
                                  Text('${getTranslated('selling_price', context)} : ',
                                    style: robotoRegular.copyWith(color: Theme.of(context).hintColor),),
                                  Text(PriceConverter.convertPrice(context, widget.productModel.unitPrice,
                                      discountType: widget.productModel.discountType, discount: widget.productModel.discount),
                                      style: robotoMedium.copyWith(color: ColorResources.titleColor(context)))]),
                              ],),)
                          ],),
                        ),
                        ),
                      ],),

                    widget.isDetails && widget.productModel.deniedNote != null?
                    Padding(
                      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                        Text('${getTranslated('note', context)}: ',
                            style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Theme.of(context).primaryColor)),

                        Expanded(
                          child: Text( widget.productModel.deniedNote,overflow: TextOverflow.ellipsis,
                              maxLines: 50,
                              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                        ),
                      ],),
                    ):SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
          extend?
          Align(alignment: Provider.of<LocalizationProvider>(context, listen: false).isLtr? Alignment.topRight:Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(width: 150,height: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: [BoxShadow(color: Theme.of(context).hintColor,
                          spreadRadius: .1, blurRadius: .2, offset: Offset.fromDirection(2,1))],
                      borderRadius: BorderRadius.circular(Dimensions.ICON_SIZE_EXTRA_LARGE)
                  ),
                ),
              )):SizedBox(),
          !widget.isDetails?
          Align(
            alignment: Provider.of<LocalizationProvider>(context, listen: false).isLtr? Alignment.topRight:Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SpeedDial(
                overlayOpacity: 0,
                icon: Icons.more_horiz,
                activeIcon: Icons.close,
                spacing: 3,
                mini: mini,
                openCloseDial: isDialOpen,
                childPadding: const EdgeInsets.all(5),
                spaceBetweenChildren: 4,
                buttonSize: buttonSize,
                childrenButtonSize: childrenButtonSize,
                visible: visible,
                direction: speedDialDirection,
                switchLabelPosition: switchLabelPosition,
                closeManually: closeManually,
                renderOverlay: renderOverlay,
                useRotationAnimation: useRAnimation,
                backgroundColor: Theme.of(context).cardColor,
                foregroundColor: Theme.of(context).disabledColor,
                elevation: extend? 0: 8.0,
                animationCurve: Curves.elasticInOut,
                isOpenOnStart: false,
                shape: customDialRoot ? const RoundedRectangleBorder() : const StadiumBorder(),
                onOpen: () {
                  setState(() {
                    extend = true;
                  });
                },
                onClose: () {
                  setState(() {
                    extend = false;
                  });
                },

                children: [
                  SpeedDialChild(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(Images.edit_icon),
                    ),

                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddProductScreen(product: widget.productModel)));
                    },
                  ),
                  SpeedDialChild(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(Images.delete),
                    ),

                    onTap: () {
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
                  ),

                ],
              ),
            ),
          ):SizedBox()
        ],
      ),
    );
  }
}
