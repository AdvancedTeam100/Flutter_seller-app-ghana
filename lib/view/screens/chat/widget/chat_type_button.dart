import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/provider/chat_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';


class ChatTypeButton extends StatelessWidget {
  final String text;
  final int index;
  const ChatTypeButton({Key key, @required this.text, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Provider.of<ChatProvider>(context, listen: false).setUserTypeIndex(context, index);
      },
      child: Consumer<ChatProvider>(builder: (context, chat,_) {
        return Column(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(text, style:
            robotoRegular.copyWith(color: chat.userTypeIndex == index ?
            ColorResources.getPrimary(context) : ColorResources.getTextColor(context))),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5)
              ),
                width: chat.userTypeIndex == index ? 80 : 0,
                height: chat.userTypeIndex == index ? 2 : 2,
                )
          ],
        );
      },
      ),
    );
  }
}