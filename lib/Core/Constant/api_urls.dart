class ApiUrls {
  // Apis Urls For Authentication
  static const String login = 'api/login';
  static const String register = 'api/register';
  static const String activeEmail = 'api/emailActivation';
  static const String forgetPassword = 'api/sendPasswordResetCode';
  static const String verifyRestCode = 'api/checkResetPasswordCode';
  static const String resetPassword = 'api/resetPassword';

  // Apis Urls For Home
  static const String sliders = 'api/sliders';
  static const String getResturant = 'api/getRestaurants';
  static const String getHotels = 'api/getHotels';
  static const String getTrips = 'api/getTrips';
  static const String getVendorResturant = 'api/vendor/getRestaurants';
  static const String getVendoHotels = 'api/vendor/getHotels';
  static const String getVendoTrips = 'api/vendor/getTrips';
  static const String addFavourite = 'api/addFavourite';
  static const String removeFavourite = 'api/removeFavourite';
  static const String getAllFavourite = 'api/getMyFavourites';

  // Apis Urls For Service

  static const String getResturantByID = 'api/getRestaurantById/';
  static const String getHotelByID = 'api/getHotelById/';
  static const String getTripByID = 'api/getTripById/';
  static const String getAvaliableTables = 'api/restaurantAvailableTables';
  static const String getAvaliableRooms = 'api/hotelAvailableRooms';
  static const String getAvaliableTrips = 'api/tripAvailableSchedules';
  static const String addToCart = 'api/addToCart';

  // Apis Urls For cart
  static const String getCart = 'api/showCart';
  static const String storeClientSession = 'api/StoreClientSession';
  static const String removeCartItem = 'api/removeItemFromCart';
  static const String updateCartQuantityItem = 'api/updateItemQtyCart';
  static const String createOrder = 'api/order';

  // Apis Urls For Orders
  static const String pendingOrders = 'api/getMyPendingOrders';
  static const String cancleOrders = 'api/getMyCancelledOrders';
  static const String compelteOrders = 'api/getMyCompletedOrders';

  // Apis Urls For Trips

  // Apis Urls For Hotels

  // Apis Urls For Profile
  static const String getProfile = 'api/me';
  static const String updateProfile = 'api/update';
  static const String getAdditionalPage = 'api/additionalpages';
}
