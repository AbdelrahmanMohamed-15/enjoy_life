import 'package:easy_life/Core/Helper/input_validator.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_life/Core/Widget/custom_text_form_field.dart';
import 'package:easy_life/Features/Authentication/Presentation/cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/Themes/app_colors.dart';
import '../../Widget/auth_layout.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  bool isObscure2 = true;

  Widget _icon(IconData icon) => Icon(icon, color: AppColors.primary400);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var authCubit = AuthCubit.get(context);
        return Form(
          key: _formKey,
          child: AuthLayout(
            title: LocaleKeys.authForgotTitle.tr(),
            subtitle: LocaleKeys.authForgotSubtitle.tr(),
            children: [
              CustomTextFormField(
                controller: authCubit.emailRestController,
                hintText: LocaleKeys.authForgotEmailHint.tr(),
                textInputType: TextInputType.emailAddress,
                prefixIcon: _icon(Icons.alternate_email_rounded),
                textInputAction: TextInputAction.next,
                validator: (value) => InputValidator.validateEmail(value),
              ),
              const SizedBox(height: 14),
              CustomTextFormField(
                controller: authCubit.newPasswordController,
                hintText: LocaleKeys.authForgotPasswordHint.tr(),
                textInputType: TextInputType.visiblePassword,
                obscureText: isObscure,
                prefixIcon: _icon(Icons.lock_rounded),
                textInputAction: TextInputAction.next,
                validator: (value) => InputValidator.validatePassword(value),
                suffixIcon: PasswordToggle(
                  obscured: isObscure,
                  onTap: () => setState(() => isObscure = !isObscure),
                ),
              ),
              const SizedBox(height: 14),
              CustomTextFormField(
                // resetPassword() sends this controller as the confirmation
                controller: authCubit.confirmRestPasswordController,
                hintText: LocaleKeys.authForgotConfirmHint.tr(),
                textInputType: TextInputType.visiblePassword,
                obscureText: isObscure2,
                prefixIcon: _icon(Icons.lock_reset_rounded),
                validator: (value) => InputValidator.validateConfirmPassword(
                  value,
                  authCubit.newPasswordController.text,
                ),
                suffixIcon: PasswordToggle(
                  obscured: isObscure2,
                  onTap: () => setState(() => isObscure2 = !isObscure2),
                ),
              ),
              const SizedBox(height: 24),
              AppGradientButton(
                label: LocaleKeys.authForgotButton.tr(),
                icon: Icons.send_rounded,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    authCubit.forgetPassword(authCubit: authCubit);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
