import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/routes.dart';
import 'package:easy_life/Core/Widget/custom_text_form_field.dart';
import 'package:easy_life/Features/Reversion/Presentation/cubit/reversion_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Themes/app_colors.dart';

/// Vendor "Scan" tab: scan an order QR code, or type the order number, to
/// confirm the customer's reservation.
class ScanOrderScreen extends StatefulWidget {
  const ScanOrderScreen({super.key});

  @override
  State<ScanOrderScreen> createState() => _ScanOrderScreenState();
}

class _ScanOrderScreenState extends State<ScanOrderScreen> {
  final reversionCubit = DependencyInjectionHelper().sl<ReversionCubit>();
  String? _lastCode;
  DateTime? _lastAt;

  @override
  void dispose() {
    reversionCubit.close();
    super.dispose();
  }

  void _onConfirmed(String code) {
    if (!mounted) return;
    setState(() {
      _lastCode = code;
      _lastAt = DateTime.now();
    });
  }

  Future<void> _openScanner() async {
    final code = await AppNavigation.pushNamed(AppRoutes.scanQRScreen);
    if (code is String) _onConfirmed(code);
  }

  Future<void> _enterManually() async {
    final code = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => const _ManualCodeSheet(),
    );
    if (code == null || code.trim().isEmpty) return;
    final success = await reversionCubit.scanOrder(qrCode: code);
    if (success) _onConfirmed(code.trim());
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          LocaleKeys.reversionScanTitle.tr(),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 20,
            color: AppColors.primary500,
            fontFamily: BaseConstant.cairoBold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          _HeroCard(onScan: _openScanner, onManual: _enterManually),
          if (_lastCode != null) ...[
            const SizedBox(height: 16),
            _LastConfirmedCard(code: _lastCode!, at: _lastAt!),
          ],
          const SizedBox(height: 16),
          const _StepsCard(),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final VoidCallback onScan;
  final VoidCallback onManual;
  const _HeroCard({required this.onScan, required this.onManual});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary300, AppColors.primary600],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary500.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.18),
            ),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(
                Icons.qr_code_scanner_rounded,
                size: 56,
                color: AppColors.primary600,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            LocaleKeys.reversionScanTitle.tr(),
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontFamily: BaseConstant.cairoBold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            LocaleKeys.reversionScanSubtitle.tr(),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: onScan,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary600,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: const Icon(Icons.photo_camera_rounded),
              label: Text(
                LocaleKeys.reversionScanButton.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: BaseConstant.cairoBold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: onManual,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white.withValues(alpha: 0.7)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: const Icon(Icons.keyboard_rounded, size: 20),
              label: Text(
                LocaleKeys.reversionScanManual.tr(),
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: BaseConstant.cairoBold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LastConfirmedCard extends StatelessWidget {
  final String code;
  final DateTime at;
  const _LastConfirmedCard({required this.code, required this.at});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    const green = Color(0xFF2EAD5B);
    String time;
    try {
      time = DateFormat.jm(context.locale.toString()).format(at);
    } catch (_) {
      time = '${at.hour}:${at.minute.toString().padLeft(2, '0')}';
    }
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: green.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: green.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: green,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.reversionScanSuccess.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: BaseConstant.cairoBold,
                    color: AppColors.black700,
                  ),
                ),
                Text(
                  '${LocaleKeys.orderNumber.tr(namedArgs: {'code': code})}  •  $time',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.natural600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepsCard extends StatelessWidget {
  const _StepsCard();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final steps = [
      (Icons.receipt_long_rounded, LocaleKeys.reversionScanStep1.tr()),
      (Icons.qr_code_scanner_rounded, LocaleKeys.reversionScanStep2.tr()),
      (Icons.verified_rounded, LocaleKeys.reversionScanStep3.tr()),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.reversionScanStepsTitle.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontFamily: BaseConstant.cairoBold,
              color: AppColors.black700,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < steps.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: i == steps.length - 1 ? 0 : 12),
              child: Row(
                children: [
                  Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      color: AppColors.primary100.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      steps[i].$1,
                      size: 20,
                      color: AppColors.primary600,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      steps[i].$2,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.natural600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Owns its controller: the sheet keeps building while it animates closed,
/// so the controller must live until the sheet itself is disposed.
class _ManualCodeSheet extends StatefulWidget {
  const _ManualCodeSheet();

  @override
  State<_ManualCodeSheet> createState() => _ManualCodeSheetState();
}

class _ManualCodeSheetState extends State<_ManualCodeSheet> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Open the keyboard straight away
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    void submit() => Navigator.pop(context, controller.text.trim());
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        12,
        20,
        20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.natural300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              LocaleKeys.reversionScanManual.tr(),
              style: theme.textTheme.titleMedium?.copyWith(
                fontFamily: BaseConstant.cairoBold,
                color: AppColors.black700,
              ),
            ),
            const SizedBox(height: 14),
            CustomTextFormField(
              controller: controller,
              focusNode: focusNode,
              hintText: LocaleKeys.reversionScanManualHint.tr(),
              textInputAction: TextInputAction.done,
              prefixIcon: const Icon(
                Icons.tag_rounded,
                color: AppColors.primary500,
              ),
              onChanged: (_) {},
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary500,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.verified_rounded),
                label: Text(
                  LocaleKeys.reversionScanConfirm.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: BaseConstant.cairoBold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
