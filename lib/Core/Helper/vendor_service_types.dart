import 'package:flutter/foundation.dart';

import '../../Features/Home/Domain/Usecases/get_vendor_hotels_usecases.dart';
import '../../Features/Home/Domain/Usecases/get_vendor_resturant_usecases.dart';
import '../../Features/Home/Domain/Usecases/get_vendor_trips_usecases.dart';
import '../Handler/auth_handler.dart';

/// Which services (1 restaurant, 2 hotel, 3 trip) the logged-in vendor runs.
///
/// The API has no vendor-type field, so it is derived from the vendor's own
/// listings: a vendor with only restaurants only sees restaurant options. A
/// vendor with no listings yet (or when loading fails) sees all three, so
/// they can still create their first one.
class VendorServiceTypes {
  VendorServiceTypes({
    required this.authHandler,
    required this.getVendorResturantUsecases,
    required this.getVendorHotelsUsecases,
    required this.getVendorTripsUsecases,
  });

  final AuthHandlerInterface authHandler;
  final GetVendorResturantUsecases getVendorResturantUsecases;
  final GetVendorHotelsUsecases getVendorHotelsUsecases;
  final GetVendorTripsUsecases getVendorTripsUsecases;

  static const Set<int> all = {1, 2, 3};

  /// null until the first load for the current vendor finishes
  final ValueNotifier<Set<int>?> types = ValueNotifier(null);
  int? _loadedForUser;

  /// The types to show right now (all of them while still loading)
  Set<int> get current => types.value ?? all;

  /// Loads (or refreshes) the vendor's types. Safe to call on every screen
  /// open; switching accounts drops the previous vendor's result first.
  Future<void> load() async {
    final userId = authHandler.getUserData()?.id;
    if (userId != _loadedForUser) {
      types.value = null;
      _loadedForUser = userId;
    }
    final results = await Future.wait([
      getVendorResturantUsecases(),
      getVendorHotelsUsecases(),
      getVendorTripsUsecases(),
    ]);
    // Ignore a result that arrives after the account changed
    if (authHandler.getUserData()?.id != userId) return;

    var failed = false;
    final found = <int>{};
    for (var i = 0; i < results.length; i++) {
      results[i].fold((_) => failed = true, (home) {
        if ((home.data ?? []).isNotEmpty) found.add(i + 1);
      });
    }
    // On a failed request keep everything visible rather than hiding a
    // service the vendor may actually have
    types.value = failed || found.isEmpty ? all : found;
  }
}
