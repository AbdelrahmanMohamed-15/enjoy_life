/// Restaurant / hotel / trip, read reliably from API data.
///
/// The API's `service_name` is localized and its casing varies ("Restaurant",
/// "مطعم", ...), so string comparisons broke in one language or the other.
/// Prefer `service_id` (1 / 2 / 3) and fall back to a case-insensitive name.
enum ServiceKind {
  restaurant,
  hotel,
  trip;

  static ServiceKind? of({int? id, String? name}) {
    switch (id) {
      case 1:
        return ServiceKind.restaurant;
      case 2:
        return ServiceKind.hotel;
      case 3:
        return ServiceKind.trip;
    }
    final value = name?.trim().toLowerCase() ?? '';
    if (value.isEmpty) return null;
    if (value.startsWith('rest') ||
        value.startsWith('resturant') ||
        value == 'مطعم') {
      return ServiceKind.restaurant;
    }
    if (value.startsWith('hotel') || value == 'فندق') return ServiceKind.hotel;
    if (value.startsWith('trip') || value == 'رحلة') return ServiceKind.trip;
    return null;
  }

  /// Key used by the favourite API and the vendor add/edit route
  String get apiKey => switch (this) {
    ServiceKind.restaurant => 'resturant',
    ServiceKind.hotel => 'hotel',
    ServiceKind.trip => 'trip',
  };

  /// Item type understood by `BookingTypeIcon`
  String get itemType => switch (this) {
    ServiceKind.restaurant => 'restaurant',
    ServiceKind.hotel => 'hotel',
    ServiceKind.trip => 'trip',
  };
}
