

import 'package:sixvalley_vendor_app/data/model/response/language_model.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';

class AppConstants {
  static const String APP_NAME = 'Seller App';
  static const String APP_VERSION = '13.1';
  static const String COMPANY_NAME = '6Valley';
  static const String BASE_URL = 'https://6valleyinstall.6am.one';
  static const String LOGIN_URI = '/api/v3/seller/auth/login';
  static const String CONFIG_URI = '/api/v1/config';
  static const String SELLER_URI = '/api/v3/seller/seller-info';
  static const String SELLER_AND_BANK_UPDATE = '/api/v3/seller/seller-update';
  static const String SHOP_URI = '/api/v3/seller/shop-info';
  static const String SHOP_UPDATE = '/api/v3/seller/shop-update';
  static const String CHAT_URI = '/api/v3/seller/messages/list/';
  static const String CHAT_SEARCH_URI = '/api/v3/seller/messages/search/';
  static const String MESSAGE_URI = '/api/v3/seller/messages/get-message/';
  static const String SEND_MESSAGE_URI = '/api/v3/seller/messages/send/';
  static const String ORDER_LIST_URI = '/api/v3/seller/orders/list';
  static const String ORDER_DETAILS = '/api/v3/seller/orders/';
  static const String UPDATE_ORDER_STATUS = '/api/v3/seller/orders/order-detail-status/';
  static const String BALANCE_WITHDRAW = '/api/v3/seller/balance-withdraw';
  static const String CANCEL_BALANCE_REQUEST = '/api/v3/seller/close-withdraw-request';
  static const String TRANSACTIONS_URI = '/api/v3/seller/transactions?status=';
  static const String SELLER_PRODUCT_URI = '/api/v1/seller/';
  static const String STOCK_OUT_PRODUCT_URI = '/api/v3/seller/products/stock-out-list?limit=10&offset=';
  static const String PRODUCT_REVIEW_URI = '/api/v3/seller/shop-product-reviews';
  static const String PRODUCT_REVIEW_STATUS_ON_OFF = '/api/v3/seller/shop-product-reviews-status';
  static const String ATTRIBUTE_URI = '/api/v1/attributes';
  static const String BRAND_URI = '/api/v3/seller/brands';
  static const String CATEGORY_URI = '/api/v1/categories/';
  static const String SUB_CATEGORY_URI = '/api/v1/categories/childes/';
  static const String SUB_SUB_CATEGORY_URI = '/api/v1/categories/childes/childes/';
  static const String ADD_PRODUCT_URI = '/api/v3/seller/products/add';
  static const String UPLOAD_PRODUCT_IMAGE_URI = '/api/v3/seller/products/upload-images';
  static const String UPDATE_PRODUCT_URI = '/api/v3/seller/products/update';
  static const String DELETE_PRODUCT_URI = '/api/v3/seller/products/delete';
  static const String EDIT_PRODUCT_URI = '/api/v3/seller/products/edit';
  static const String ADD_SHIPPING_URI = '/api/v3/seller/shipping-method/add';
  static const String UPDATE_SHIPPING_URI = '/api/v3/seller/shipping-method/update';
  static const String EDIT_SHIPPING_URI = '/api/v3/seller/shipping-method/edit';
  static const String DELETE_SHIPPING_URI = '/api/v3/seller/shipping-method/delete';
  static const String GET_SHIPPING_URI = '/api/v3/seller/shipping-method/list';
  static const String GET_DELIVERY_MAN_URI = '/api/v3/seller/seller-delivery-man';
  static const String ASSIGN_DELIVERY_MAN_URI = '/api/v3/seller/orders/assign-delivery-man';
  static const String TOKEN_URI = '/api/v3/seller/cm-firebase-token';
  static const String REFUND_LIST_URI = '/api/v3/seller/refund/list';
  static const String REFUND_ITEM_DETAILS = '/api/v3/seller/refund/refund-details';
  static const String REFUND_REQ_STATUS_UPDATE = '/api/v3/seller/refund/refund-status-update';
  static const String SHOW_SHIPPING_COST_URI = '/api/v3/seller/shipping/all-category-cost';
  static const String SET_CATEGORY_WISE_SHIPPING_COST_URI = '/api/v3/seller/shipping/set-category-cost';
  static const String SET_SHIPPING_METHOD_TYPE_URI = '/api/v3/seller/shipping/selected-shipping-method';
  static const String GET_SHIPPING_METHOD_TYPE_URI = '/api/v3/seller/shipping/get-shipping-method';
  static const String THIRD_PARTY_DELIVERY_MAN_ASSIGN = '/api/v3/seller/orders/assign-third-party-delivery';
  static const String FORGET_PASSWORD_URI = '/api/v3/seller/auth/forgot-password';
  static const String VERIFY_OTP_URI = '/api/v3/seller/auth/verify-otp';
  static const String RESET_PASSWORD_URI = '/api/v3/seller/auth/reset-password';
  static const String PAYMENT_STATUS_UPDATE = '/api/v3/seller/orders/update-payment-status';
  static const String BAR_CODE_GENERATE = '/api/v3/seller/products/barcode/generate';
  static const String DIGITAL_PRODUCT_UPLOAD = '/api/v3/seller/products/upload-digital-product';
  static const String DIGITAL_PRODUCT_UPLOAD_AFTER_SELL = '/api/v3/seller/orders/order-wise-product-upload';
  static const String REGISTRATION = '/api/v3/seller/registration';
  static const String DELETE_ACCOUNT = '/api/v3/seller/account-delete';
  static const String DELIVERY_CHARGE_FOR_DELIVERY = '/api/v3/seller/orders/delivery-charge-date-update';

  static const String GET_COUPON_DISCOUNT = '/api/v3/seller/coupon/check-coupon';
  static const String PLACE_ORDER_URI = '/api/v3/seller/pos/place-order';
  static const String GET_PRODUCT_FROM_PRODUCT_CODE = '/api/v3/seller/pos/products';
  static const String CUSTOMER_SEARCH_URI = '/api/v3/seller/pos/customers';
  static const String GET_CUSTOMER_LIST_URI = '/api/v3/seller/pos/customers?';
  static const String INVOICE = '/api/v3/seller/pos/get-invoice';
  static const String TOP_SELLING_PRODUCT = '/api/v3/seller/products/top-selling-product?limit=10&offset=';
  static const String MOST_POPULAR_PRODUCT = '/api/v3/seller/products/most-popular-product?limit=10&offset=';
  static const String TOP_DELIVERY_MAN = '/api/v3/seller/top-delivery-man';
  static const String DELIVERY_MAN_LIST_URI = '/api/v3/seller/delivery-man/list';
  static const String DELIVERY_MAN_DETAILS = '/api/v3/seller/delivery-man/details/';
  static const String POS_PRODUCT_LIST = '/api/v3/seller/pos/product-list';
  static const String SEARCH_POS_PRODUCT_LIST = '/api/v3/seller/pos/product-list';
  static const String SHIPPING_METHOD_ON_OFF = '/api/v3/seller/shipping-method/status';
  static const String UPDATE_PRODUCT_QUANTITY = '/api/v3/seller/products/quantity-update';
  static const String PRODUCT_WISE_REVIEW_LIST = '/api/v3/seller/products/review-list/';
  static const String ADD_DELIVERY_MAN = '/api/v3/seller/delivery-man/store';
  static const String UPDATE_DELIVERY_MAN = '/api/v3/seller/delivery-man/update';
  static const String DELETE_DELIVERY_MAN = '/api/v3/seller/delivery-man/delete/';
  static const String DELIVERY_MAN_ORDER_HISTORY = '/api/v3/seller/delivery-man/order-list/';
  static const String DELIVERY_MAN_EARNING = '/api/v3/seller/delivery-man/earning/';
  static const String COLLECT_CASH_FROM_DELIVERY_MAN = '/api/v3/seller/delivery-man/cash-receive';
  static const String EMERGENCY_CONTACT_ADD = '/api/v3/seller/delivery-man/emergency-contact/store';
  static const String EMERGENCY_CONTACT_UPDATE = '/api/v3/seller/delivery-man/emergency-contact/update';
  static const String GET_EMERGENCY_CONTACT_LIST = '/api/v3/seller/delivery-man/emergency-contact/list';
  static const String EMERGENCY_CONTACT_STATUS_ON_OFF = '/api/v3/seller/delivery-man/emergency-contact/status-update';
  static const String EMERGENCY_CONTACT_DELETE = '/api/v3/seller/delivery-man/emergency-contact/delete';
  static const String DELIVERY_MAN_WITHDRAW_LIST = '/api/v3/seller/delivery-man/withdraw/list';
  static const String DELIVERY_MAN_REVIEW_LIST = '/api/v3/seller/delivery-man/reviews/';
  static const String DELIVERY_MAN_WITHDRAW_DETAILS = '/api/v3/seller/delivery-man/withdraw/details/';
  static const String DELIVERY_MAN_WITHDRAW_APPROVED_REJECTED = '/api/v3/seller/delivery-man/withdraw/status-update';
  static const String ADD_NEW_CUSTOMER = '/api/v3/seller/pos/customer-store';
  static const String PRODUCT_STATUS_ON_OFF = '/api/v3/seller/products/status-update';
  static const String DELIVERYMAN_STATUS_ON_OFF = '/api/v3/seller/delivery-man/status-update';
  static const String EARNING_STATISTICS = '/api/v3/seller/get-earning-statitics?type=';
  static const String BUSINESS_ANALYTICS = '/api/v3/seller/order-statistics?statistics_type=';
  static const String PRODUCT_DETAILS = '/api/v3/seller/products/details/';
  static const String DELIVERY_MAN_ORDER_CHANGE_LOG = '/api/v3/seller/delivery-man/order-status-history/';
  static const String CHART_FILTER_DATA = '/api/v3/seller/get-earning-statitics?type=';
  static const String ADD_NEW_COUPON = '/api/v3/seller/coupon/store';
  static const String GET_COUPON_LIST = '/api/v3/seller/coupon/list';
  static const String UPDATE_COUPON = '/api/v3/seller/coupon/update/';
  static const String DELETE_COUPON = '/api/v3/seller/coupon/delete/';
  static const String COUPON_STATUS_UPDATE = '/api/v3/seller/coupon/status-update/';
  static const String DELIVERY_MAN_COLLECTED_CASH_LIST = '/api/v3/seller/delivery-man/collect-cash-list/';
  static const String COUPON_CUSTOMER_LIST = '/api/v3/seller/coupon/customers?name=';
  static const String TEMPORARY_CLOSE = '/api/v3/seller/temporary-close';
  static const String VACATION = '/api/v3/seller/vacation-add';
  static const String DYNAMIC_WITHDRAW_METHOD = '/api/v3/seller/withdraw-method-list';






  static const String PENDING = 'pending';
  static const String CONFIRMED = 'confirmed';
  static const String PROCESSING = 'processing';
  static const String PROCESSED = 'processed';
  static const String DELIVERED = 'delivered';
  static const String FAILED = 'failed';
  static const String RETURNED = 'returned';
  static const String CANCELLED = 'canceled';
  static const String OUT_FOR_DELIVERY = 'out_for_delivery';
  static const String APPROVED = 'approved';
  static const String REJECTED = 'rejected';
  static const String DONE = 'refunded';



  static const String ORDER_WISE = 'order_wise';
  static const String PRODUCT_WISE = 'product_wise';
  static const String CATEGORY_WISE = 'category_wise';



  static const String THEME = 'theme';
  static const String CURRENCY = 'currency';
  static const String SHIPPING_TYPE = 'shipping_type';
  static const String TOKEN = 'token';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_NUMBER = 'user_number';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String TOPIC = 'six_valley_seller';
  static const String USER_EMAIL = 'user_email';
  static const String LANG_KEY = 'lang';

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.united_kindom, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: Images.arabic, languageName: 'Arabic', countryCode: 'SA', languageCode: 'ar'),
  ];
}
