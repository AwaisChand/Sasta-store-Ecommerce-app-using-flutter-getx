class Urls {
  /// base url
  static const BASE_URL = "https://sastahaistore.com/api";

  ///  Authentication apis
  static const loginApi = '/user/login';
  static const signupApi = '/user/signup';
  static const forgotApi = '/user/forgot-password';
  static const otpVerifyApi = '/user/otp-verify';
  static const resetPasswordApi = '/user/reset-password';

  ///  Account  apis

  static const getProfileApi = '/user/profile';
  static const updateProfileApi = '/user/update-profile';

  ///  Home tab apis

  static const getCategoriesApi = '/categories/all';
  static const getSubcategoriesApi = '/subcategories/';
  static const getSliderApi = '/banner/all';
  static const getHomeProductApi = '/home/proucts';
  static const getProductDetailApi = '/product/detail/';
  static const getSubcategoryProductApi = '/products/';
  static const getProductsFilterApi = '/product/search';

  /// Chat apis

  static const getChatApi = '/chat/message/get';
  static const sendMessageApi = '/chat/message/store';

  // balance history api
  static const balanceHistoryApi = '/user/balance-history';

  ///  Favorite apis

  static const addFavoriteApi = '/user/wishlist/store';
  static const removeFavoriteApi = '/user/wishlist/delete';
  static const getFavoriteApi = '/user/wishlist/all';

  ///checkout

  static const getPaymentMethodApi = '/payment_methods/all';
  static const checkOutApi = '/user/order/store';
  static const uploadReceiptApi = '/user/order/upload-payment-receipt';

  ///  order

  static const getOrderHistoryApi = '/user/order/list';
  static const getOrderDetailApi = '/user/order/';
}
