import 'dart:async';

import 'package:easy_life/Core/Extentions/extentions.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/Authentication/Presentation/cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../../../../Core/Constant/assets_strings.dart';
import '../../../../../Core/Constant/base_constant.dart';
import '../../../../../Core/Routes/app_navigation.dart';
import '../../../../../Core/Themes/app_colors.dart';
import '../../../../../Core/Widget/main_app_button.dart';

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
    var size = MediaQuery.sizeOf(context);
    return PopScope(
      // Guests reach this from inside the app and must be able to go back
      canPop: true,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(LocaleKeys.authOtpTitle.tr()),
            leading: GestureDetector(
              onTap: () {
                AppNavigation.pop();
                widget.authCubit.emailRestController.clear();
                widget.authCubit.newPasswordController.clear();
                widget.authCubit.confirmRestPasswordController.clear();
              },
              child: Icon(Icons.arrow_back_ios, color: AppColors.primary400),
            ),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              children: [
                Image.asset(
                  AssetsStrings.appLogo,
                  height: 120,
                  width: size.width * 0.6,
                ),
                SizedBox(height: 20),
                Text(
                  LocaleKeys.authOtpTitle.tr(),
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: AppColors.black700,
                  ),
                ).setCenter(),
                SizedBox(height: 50),
                Center(
                  child: Pinput(
                    length: 6,
                    controller: widget.authCubit.otpRestController,
                    focusedPinTheme: PinTheme(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.primary400,
                          width: 1,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.authOtpRequired.tr();
                      }
                      if (value.length != 6) {
                        return LocaleKeys.authOtpInvalid.tr();
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 32),
                MainAppButton(
                  child: Text(
                    widget.isRegister == false
                        ? LocaleKeys.authOtpResetButton.tr()
                        : LocaleKeys.authOtpActivateButton.tr(),
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: AppColors.natural100,
                      fontFamily: BaseConstant.cairoBold,
                    ),
                  ),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isRegister == false) {
                        // Verifies the code, then resets the password
                        widget.authCubit.verifyResetOtp();
                      } else {
                        widget.authCubit.activeEmail();
                      }
                    }
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: _canResend
                      ? TextButton(
                          onPressed: _handleResendCode,
                          child: Text(
                            LocaleKeys.authOtpResend.tr(),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.primary400,
                              fontFamily: BaseConstant.cairoBold,
                              fontSize: 15,
                            ),
                          ),
                        )
                      : Text(
                          LocaleKeys.authOtpResendCountdown.tr(
                            namedArgs: {
                              'time': _formatTime(_secondsRemaining),
                            },
                          ),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.natural500,
                            fontFamily: BaseConstant.cairoBold,
                            fontSize: 15,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
