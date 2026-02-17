import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/features/pages/account/widgets/account_menu_item.dart';

/// Account Menu Card Widget
///
/// White card containing menu items for the Account screen.
/// Has 8 items: Profile, Orders, Address, Voucher, Policy, FAQ, Language, Logout.
class AccountMenuCard extends StatelessWidget {
  /// Callback when "Thông tin cá nhân" is tapped
  final VoidCallback? onProfileTap;

  /// Callback when "Đơn hàng của tôi" is tapped
  final VoidCallback? onOrdersTap;

  /// Callback when "Địa chỉ đặt hàng" is tapped
  final VoidCallback? onAddressTap;

  /// Callback when "Voucher của tôi" is tapped
  final VoidCallback? onVoucherTap;

  /// Callback when "Chính sách & Điều khoản" is tapped
  final VoidCallback? onPolicyTap;

  /// Callback when "Câu hỏi thường gặp" is tapped
  final VoidCallback? onFaqTap;

  /// Callback when "Ngôn ngữ" is tapped
  final VoidCallback? onLanguageTap;

  /// Callback when "Đăng xuất" is tapped
  final VoidCallback? onLogoutTap;

  /// Whether user is logged in (controls logout visibility)
  final bool isLoggedIn;

  const AccountMenuCard({
    super.key,
    this.onProfileTap,
    this.onOrdersTap,
    this.onAddressTap,
    this.onVoucherTap,
    this.onPolicyTap,
    this.onFaqTap,
    this.onLanguageTap,
    this.onLogoutTap,
    this.isLoggedIn = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
      padding: EdgeInsets.all(UISizes.square.r12),
      decoration: BoxDecoration(
        color: UIColors.white,
        borderRadius: BorderRadius.circular(UISizes.square.r12),
        boxShadow: [
          BoxShadow(
            color: UIColors.cardShadow,
            blurRadius: UISizes.square.r4,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AccountMenuItem(
            iconPath: UISvgs.menuProfile,
            title: 'Thông tin cá nhân',
            onTap: onProfileTap,
          ),
          AccountMenuItem(
            iconPath: UISvgs.menuOrders,
            title: 'Đơn hàng của tôi',
            onTap: onOrdersTap,
          ),
          AccountMenuItem(
            iconPath: UISvgs.menuAddress,
            title: 'Địa chỉ đặt hàng',
            onTap: onAddressTap,
          ),
          AccountMenuItem(
            iconPath: UISvgs.menuVoucher,
            title: 'Voucher của tôi',
            onTap: onVoucherTap,
          ),
          AccountMenuItem(
            iconPath: UISvgs.menuPolicy,
            title: 'Chính sách & Điều khoản',
            onTap: onPolicyTap,
          ),
          AccountMenuItem(
            iconPath: UISvgs.menuFaq,
            title: 'Câu hỏi thường gặp',
            onTap: onFaqTap,
          ),
          AccountMenuItem(
            iconPath: UISvgs.menuLanguage,
            title: 'Ngôn ngữ',
            onTap: onLanguageTap,
          ),
          if (isLoggedIn)
            AccountMenuItem(
              iconPath: UISvgs.menuLogout,
              title: 'Đăng xuất',
              onTap: onLogoutTap,
              showArrow: false,
              isLast: true,
              iconBackgroundColor: UIColors.red50,
            ),
        ],
      ),
    );
  }
}
