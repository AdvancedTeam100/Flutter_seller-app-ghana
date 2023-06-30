import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/language_model.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';

class LanguageProvider with ChangeNotifier {
  int _selectIndex = 0;

  int get selectIndex => _selectIndex;

  void setSelectIndex(int index) {
    _selectIndex = index;
    notifyListeners();
  }

  List<LanguageModel> _languages = [];

  List<LanguageModel> get languages => _languages;

  void searchLanguage(String query, BuildContext context) {
    if (query.isEmpty) {
      _languages.clear();
      _languages = AppConstants.languages;
      notifyListeners();
    } else {
      _selectIndex = -1;
      _languages = [];
      AppConstants.languages.forEach((product) async {
        if (product.languageName.toLowerCase().contains(query.toLowerCase())) {
          _languages.add(product);
        }
      });
      notifyListeners();
    }
  }

  void initializeAllLanguages(BuildContext context) {
    if (_languages.length == 0) {
      _languages.clear();
      _languages = AppConstants.languages;
    }
  }
}
