import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/Reversion/Presentation/cubit/reversion_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../Core/Routes/app_navigation.dart';
import '../../../../Core/Themes/app_colors.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final MobileScannerController controller = MobileScannerController();
  bool _isScanning = true;
  bool _hasResetFlag = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _stopScanner() {
    if (_isScanning) {
      controller.stop();
      setState(() {
        _isScanning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<ReversionCubit, ReversionState>(
      builder: (context, state) {
        var reversionCubit = ReversionCubit.get(context);
        // Reset scan flag when screen is first built (only once)
        if (!_hasResetFlag) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              reversionCubit.resetScanFlag();
              _hasResetFlag = true;
            }
          });
        }
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.natural100,
            appBar: AppBar(
              backgroundColor: AppColors.natural100,
              title: Text(
                LocaleKeys.reversionQrTitle.tr(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary400,
                ),
              ),
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  AppNavigation.pop();
                },
                child: Icon(Icons.arrow_back_ios, color: AppColors.primary500),
              ),
            ),
            body: Stack(
              children: [
                // Camera view
                MobileScanner(
                  controller: controller,
                  onDetect: (val) {
                    if (_isScanning) {
                      reversionCubit.onDetect(val);
                      _stopScanner();
                    }
                  },
                ),
                // Scanning overlay with white frame
                _buildScanningOverlay(context),
                // Bottom prompt
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      LocaleKeys.reversionQrPrompt.tr(),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildScanningOverlay(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scanAreaSize = size.width * 0.75; // 75% of screen width
    final scanAreaTop = size.height * 0.2; // 20% from top
    final scanAreaLeft = (size.width - scanAreaSize) / 2;

    return Stack(
      children: [
        // Top dark overlay
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: scanAreaTop,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        // Bottom dark overlay
        Positioned(
          top: scanAreaTop + scanAreaSize,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(color: Colors.black.withOpacity(0.5)),
        ),
        // Left dark overlay
        Positioned(
          top: scanAreaTop,
          left: 0,
          child: Container(
            width: scanAreaLeft,
            height: scanAreaSize,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        // Right dark overlay
        Positioned(
          top: scanAreaTop,
          right: 0,
          child: Container(
            width: scanAreaLeft,
            height: scanAreaSize,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        // White frame border
        Positioned(
          top: scanAreaTop,
          left: scanAreaLeft,
          child: Container(
            width: scanAreaSize,
            height: scanAreaSize,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
