import 'dart:async';

import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/Authentication/Presentation/cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../../../../Core/Constant/base_constant.dart';
import '../../../../../Core/Routes/app_navigation.dart';
import '../../../../../Core/Themes/app_colors.dart';
import '../../../../../Core/Widget/app_ui.dart';
import '../../Widget/auth_layout.dart';

class RestOtpScreen extends StatefulWidget {
  final AuthCubit authCubit;
  final bool isRegister;
  const RestOtpScreen({
    super.key,
    required this.authCubit,
    required this.isRegister,
  });

  @override
  State<RestOtpScreen> createState() => _RestOtpScreenState();
}

class _RestOtpScreenState extends State<RestOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  static const int _resendDuration = 60;

  Timer? _resendTimer;
  int _secondsRemaining = _resendDuration;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    setState(() {
      _secondsRemaining = _resendDuration;
      _canResend = false;
    });

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 1) {
        timer.cancel();
        setState(() {
          _secondsRemaining = 0;
          _canResend = true;
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  Future<void> _handleResendCode() async {
    if (!_canResend) return;

    final success = await widget.authCubit.resendCode(
      isRegister: widget.isRegister,
    );
    if (success && mounted) {
      _startResendTimer();
    }
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final email = widget.isRegister
        ? widget.authCubit.emailController.text
        : widget.authCubit.emailRestController.text;
    final pinTheme = PinTheme(
      height: 54,
      width: 48,
      textStyle: theme.textTheme.titleLarge?.copyWith(
        fontFamily: BaseConstant.cairoBold,
        color: AppColors.black700,
      ),
      decoration: BoxDecoration(
        color: AppColors.natural50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.natural200),
      ),
    );
    return Form(
      key: _formKey,
      child: AuthLayout(
        title: LocaleKeys.authOtpTitle.tr(),
        subtitle: LocaleKeys.authOtpSubtitle.tr(namedArgs: {'email': email}),
        onBack: () {
          widget.authCubit.otpRestController.clear();
          AppNavigation.pop();
        },
        children: [
          Directionality(
            // Codes are typed left to right in both languages
            textDirection: TextDirection.ltr,
            child: Pinput(
              length: 6,
              controller: widget.authCubit.otpRestController,
              keyboardType: TextInputType.number,
              autofocus: true,
              defaultPinTheme: pinTheme,
              focusedPinTheme: pinTheme.copyDecorationWith(
                color: Colors.white,
                border: Border.all(color: AppColors.primary500, width: 1.5),
              ),
              submittedPinTheme: pinTheme.copyDecorationWith(
                color: AppColors.primary100.withValues(alpha: 0.4),
                border: Border.all(color: AppColors.primary300),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return LocaleKeys.authOtpRequired.tr();
                }
                if (value.length != 6) {
                  return LocaleKeys.authOtpInvalid.tr();
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 28),
          AppGradientButton(
            label: widget.isRegister
                ? LocaleKeys.authOtpActivateButton.tr()
                : LocaleKeys.authOtpResetButton.tr(),
            icon: Icons.verified_rounded,
            onTap: () {
              if (!_formKey.currentState!.validate()) return;
              if (widget.isRegister) {
                widget.authCubit.activeEmail();
              } else {
                // Verifies the code first, then resets the password. Calling
                // resetPassword() directly never sent the code at all.
                widget.authCubit.verifyResetOtp();
              }
            },
          ),
          const SizedBox(height: 16),
          Center(
            child: _canResend
                ? TextButton.icon(
                    onPressed: _handleResendCode,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary600,
                    ),
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: Text(
                      LocaleKeys.authOtpResend.tr(),
                      style: const TextStyle(
                        fontFamily: BaseConstant.cairoBold,
                      ),
                    ),
                  )
                : Text(
                    LocaleKeys.authOtpResendCountdown.tr(
                      namedArgs: {'time': _formatTime(_secondsRemaining)},
                    ),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.natural500,
                      fontFamily: BaseConstant.cairoBold,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
