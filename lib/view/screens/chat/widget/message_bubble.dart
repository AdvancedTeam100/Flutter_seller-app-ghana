import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/message_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/provider/chat_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  MessageBubble({@required this.message});

  @override
  Widget build(BuildContext context) {
    bool isMe = message.sentBySeller == 1;

    String baseUrl = Provider.of<ChatProvider>(context, listen: false).userTypeIndex == 0 ?
    Provider.of<SplashProvider>(context, listen: false).baseUrls.customerImageUrl:
    Provider.of<SplashProvider>(context, listen: false).baseUrls.sellerImageUrl;
    String image = Provider.of<ChatProvider>(context, listen: false).userTypeIndex == 0 ?
    message.customer != null? message.customer?.image :'' : message.deliveryMan.image;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
      child: Row(crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          isMe ? SizedBox.shrink() :
          Padding(
            padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_LARGE),
            child: InkWell(child: ClipOval(child: Container(
              color: Theme.of(context).highlightColor,
              child: CachedNetworkImage(
                errorWidget: (ctx, url, err) => Image.asset(Images.placeholder_image, height: Dimensions.chat_image,
                  width: Dimensions.chat_image,fit: BoxFit.cover,),
                placeholder: (ctx, url) => Image.asset(Images.placeholder_image),
                imageUrl: '$baseUrl/$image',
                height: Dimensions.chat_image,
                width: Dimensions.chat_image,
                fit: BoxFit.cover,
              ),
            ))),
          ),
          Flexible(
            child: Column(crossAxisAlignment: isMe ?CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
                Container(
                    margin: isMe ?  EdgeInsets.fromLTRB(70, 5, 10, 5) : EdgeInsets.fromLTRB(10, 10, 10, 10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: isMe? Radius.circular(10) : Radius.circular(10),
                        bottomLeft: isMe ? Radius.circular(10) : Radius.circular(0),
                        bottomRight: isMe ? Radius.circular(0) : Radius.circular(10),
                        topRight: isMe? Radius.circular(10): Radius.circular(10),
                      ),
                      color: isMe ? Theme.of(context).hintColor.withOpacity(.125) : ColorResources.getPrimary(context).withOpacity(.10),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      message.message.isNotEmpty ? Text(message.message,
                          style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
                               color: isMe ?
                               ColorResources.getTextColor(context): ColorResources.getTextColor(context))) : SizedBox.shrink(),
                    ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Text(DateConverter.customTime(DateTime.parse(message.createdAt)),
                      style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                        color: ColorResources.getHint(context),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
