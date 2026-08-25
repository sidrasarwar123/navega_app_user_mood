import 'package:flutter/material.dart';
import 'package:navega_app/core/constants/app_color.dart';

class NavItemData {
  final IconData icon;
  final String label;

  const NavItemData({required this.icon, required this.label});
}

class HomeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback? onCenterButtonTap;

  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.onCenterButtonTap,
  });

  static const _items = [
    NavItemData(icon: Icons.home_rounded, label: 'Home'),
    NavItemData(icon: Icons.chat_bubble_outline_rounded, label: 'Chats'),
    NavItemData(icon: Icons.favorite_border_rounded, label: 'Favourites'),
    NavItemData(icon: Icons.person_outline_rounded, label: 'Profile'),
  ];

  static const double _barHeight = 72;
  static const double _circleSize = 60;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _barHeight + 20, // extra room for the raised circle + dot
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // Flat, full-width bar with a curved notch cut into the top
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: _NotchClipper(),
              child: Container(
                height: _barHeight,
                color: AppColors.primaryBlue,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _buildNavItem(0)),
                    Expanded(child: _buildNavItem(1)),
                    const SizedBox(width: 64), // space for center circle
                    Expanded(child: _buildNavItem(2)),
                    Expanded(child: _buildNavItem(3)),
                  ],
                ),
              ),
            ),
          ),

          // Raised circular "+" button sitting inside the notch
          Positioned(
            top: 0,
            child: InkWell(
              onTap: onCenterButtonTap,
              customBorder: const CircleBorder(),
              child: Container(
                height: _circleSize,
                width: _circleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(6),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryBlueDark,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    color: AppColors.primaryBlueDark,
                    size: 26,
                  ),
                ),
              ),
            ),
          ),

          
        ],
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final item = _items[index];
    final isSelected = index == currentIndex;
    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            item.icon,
            size: 22,
            color: isSelected
                ? AppColors.white
                : AppColors.white.withValues(alpha: 0.75),
          ),
          const SizedBox(height: 4),
          Text(
            item.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? AppColors.white
                  : AppColors.white.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}


class _NotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double w = size.width;
    final double h = size.height;
    final double centerX = w / 2;
    const double notchRadius = 38;

    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(centerX - notchRadius - 18, 0);

    // Curve down into the notch
    path.quadraticBezierTo(
      centerX - notchRadius, 0,
      centerX - notchRadius, 20,
    );
    path.arcToPoint(
      Offset(centerX + notchRadius, 20),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );
    // Curve back up out of the notch
    path.quadraticBezierTo(
      centerX + notchRadius, 0,
      centerX + notchRadius + 18, 0,
    );

    path.lineTo(w, 0);
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}