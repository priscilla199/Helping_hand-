import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import '../utils/constants.dart';

class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double size;
  final bool showBorder;
  final Color? borderColor;
  final double borderWidth;
  final VoidCallback? onTap;
  final bool isOnline;

  const UserAvatar({
    Key? key,
    this.imageUrl,
    this.name,
    this.size = 40.0,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth = 2.0,
    this.onTap,
    this.isOnline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: showBorder
                  ? Border.all(
                      color: borderColor ?? AppConstants.primaryColor,
                      width: borderWidth,
                    )
                  : null,
            ),
            child: ClipOval(
              child: _buildAvatarContent(),
            ),
          ),
          // Online indicator
          if (isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: size * 0.3,
                height: size * 0.3,
                decoration: BoxDecoration(
                  color: AppConstants.successColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppConstants.surfaceColor,
                    width: 2.0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAvatarContent() {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      // For demo purposes, just show initials instead of network image
      return _buildInitials();
      // return CachedNetworkImage(
      //   imageUrl: imageUrl!,
      //   fit: BoxFit.cover,
      //   placeholder: (context, url) => _buildPlaceholder(),
      //   errorWidget: (context, url, error) => _buildInitials(),
      // );
    } else {
      return _buildInitials();
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppConstants.primaryLightColor,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
        ),
      ),
    );
  }

  Widget _buildInitials() {
    final initials = _getInitials();
    return Container(
      color: AppConstants.primaryLightColor,
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: AppConstants.primaryColor,
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _getInitials() {
    if (name == null || name!.isEmpty) {
      return 'U';
    }

    final nameParts = name!.trim().split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    } else {
      return name![0].toUpperCase();
    }
  }
}

// Small avatar variant
class SmallUserAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double size;
  final VoidCallback? onTap;

  const SmallUserAvatar({
    Key? key,
    this.imageUrl,
    this.name,
    this.size = 32.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserAvatar(
      imageUrl: imageUrl,
      name: name,
      size: size,
      onTap: onTap,
    );
  }
}

// Large avatar variant
class LargeUserAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double size;
  final bool showBorder;
  final VoidCallback? onTap;

  const LargeUserAvatar({
    Key? key,
    this.imageUrl,
    this.name,
    this.size = 80.0,
    this.showBorder = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserAvatar(
      imageUrl: imageUrl,
      name: name,
      size: size,
      showBorder: showBorder,
      onTap: onTap,
    );
  }
}

// Avatar with status
class StatusUserAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double size;
  final bool isOnline;
  final bool isVerified;
  final VoidCallback? onTap;

  const StatusUserAvatar({
    Key? key,
    this.imageUrl,
    this.name,
    this.size = 48.0,
    this.isOnline = false,
    this.isVerified = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          UserAvatar(
            imageUrl: imageUrl,
            name: name,
            size: size,
            showBorder: true,
            onTap: onTap,
          ),
          // Online indicator
          if (isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: size * 0.25,
                height: size * 0.25,
                decoration: BoxDecoration(
                  color: AppConstants.successColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppConstants.surfaceColor,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          // Verification badge
          if (isVerified)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: size * 0.3,
                height: size * 0.3,
                decoration: BoxDecoration(
                  color: AppConstants.secondaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppConstants.surfaceColor,
                    width: 2.0,
                  ),
                ),
                child: const Icon(
                  Icons.verified,
                  color: AppConstants.textWhiteColor,
                  size: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
} 