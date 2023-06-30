import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/refund_details_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/refund_model.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/refund_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/refund/widget/approve_reject_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/refund/widget/customer_info_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/refund/widget/delivery_man_info_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/refund/widget/refund_pricing_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/refund/widget/refund_widget.dart';



class RefundDetailScreen extends StatefulWidget {
  final RefundModel refundModel;
  final int orderDetailsId;
  final String variation;
  RefundDetailScreen({@required this.refundModel, @required this.orderDetailsId, this.variation});
  @override
  _RefundDetailScreenState createState() => _RefundDetailScreenState();
}

class _RefundDetailScreenState extends State<RefundDetailScreen> {
  @override
  void initState() {
    Provider.of<RefundProvider>(context, listen: false).getRefundReqInfo(context, widget.orderDetailsId);
    super.initState();
  }
  bool adminAction = false;
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        SingleChildScrollView(
          child: Consumer<RefundProvider>(
              builder: (context,refundReq,_) {

                if(refundReq.refundDetailsModel != null){
                  List<RefundStatus> _status =[];
                  _status = refundReq.refundDetailsModel?.refundRequest[0]?.refundStatus;

                  for(RefundStatus action in _status){
                    print('=====>${action.changeBy}');
                    if(action.changeBy == 'admin'){
                      adminAction = true;
                    }
                  }

                }


                return Container(
                  child: Column(mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                          child: RefundWidget(refundModel: widget.refundModel,isDetails: true,),
                        ),




                        RefundPricingWidget(),

                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                        widget.refundModel.customer != null?
                        CustomerInfoWidget(refundModel: widget.refundModel):SizedBox(),

                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                        (refundReq.refundDetailsModel !=null && refundReq.refundDetailsModel.deliverymanDetails != null)?
                        DeliveryManInfoWidget(refundReq: refundReq):SizedBox(),

                        SizedBox(height: Dimensions.PADDING_SIZE_BOTTOM_SPACE),


                      ]),
                );
              }
          ),
        ),
        !adminAction?
        Positioned(bottom: 0,left: 0,right: 0,
            child: ApprovedAndRejectWidget(refundModel: widget.refundModel)): SizedBox()

      ],

    );
  }
}


class ProductCalculationItem extends StatelessWidget {
  final String title;
  final double price;
  final bool isQ;
  final bool isNegative;
  final bool isPositive;
  const ProductCalculationItem({Key key, this.title, this.price, this.isQ = false, this.isNegative = false, this.isPositive = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      isQ?
      Text('${getTranslated(title, context)} (x 1)',
          style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
              color: ColorResources.titleColor(context))):
      Text('${getTranslated(title, context)}',
          style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
              color: ColorResources.titleColor(context))),
      Spacer(),
      isNegative?
      Text('- ${PriceConverter.convertPrice(context, price)}',
          style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
              color: ColorResources.titleColor(context))):
      isPositive?
      Text('+ ${PriceConverter.convertPrice(context, price)}',
          style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
              color: ColorResources.titleColor(context))):
      Text('${PriceConverter.convertPrice(context, price)}',
          style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
              color: ColorResources.titleColor(context))),
    ],);
  }
}
