import 'package:flutter/material.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Themes/app_colors.dart';

/// Circular user photo. Falls back to the user's initials when there is no
/// image or it fails to load, instead of the generic "404" placeholder.
class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double size;
  final double borderWidth;
  const ProfileAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = 50,
    this.borderWidth = 2,
  });

  String get _initials {
    final parts = (name ?? '')
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.characters.first.toUpperCase();
    return (parts.first.characters.first + parts.last.characters.first)
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final url = imageUrl?.trim() ?? '';
    return Container(
      height: size,
      width: size,
      padding: EdgeInsets.all(borderWidth),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: ClipOval(
        child: url.isEmpty
            ? _fallback()
            : Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Profile image failed to load: $url');
                  return _fallback();
                },
              ),
      ),
    );
  }

  Widget _fallback() {
    final initials = _initials;
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary200, AppColors.primary400],
        ),
      ),
      child: initials.isEmpty
          ? Icon(Icons.person_rounded, color: Colors.white, size: size * 0.55)
          : Text(
              initials,
              style: TextStyle(
                color: Colors.white,
                fontFamily: BaseConstant.cairoBold,
                fontSize: size * 0.36,
              ),
            ),
    );
  }
}
