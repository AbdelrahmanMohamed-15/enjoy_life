import 'package:easy_life/Core/Helper/service_kind.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Routes/app_routes.dart';
import 'package:easy_life/Features/Home/Domain/Entity/resturant_entity.dart';
import 'package:easy_life/Features/Home/Presentation/cubit/home_cubit.dart';

import '../../../../Core/Handler/auth_handler.dart';
import '../../../../Core/Helper/dependency_injection_helper.dart';

/// Shared tap / favourite behaviour of restaurant, hotel and trip cards.
class ServiceActions {
  ServiceActions._();

  static bool get isVendor {
    final user = DependencyInjectionHelper()
        .sl<AuthHandlerInterface>()
        .getUserData();
    return user != null && user.clientType != 0;
  }

  /// Customers open the details page; vendors open the edit form of their
  /// own listing.
  static void open(HomeData data) {
    final kind = ServiceKind.of(id: data.serviceId, name: data.serviceName);
    if (!isVendor) {
      AppNavigation.pushNamed(
        AppRoutes.resturantDetails,
        arguments: {"serviceID": data.id, "type": data.serviceName},
      );
      return;
    }
    AppNavigation.pushNamed(
      AppRoutes.addService,
      arguments: {
        'type': (kind ?? ServiceKind.restaurant).apiKey,
        'isEdit': true,
        'id': data.id,
      },
    );
  }

  /// Returns whether the server accepted the change.
  static Future<bool> setFavourite(
    HomeCubit cubit,
    HomeData data,
    bool favourite,
  ) async {
    final kind = ServiceKind.of(id: data.serviceId, name: data.serviceName);
    if (kind == null) return false;
    final id = data.id ?? 0;
    return favourite
        ? cubit.addFavourite(id: id, type: kind.apiKey)
        : cubit.removeFavourite(id: id, type: kind.apiKey);
  }
}
