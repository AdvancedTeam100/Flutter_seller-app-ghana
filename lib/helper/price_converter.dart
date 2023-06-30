import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';

class PriceConverter {
  static String convertPrice(BuildContext context, double price, {double discount, String discountType}) {
    final _splashProvider = Provider.of<SplashProvider>(context, listen: false);
    if(discount != null && discountType != null){
      if(discountType == 'amount' || discountType == 'flat') {
        price = price - discount;
      }else if(discountType == 'percent' || discountType == 'percentage') {
        price = price - ((discount / 100) * price);
      }
    }

    bool _singleCurrency = _splashProvider.configModel.currencyModel == 'single_currency';

    return '${_splashProvider.myCurrency.symbol}${(_singleCurrency? price : price
        * _splashProvider.myCurrency.exchangeRate
        * (1/ _splashProvider.usdCurrency.exchangeRate)).toStringAsFixed(_splashProvider.configModel.decimalPointSettings)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }


  static double convertWithDiscount(BuildContext context, double price, double discount, String discountType) {
    if(discountType == 'amount' || discountType == 'flat') {
      price = price - discount;
    }else if(discountType == 'percent' || discountType == 'percentage') {
      price = price - ((discount / 100) * price);
    }
    return price;
  }


  static String convertPriceWithoutSymbol(BuildContext context, double price, {double discount, String discountType}) {
    if(discount != null && discountType != null){
      if(discountType == 'amount' || discountType == 'flat') {
        price = price - discount;
      }else if(discountType == 'percent' || discountType == 'percentage') {
        price = price - ((discount / 100) * price);
      }
    }
    final _splashProvider = Provider.of<SplashProvider>(context, listen: false);
    bool _singleCurrency = _splashProvider.configModel.currencyModel == 'single_currency';

    return '${(_singleCurrency? price : price
        * _splashProvider.myCurrency.exchangeRate
        * (1 / _splashProvider.usdCurrency.exchangeRate)).toStringAsFixed(_splashProvider.configModel.decimalPointSettings)
        }';
  }


  static double systemCurrencyToDefaultCurrency(double price, BuildContext context) {
    final _splashProvider = Provider.of<SplashProvider>(context, listen: false);
    bool _singleCurrency = _splashProvider.configModel.currencyModel == 'single_currency';
    if(_singleCurrency) {
      return price / 1;
    }else {
      return price / _splashProvider.myCurrency.exchangeRate;
    }
  }

  static double convertAmount(double amount, BuildContext context) {
    final _splashProvider = Provider.of<SplashProvider>(context, listen: false);
    return double.parse('${(amount * _splashProvider.myCurrency.exchangeRate *
        (1/_splashProvider.usdCurrency.exchangeRate)).toStringAsFixed(_splashProvider.configModel.decimalPointSettings)}');
  }
  static String percentageCalculation(BuildContext context, double price, double discount, String discountType) {
    return '${(discountType == 'percent' || discountType == 'percentage') ? '$discount %'
        : convertPrice(context, discount)} OFF';
  }
  static String discountCalculationWithOutSymbol(BuildContext context,double price, double discount, String discountType) {
    if(discountType == 'amount') {
      discount =  discount;
    }else if(discountType == 'percent') {
      discount =  ((discount / 100) * price);
    }
    return '${discount.toStringAsFixed(2)}';
  }

  static String discountCalculation(BuildContext context,double price, double discount, String discountType) {
    final _splashProvider = Provider.of<SplashProvider>(context, listen: false);
    if(discountType == 'amount') {
      discount =  discount;
    }else if(discountType == 'percent') {
      discount =  ((discount / 100) * price);
    }
    return '${_splashProvider.myCurrency.symbol} ${discount.toStringAsFixed(2)}';
  }
}