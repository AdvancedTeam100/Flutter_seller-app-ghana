import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/refund_model.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'image_diaglog.dart';

class RefundAttachmentList extends StatelessWidget {
  final RefundModel refundModel;
  const RefundAttachmentList({Key key, this.refundModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_EYE),
      child: Container(height: 90,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: refundModel.images.length,
          itemBuilder: (BuildContext context, index){
            return refundModel.images.length > 0?
            Padding(padding: const EdgeInsets.all(8.0), child: Stack(children: [
              InkWell(onTap: () => showDialog(context: context, builder: (ctx)  =>
                  ImageDialog(imageUrl:'${AppConstants.BASE_URL}/storage/app/public/refund/'
                      '${refundModel.images[index]}'), ),

                child: Container(width: Dimensions.image_size, height: Dimensions.image_size,
                  child: ClipRRect(borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                    child: CustomImage(image: '${AppConstants.BASE_URL}/storage/app/public/refund/'
                        '${refundModel.images[index]}',fit: BoxFit.cover,width: Dimensions.image_size,height: Dimensions.image_size),
                  ) , decoration: BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_SMALL)),),),
              ),
            ],
            ),
            ):SizedBox();

          },),
      ),
    );
  }
}
