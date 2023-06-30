import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/body/MessageBody.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/data/model/response/chat_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/message_model.dart';
import 'package:sixvalley_vendor_app/data/repository/chat_repo.dart';
import 'package:sixvalley_vendor_app/helper/api_checker.dart';


class ChatProvider extends ChangeNotifier {
  final ChatRepo chatRepo;
  ChatProvider({@required this.chatRepo});


  List<Chat> _chatList;
  List<Chat> get chatList => _chatList;
  List<Message> _messageList;
  List<Message> get messageList => _messageList;
  bool _isSendButtonActive = false;
  bool get isSendButtonActive => _isSendButtonActive;
  int _userTypeIndex = 0;
  int get userTypeIndex =>  _userTypeIndex;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  ChatModel _chatModel;
  ChatModel get chatModel => _chatModel;


  Future<void> getChatList(BuildContext context, int offset, {bool reload = false}) async {
    if(reload){
      _chatModel = null;
    }
    _isLoading = true;
    ApiResponse apiResponse = await chatRepo.getChatList(_userTypeIndex == 0 ? 'customer' : 'delivery-man', offset);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      if(offset == 1) {
        _chatModel = ChatModel.fromJson(apiResponse.response.data);
      }else {
        _chatModel.totalSize = ChatModel.fromJson(apiResponse.response.data).totalSize;
        _chatModel.offset = ChatModel.fromJson(apiResponse.response.data).offset;
        _chatModel.chat.addAll(ChatModel.fromJson(apiResponse.response.data).chat);
      }
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchedChatList(BuildContext context, String search) async {
    ApiResponse apiResponse = await chatRepo.searchChat(_userTypeIndex == 0 ? 'customer' : 'delivery-man', search);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _chatModel = ChatModel(totalSize: 10, limit: '10', offset: '1', chat: []);
      apiResponse.response.data.forEach((chat) {_chatModel.chat.add(Chat.fromJson(chat));});
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


  Future<void> getMessageList(BuildContext context,  int id, int offset) async {
    _messageList = [];
    ApiResponse apiResponse = await chatRepo.getMessageList(_userTypeIndex == 0? 'customer' : 'delivery-man', offset, id);

    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {

      _messageList.addAll(MessageModel.fromJson(apiResponse.response.data).message);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


  void sendMessage(MessageBody messageBody,  BuildContext context) async {
    print('==message====>${messageBody.message}/ ${messageBody.userId}');
    ApiResponse apiResponse = await chatRepo.sendMessage(_userTypeIndex == 0? 'customer' : 'delivery-man', messageBody);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {

     getMessageList(context,  messageBody.userId, 1);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isSendButtonActive = false;
    notifyListeners();
  }

  void toggleSendButtonActivity() {
    _isSendButtonActive = !_isSendButtonActive;
    notifyListeners();
  }

  void setUserTypeIndex(BuildContext context, int index) {
    _userTypeIndex = index;
    getChatList(context, 1);
    notifyListeners();
  }

}
