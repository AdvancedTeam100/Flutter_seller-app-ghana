import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/chat_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/provider/chat_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/chat/chat_screen.dart';

class ChatCardWidget extends StatelessWidget {
  final Chat chat;
  const ChatCardWidget({Key key, this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String baseUrl = Provider.of<ChatProvider>(context, listen: false).userTypeIndex == 0 ?
    Provider.of<SplashProvider>(context, listen: false).baseUrls.customerImageUrl:
    Provider.of<SplashProvider>(context, listen: false).baseUrls.deliveryManImageUrl;

    int id = Provider.of<ChatProvider>(context, listen: false).userTypeIndex == 0 ?
    chat.customer.id : chat.deliveryManId;

    String image = Provider.of<ChatProvider>(context, listen: false).userTypeIndex == 0 ?
    chat.customer != null? chat.customer?.image :'' : chat.deliveryMan?.image;

    String name = Provider.of<ChatProvider>(context, listen: false).userTypeIndex == 0 ?
    chat.customer != null?
    '${chat.customer?.fName}'+' '+ '${chat.customer?.lName}' :'' :
    '${chat.deliveryMan?.fName??'Deliveryman'} ${chat.deliveryMan?.lName??'Deleted'}';


    return Padding(
      padding:  EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ChatScreen(userId: id, name: name);
        })),
        child: Container(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),

          child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [

            Container(
              child: ClipOval(
                child: CachedNetworkImage(
                  errorWidget: (ctx, url ,err )=>Image.asset(Images.placeholder_image,
                    height: Dimensions.chat_image, width: Dimensions.chat_image, fit: BoxFit.cover,),
                  placeholder: (ctx, url )=>Image.asset(Images.placeholder_image),
                  imageUrl: '$baseUrl/$image',
                  fit: BoxFit.cover, height: Dimensions.chat_image, width: Dimensions.chat_image,
                ),
              ),
            ),
            SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),

            Expanded(
              child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name, style: titilliumSemiBold.copyWith(color: ColorResources.titleColor(context))),
                    Text(DateConverter.customTime(DateTime.parse(chat.createdAt)),
                        style: robotoRegular.copyWith()),
                  ],
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),


                Text(chat.message,
                  maxLines: 2,overflow: TextOverflow.ellipsis,
                  style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
                      color: ColorResources.getTextColor(context).withOpacity(.8)),
                ),






              ],),
            )

          ],),),
      ),
    );
  }
}
