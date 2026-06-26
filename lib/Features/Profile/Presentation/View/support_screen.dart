import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/Constant/support_constant.dart';
import 'package:easy_life/Core/Helper/url_launcher_helper.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Core/Widget/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  Future<void> _launchLink(String url) async {
    final launched = await UrlLauncherHelper.openLink(url);
    if (!launched) {
      showCustomSnackBar(
        LocaleKeys.supportLinkFailed.tr(),
        backgroundColor: AppColors.darkRed,
      );
    }
  }

  Future<void> _launchPhone(String phone) async {
    final launched = await UrlLauncherHelper.openPhone(phone);
    if (!launched) {
      showCustomSnackBar(
        LocaleKeys.supportPhoneFailed.tr(),
        backgroundColor: AppColors.darkRed,
      );
    }
  }

  Future<void> _launchEmail(String email) async {
    final launched = await UrlLauncherHelper.openEmail(email);
    if (!launched) {
      showCustomSnackBar(
        LocaleKeys.supportEmailFailed.tr(),
        backgroundColor: AppColors.darkRed,
      );
    }
  }

  Future<void> _launchWhatsApp(String phone) async {
    final launched = await UrlLauncherHelper.openWhatsApp(phone);
    if (!launched) {
      showCustomSnackBar(
        LocaleKeys.supportWhatsappFailed.tr(),
        backgroundColor: AppColors.darkRed,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.natural100,
          elevation: 1,
          title: Text(
            LocaleKeys.supportTitle.tr(),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.primary500,
              fontFamily: BaseConstant.cairoBold,
            ),
          ),
          leading: GestureDetector(
            onTap: AppNavigation.pop,
            child: const Icon(Icons.arrow_back_ios, color: AppColors.primary500),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildHeader(theme),
            const SizedBox(height: 20),
            _buildSectionTitle(theme, LocaleKeys.supportPhones.tr()),
            const SizedBox(height: 12),
            ...SupportConstant.phones.map(
              (phone) => _ContactTile(
                icon: Icons.phone_in_talk_outlined,
                title: phone,
                subtitle: LocaleKeys.supportTapCall.tr(),
                onTap: () => _launchPhone(phone),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle(theme, LocaleKeys.supportEmail.tr()),
            const SizedBox(height: 12),
            _ContactTile(
              icon: Icons.email_outlined,
              title: SupportConstant.email,
              subtitle: LocaleKeys.supportTapEmail.tr(),
              onTap: () => _launchEmail(SupportConstant.email),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle(theme, LocaleKeys.supportWhatsapp.tr()),
            const SizedBox(height: 12),
            _ContactTile(
              icon: FontAwesomeIcons.whatsapp,
              title: SupportConstant.whatsapp,
              subtitle: LocaleKeys.supportTapWhatsapp.tr(),
              onTap: () => _launchWhatsApp(SupportConstant.whatsapp),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle(theme, LocaleKeys.supportSocial.tr()),
            const SizedBox(height: 12),
            _buildSocialLinks(this),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.natural100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            offset: const Offset(0, 6),
            blurRadius: 18,
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.support_agent,
            color: AppColors.primary400,
            size: 48,
          ),
          const SizedBox(height: 12),
          Text(
            LocaleKeys.supportHeaderTitle.tr(),
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.black700,
              fontFamily: BaseConstant.cairoBold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            LocaleKeys.supportHeaderSubtitle.tr(),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.natural500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Text(
      title,
      style: theme.textTheme.titleSmall?.copyWith(
        color: AppColors.black700,
        fontFamily: BaseConstant.cairoBold,
      ),
    );
  }

  Widget _buildSocialLinks(SupportScreen screen) {
    final socialLinks = [
      _SocialLink(
        icon: FontAwesomeIcons.facebookF,
        label: LocaleKeys.supportFacebook.tr(),
        color: const Color(0xFF1877F2),
        url: SupportConstant.facebookUrl,
      ),
      _SocialLink(
        icon: FontAwesomeIcons.instagram,
        label: LocaleKeys.supportInstagram.tr(),
        color: const Color(0xFFE4405F),
        url: SupportConstant.instagramUrl,
      ),
      _SocialLink(
        icon: FontAwesomeIcons.xTwitter,
        label: LocaleKeys.supportTwitter.tr(),
        color: AppColors.black700,
        url: SupportConstant.twitterUrl,
      ),
      _SocialLink(
        icon: FontAwesomeIcons.youtube,
        label: LocaleKeys.supportYoutube.tr(),
        color: const Color(0xFFFF0000),
        url: SupportConstant.youtubeUrl,
      ),
      _SocialLink(
        icon: FontAwesomeIcons.globe,
        label: LocaleKeys.supportWebsite.tr(),
        color: AppColors.primary400,
        url: SupportConstant.websiteUrl,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.natural100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            offset: const Offset(0, 6),
            blurRadius: 18,
          ),
        ],
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: socialLinks
            .map(
              (link) => _SocialButton(
                link: link,
                onTap: () => screen._launchLink(link.url),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.natural100,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.natural200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              offset: const Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary400, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.black700,
                      fontFamily: BaseConstant.cairoBold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.natural400,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AppColors.natural300,
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialLink {
  final IconData icon;
  final String label;
  final Color color;
  final String url;

  const _SocialLink({
    required this.icon,
    required this.label,
    required this.color,
    required this.url,
  });
}

class _SocialButton extends StatelessWidget {
  final _SocialLink link;
  final VoidCallback onTap;

  const _SocialButton({
    required this.link,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: link.color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: link.color.withOpacity(0.2)),
            ),
            child: Icon(link.icon, color: link.color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            link.label,
            style: const TextStyle(
              color: AppColors.natural600,
              fontSize: 12,
              fontFamily: BaseConstant.cairoBold,
            ),
          ),
        ],
      ),
    );
  }
}
