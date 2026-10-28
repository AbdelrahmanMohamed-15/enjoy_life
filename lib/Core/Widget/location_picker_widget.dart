import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import '../Themes/app_colors.dart';
import 'custom_snack_bar.dart';

class LocationPickerWidget extends StatefulWidget {
  final double? initialLatitude;
  final double? initialLongitude;
  final Function(double latitude, double longitude) onLocationSelected;

  const LocationPickerWidget({
    super.key,
    this.initialLatitude,
    this.initialLongitude,
    required this.onLocationSelected,
  });

  @override
  State<LocationPickerWidget> createState() => _LocationPickerWidgetState();
}

class _LocationPickerWidgetState extends State<LocationPickerWidget> {
  GoogleMapController? _mapController;
  LatLng _selectedLocation = const LatLng(
    30.047576139335238,
    31.234770758938108,
  ); // Default to Riyadh
  Set<Marker> _markers = {};
  bool _isLoading = true;
  bool _hasLocationPermission = false;
  final String _googleApiKey = 'AIzaSyBDTFRhue-EinB6GaT2M3XryoMW6cSYiNE';
  final TextEditingController _searchController = TextEditingController();
  final Location _location = Location();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _initializeLocation();

    // Listen to text changes to maintain focus when typing
    _searchController.addListener(() {
      if (_searchController.text.isNotEmpty && !_searchFocusNode.hasFocus) {
        // If there's text but focus is lost, regain it
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _searchController.text.isNotEmpty) {
            _searchFocusNode.requestFocus();
          }
        });
      }
    });
  }

  Future<void> _checkLocationPermission() async {
    PermissionStatus status = await _location.hasPermission();
    _hasLocationPermission =
        status == PermissionStatus.granted ||
        status == PermissionStatus.grantedLimited;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _initializeLocation() async {
    if (widget.initialLatitude != null && widget.initialLongitude != null) {
      _selectedLocation = LatLng(
        widget.initialLatitude!,
        widget.initialLongitude!,
      );
      _updateMarker();
      if (mounted) setState(() => _isLoading = false);
    } else {
      await _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          if (mounted) {
            showCustomSnackBar(
              LocaleKeys.locationServiceDisabled.tr(),
              backgroundColor: AppColors.darkRed,
            );
          }
          if (mounted) setState(() => _isLoading = false);
          return;
        }
      }

      // Check location permission
      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          if (mounted) {
            showCustomSnackBar(
              LocaleKeys.locationPermissionDenied.tr(),
              backgroundColor: AppColors.darkRed,
            );
          }
          if (mounted) setState(() => _isLoading = false);
          return;
        }
      }

      if (permissionGranted == PermissionStatus.deniedForever) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(LocaleKeys.locationPermissionTitle.tr()),
                content: Text(LocaleKeys.locationPermissionMessage.tr()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(LocaleKeys.commonCancel.tr()),
                  ),
                  TextButton(
                    onPressed: () {
                      ph.openAppSettings();
                      Navigator.of(context).pop();
                    },
                    child: Text(LocaleKeys.commonOpenSettings.tr()),
                  ),
                ],
              );
            },
          );
        }
        if (mounted) setState(() => _isLoading = false);
        return;
      }

      // Get current position
      if (permissionGranted == PermissionStatus.granted ||
          permissionGranted == PermissionStatus.grantedLimited) {
        _hasLocationPermission = true;
        // getLocation() can hang forever without a GPS fix (e.g. emulators)
        LocationData locationData = await _location.getLocation().timeout(
          const Duration(seconds: 10),
        );

        _selectedLocation = LatLng(
          locationData.latitude ?? _selectedLocation.latitude,
          locationData.longitude ?? _selectedLocation.longitude,
        );
        _updateMarker();
        // Report it so the form has a location without moving the map
        widget.onLocationSelected(
          _selectedLocation.latitude,
          _selectedLocation.longitude,
        );

        if (_mapController != null) {
          await _mapController!.animateCamera(
            CameraUpdate.newLatLngZoom(_selectedLocation, 16.0),
          );
        }
      }
    } catch (e) {
      debugPrint('Error getting current location: $e');
      if (mounted) {
        showCustomSnackBar(
          LocaleKeys.locationFetchError.tr(),
          backgroundColor: AppColors.darkRed,
        );
      }
    }
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _updateMarker() {
    _markers = {
      Marker(
        markerId: const MarkerId('selected_location'),
        position: _selectedLocation,
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onDragEnd: (LatLng newPosition) {
          _selectedLocation = newPosition;
          widget.onLocationSelected(
            newPosition.latitude,
            newPosition.longitude,
          );
        },
      ),
    };
    if (mounted) {
      setState(() {});
    }
  }

  void _onMapTap(LatLng location) {
    _selectedLocation = location;
    _updateMarker();
    widget.onLocationSelected(location.latitude, location.longitude);
  }

  Future<void> _onPlaceSelected(Prediction prediction) async {
    try {
      // Use google_places_flutter's built-in method to get place details
      if (prediction.lat != null && prediction.lng != null) {
        final lat = double.parse(prediction.lat!);
        final lng = double.parse(prediction.lng!);

        _selectedLocation = LatLng(lat, lng);
        _updateMarker();

        if (_mapController != null) {
          await _mapController!.animateCamera(
            CameraUpdate.newLatLngZoom(_selectedLocation, 16.0),
          );
        }

        widget.onLocationSelected(lat, lng);
        _searchController.clear();
      }
    } catch (e) {
      debugPrint('Error selecting place: $e');
    }
  }

  CameraPosition? _currentCameraPosition;

  void _onCameraMove(CameraPosition position) {
    _currentCameraPosition = position;
    // Update marker position as camera moves for real-time feedback
    _selectedLocation = position.target;
    _updateMarker();
  }

  Future<void> _onCameraIdle() async {
    // Finalize location when camera stops moving
    if (_currentCameraPosition != null) {
      _selectedLocation = _currentCameraPosition!.target;
      _updateMarker();
      widget.onLocationSelected(
        _currentCameraPosition!.target.latitude,
        _currentCameraPosition!.target.longitude,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.natural300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _selectedLocation,
                  zoom: 15.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                  // Ensure marker is visible after map is created
                  if (mounted) {
                    _updateMarker();
                  }
                },
                // Let the map own drag gestures inside scrollable forms
                gestureRecognizers: {
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                },
                onTap: _onMapTap,
                onCameraMove: _onCameraMove,
                onCameraIdle: _onCameraIdle,
                markers: _markers,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                scrollGesturesEnabled: true,
                tiltGesturesEnabled: false,
                rotateGesturesEnabled: true,
                mapType: MapType.normal,
                myLocationEnabled: _hasLocationPermission,
                compassEnabled: false,
              ),
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: FocusScope(
                  canRequestFocus: true,
                  child: GooglePlaceAutoCompleteTextField(
                    textEditingController: _searchController,
                    focusNode: _searchFocusNode,
                    googleAPIKey: _googleApiKey,
                    inputDecoration: InputDecoration(
                      hintText: LocaleKeys.locationSearchHint.tr(),
                      hintStyle: TextStyle(color: AppColors.natural500),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.natural300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.natural300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColors.primary500,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.primary500,
                      ),
                    ),
                    debounceTime: 400,
                    countries: const ["sa", "eg"], // Saudi Arabia
                    isLatLngRequired: true,
                    getPlaceDetailWithLatLng: (prediction) {
                      _onPlaceSelected(prediction);
                    },
                    itemClick: (prediction) {
                      _onPlaceSelected(prediction);
                    },
                    itemBuilder: (context, index, prediction) {
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.natural200,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.place,
                              color: AppColors.primary500,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    prediction.description ?? '',
                                    style: TextStyle(
                                      color: AppColors.black700,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  if (prediction
                                          .structuredFormatting
                                          ?.secondaryText !=
                                      null)
                                    Text(
                                      prediction
                                          .structuredFormatting!
                                          .secondaryText!,
                                      style: TextStyle(
                                        color: AppColors.natural500,
                                        fontSize: 12,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    seperatedBuilder: const Divider(height: 1),
                    containerHorizontalPadding: 0,
                    containerVerticalPadding: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: AppColors.primary500,
                onPressed: () async {
                  await _getCurrentLocation();
                  if (_mapController != null) {
                    await _mapController!.animateCamera(
                      CameraUpdate.newLatLngZoom(_selectedLocation, 16.0),
                    );
                  }
                },
                child: const Icon(Icons.my_location, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }
}
