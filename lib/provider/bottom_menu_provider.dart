
import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/view/screens/order/order_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/pos_product_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/pos_screen.dart';


class BottomMenuController extends ChangeNotifier{
  int _currentTab = 0;
  int get currentTab => _currentTab;
  final List<Widget> screen = [
    PosScreen(),
    OrderScreen(),
    POSProductScreen(),


  ];
  Widget _currentScreen = PosScreen();
  Widget get currentScreen => _currentScreen;

  resetNavBar(){
    _currentScreen = PosScreen();
    _currentTab = 0;
  }

  selectHomePage() {
    _currentScreen = PosScreen();
    _currentTab = 0;
    notifyListeners();
  }

  selectPosScreen() {
    _currentScreen = OrderScreen();
    _currentTab = 1;
    notifyListeners();
  }

  selectItemsScreen() {
    _currentScreen = POSProductScreen();
    _currentTab = 2;
    notifyListeners();
  }


}
