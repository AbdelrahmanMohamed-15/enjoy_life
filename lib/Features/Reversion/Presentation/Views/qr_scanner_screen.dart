import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/Reversion/Presentation/cubit/reversion_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../Core/Themes/app_colors.dart';

/// Camera scanner for order QR codes. Pops with the order code once the
/// reservation is confirmed; on a rejected code it resumes scanning.
class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen>
    with SingleTickerProviderStateMixin {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  late final AnimationController _lineController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat(reverse: true);

  /// True while a detected code is being confirmed with the server
  bool _busy = false;

  @override
  void dispose() {
    _lineController.dispose();
    controller.dispose();
    // The tabs below sit inside a SafeArea, so nothing re-applies their
    // style; restore dark status bar icons for the light screens
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_busy) return;
    String? code;
    for (final barcode in capture.barcodes) {
      final value = barcode.rawValue?.trim();
      if (value != null && value.isNotEmpty) {
        code = value;
        break;
      }
    }
    if (code == null) return;

    setState(() => _busy = true);
    HapticFeedback.mediumImpact();
    await controller.stop();
    if (!mounted) return;
    final success = await context.read<ReversionCubit>().scanOrder(
      qrCode: code,
    );
    if (!mounted) return;
    if (success) {
      Navigator.of(context).pop(code);
    } else {
      // Let the vendor try again without leaving the screen
      setState(() => _busy = false);
      await controller.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            LocaleKeys.reversionQrTitle.tr(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: BaseConstant.cairoBold,
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.biggest;
            final side = size.width * 0.72;
            // The window is both drawn and passed to the scanner, so only
            // codes inside the frame are read
            final scanWindow = Rect.fromCenter(
              center: Offset(size.width / 2, size.height * 0.42),
              width: side,
              height: side,
            );
            return Stack(
              fit: StackFit.expand,
              children: [
                MobileScanner(
                  controller: controller,
                  scanWindow: scanWindow,
                  onDetect: _onDetect,
                  errorBuilder: (context, error) => _CameraError(error: error),
                ),
                IgnorePointer(
                  child: CustomPaint(painter: _OverlayPainter(scanWindow)),
                ),
                if (!_busy)
                  AnimatedBuilder(
                    animation: _lineController,
                    builder: (context, _) => Positioned(
                      left: scanWindow.left + 16,
                      width: scanWindow.width - 32,
                      top:
                          scanWindow.top +
                          12 +
                          (scanWindow.height - 24) * _lineController.value,
                      child: Container(
                        height: 2.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: AppColors.primary400,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary400.withValues(
                                alpha: 0.7,
                              ),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  Positioned.fromRect(
                    rect: scanWindow,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                Positioned(
                  top: scanWindow.bottom + 24,
                  left: 24,
                  right: 24,
                  child: Text(
                    LocaleKeys.reversionScanAlign.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: BaseConstant.cairoBold,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 28),
                      child: _ScannerControls(controller: controller),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ScannerControls extends StatelessWidget {
  final MobileScannerController controller;
  const _ScannerControls({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MobileScannerState>(
      valueListenable: controller,
      builder: (context, state, _) {
        final torchOn = state.torchState == TorchState.on;
        final torchAvailable = state.torchState != TorchState.unavailable;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _RoundControl(
              icon: torchOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
              label: LocaleKeys.reversionScanTorch.tr(),
              isActive: torchOn,
              onTap: torchAvailable ? controller.toggleTorch : null,
            ),
            const SizedBox(width: 36),
            _RoundControl(
              icon: Icons.flip_camera_android_rounded,
              label: LocaleKeys.reversionScanFlip.tr(),
              onTap: state.isRunning ? () => controller.switchCamera() : null,
            ),
          ],
        );
      },
    );
  }
}

class _RoundControl extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;
  const _RoundControl({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: isActive
                ? AppColors.primary500
                : Colors.white.withValues(alpha: 0.18),
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Icon(icon, color: Colors.white, size: 26),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _CameraError extends StatelessWidget {
  final MobileScannerException error;
  const _CameraError({required this.error});

  @override
  Widget build(BuildContext context) {
    debugPrint('Scanner error: ${error.errorCode} ${error.errorDetails}');
    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.no_photography_rounded,
                color: Colors.white70,
                size: 56,
              ),
              const SizedBox(height: 14),
              Text(
                LocaleKeys.reversionScanCameraError.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Dims everything except the scan window and draws orange corner brackets.
class _OverlayPainter extends CustomPainter {
  final Rect window;
  _OverlayPainter(this.window);

  @override
  void paint(Canvas canvas, Size size) {
    final frame = RRect.fromRectAndRadius(window, const Radius.circular(24));
    canvas.drawPath(
      Path()
        ..fillType = PathFillType.evenOdd
        ..addRect(Offset.zero & size)
        ..addRRect(frame),
      Paint()..color = Colors.black.withValues(alpha: 0.55),
    );

    const length = 34.0;
    const radius = 24.0;
    final paint = Paint()
      ..color = AppColors.primary500
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    final l = window.left, t = window.top, r = window.right, b = window.bottom;
    // Each corner: straight edge, rounded corner, straight edge
    canvas.drawPath(
      Path()
        ..moveTo(l, t + length)
        ..lineTo(l, t + radius)
        ..arcToPoint(
          Offset(l + radius, t),
          radius: const Radius.circular(radius),
        )
        ..lineTo(l + length, t)
        ..moveTo(r - length, t)
        ..lineTo(r - radius, t)
        ..arcToPoint(
          Offset(r, t + radius),
          radius: const Radius.circular(radius),
        )
        ..lineTo(r, t + length)
        ..moveTo(r, b - length)
        ..lineTo(r, b - radius)
        ..arcToPoint(
          Offset(r - radius, b),
          radius: const Radius.circular(radius),
        )
        ..lineTo(r - length, b)
        ..moveTo(l + length, b)
        ..lineTo(l + radius, b)
        ..arcToPoint(
          Offset(l, b - radius),
          radius: const Radius.circular(radius),
        )
        ..lineTo(l, b - length),
      paint,
    );
  }

  @override
  bool shouldRepaint(_OverlayPainter oldDelegate) =>
      oldDelegate.window != window;
}
