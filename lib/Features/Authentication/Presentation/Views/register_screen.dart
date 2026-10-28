import 'package:easy_life/Core/Helper/input_validator.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Routes/app_routes.dart';
import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_life/Core/Widget/custom_text_form_field.dart';
import 'package:easy_life/Features/Authentication/Presentation/cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/custom_country_code.dart';
import '../Widget/auth_layout.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  bool isObscure2 = true;
  String dailCode = '+20';

  Widget _icon(IconData icon) => Icon(icon, color: AppColors.primary400);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var authCubit = AuthCubit.get(context);
        const gap = SizedBox(height: 14);
        return Form(
          key: _formKey,
          child: AuthLayout(
            title: LocaleKeys.authRegisterTitle.tr(),
            subtitle: LocaleKeys.authRegisterSubtitle.tr(),
            children: [
              CustomTextFormField(
                controller: authCubit.nameController,
                hintText: LocaleKeys.authRegisterUsernameHint.tr(),
                prefixIcon: _icon(Icons.person_rounded),
                textInputAction: TextInputAction.next,
                validator: (value) => InputValidator.validateNotEmpty(value),
              ),
              gap,
              CustomTextFormField(
                controller: authCubit.emailController,
                hintText: LocaleKeys.authRegisterEmailHint.tr(),
                textInputType: TextInputType.emailAddress,
                prefixIcon: _icon(Icons.alternate_email_rounded),
                textInputAction: TextInputAction.next,
                validator: (value) => InputValidator.validateEmail(value),
              ),
              gap,
              CustomTextFormField(
                controller: authCubit.regPhoneController,
                hintText: LocaleKeys.authRegisterPhoneHint.tr(),
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: (value) => InputValidator.validateNotEmpty(value),
                prefixIcon: CustomCountryCode(
                  onChanged: (value) {
                    setState(() => dailCode = value.dialCode ?? '+20');
                  },
                ),
              ),
              gap,
              CustomTextFormField(
                controller: authCubit.addressController,
                hintText: LocaleKeys.authRegisterAddressHint.tr(),
                prefixIcon: _icon(Icons.location_on_rounded),
                textInputAction: TextInputAction.next,
                validator: (value) => InputValidator.validateNotEmpty(value),
              ),
              gap,
              CustomTextFormField(
                controller: authCubit.regPasswordController,
                hintText: LocaleKeys.authRegisterPasswordHint.tr(),
                textInputType: TextInputType.visiblePassword,
                obscureText: isObscure,
                prefixIcon: _icon(Icons.lock_rounded),
                textInputAction: TextInputAction.next,
                validator: (value) => InputValidator.validateNotEmpty(value),
                suffixIcon: PasswordToggle(
                  obscured: isObscure,
                  onTap: () => setState(() => isObscure = !isObscure),
                ),
              ),
              gap,
              CustomTextFormField(
                controller: authCubit.confirmPasswordController,
                hintText: LocaleKeys.authRegisterConfirmPasswordHint.tr(),
                textInputType: TextInputType.visiblePassword,
                obscureText: isObscure2,
                prefixIcon: _icon(Icons.lock_reset_rounded),
                validator: (value) => InputValidator.validateConfirmPassword(
                  value,
                  authCubit.regPasswordController.text,
                ),
                suffixIcon: PasswordToggle(
                  obscured: isObscure2,
                  onTap: () => setState(() => isObscure2 = !isObscure2),
                ),
              ),
              const SizedBox(height: 24),
              AppGradientButton(
                label: LocaleKeys.authRegisterButton.tr(),
                icon: Icons.person_add_alt_1_rounded,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    authCubit.register(
                      authCubit: authCubit,
                      dailCode: dailCode,
                    );
                  }
                },
              ),
            ],
            footer: AuthSwitchLink(
              text: LocaleKeys.authRegisterHaveAccount.tr(),
              action: LocaleKeys.authRegisterLoginLink.tr(),
              onTap: () => AppNavigation.pushReplacementNamed(AppRoutes.login),
            ),
          ),
        );
      },
    );
  }
}
