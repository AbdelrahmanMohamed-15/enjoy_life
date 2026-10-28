import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';

/// The vendor services the reservations API filters by
/// (`service` query param: 1 restaurant, 2 hotel, 3 trip).
class ReversionServiceType {
  ReversionServiceType._();

  static const List<int> all = [1, 2, 3];

  /// Matches the item types used by `BookingTypeIcon`
  static String itemType(int serviceID) => switch (serviceID) {
    2 => 'hotel',
    3 => 'trip',
    _ => 'restaurant',
  };

  static String title(int serviceID) => switch (serviceID) {
    2 => LocaleKeys.reversionFilterHotel.tr(),
    3 => LocaleKeys.reversionFilterTrip.tr(),
    _ => LocaleKeys.reversionFilterRestaurant.tr(),
  };

  static String description(int serviceID) => switch (serviceID) {
    2 => LocaleKeys.reversionHotelDesc.tr(),
    3 => LocaleKeys.reversionTripDesc.tr(),
    _ => LocaleKeys.reversionRestaurantDesc.tr(),
  };
}
