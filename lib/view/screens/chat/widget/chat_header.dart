import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/chat_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/custom_search_field.dart';
import 'package:sixvalley_vendor_app/view/screens/chat/widget/chat_type_button.dart';


class ChatHeader extends StatefulWidget {
  const ChatHeader({Key key}) : super(key: key);

  @override
  State<ChatHeader> createState() => _ChatHeaderState();
}

class _ChatHeaderState extends State<ChatHeader> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
        builder: (context, chat, _) {
          return Padding(
            padding: const EdgeInsets.fromLTRB( Dimensions.PADDING_SIZE_DEFAULT,  Dimensions.PADDING_SIZE_DEFAULT,  Dimensions.PADDING_SIZE_DEFAULT,  Dimensions.PADDING_SIZE_SMALL),
            child: SizedBox(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50,
                    child: CustomSearchField(
                      controller: _textEditingController,
                      hint: getTranslated('search', context),
                      prefix: Images.icons_search,
                      iconPressed: () => (){},
                      onSubmit: (text) => (){},
                      onChanged: (value){
                        if(value.toString().isNotEmpty){
                          chat.searchedChatList(context, value);
                        }
                      },

                    ),
                  ),
                  SizedBox(height: 40,
                    child: Row(
                      children: [
                        ChatTypeButton(text: getTranslated('customer', context), index: 0),
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                        ChatTypeButton(text: getTranslated('delivery-man', context), index: 1),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        }
    );
  }
}
