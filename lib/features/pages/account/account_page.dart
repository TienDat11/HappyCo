import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:happyco/core/services/dialog_service.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/dialogs/dialog_type.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/features/app_router.gr.dart';
import 'package:happyco/features/auth/bloc/auth_bloc.dart';
import 'package:happyco/features/pages/account/widgets/account_header.dart';
import 'package:happyco/features/pages/account/widgets/account_menu_card.dart';
import 'package:happyco/features/pages/account/widgets/account_profile_section.dart';

/// Account Page
///
/// Displays user account information and menu options.
/// Two states: logged in (shows user info + full menu) and not logged in.
///
/// Architecture:
/// - AuthBloc is the source of truth for auth state and user data
/// - Logout is dispatched to AuthBloc via OnLogout event
@RoutePage()
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = GetIt.I<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authBloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: _onAuthStateChanged,
        child: Scaffold(
          backgroundColor: UIColors.background,
          body: Column(
            children: [
              const AccountHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, authState) {
                          final isLoggedIn = authState is AuthAuthenticated;
                          final user = isLoggedIn
                              ? (authState as AuthAuthenticated).user
                              : null;
                          return AccountProfileSection(
                            user: user,
                            isLoggedIn: isLoggedIn,
                            onLoginTap: _showLoginDialog,
                          );
                        },
                      ),
                      SizedBox(height: UISizes.height.h16),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, authState) {
                          final isLoggedIn = authState is AuthAuthenticated;
                          return AccountMenuCard(
                            isLoggedIn: isLoggedIn,
                            onProfileTap: () => _showComingSoon(),
                            onOrdersTap: () => _showComingSoon(),
                            onAddressTap: () => _showComingSoon(),
                            onVoucherTap: () => _showComingSoon(),
                            onPolicyTap: () => _showComingSoon(),
                            onFaqTap: () => _showComingSoon(),
                            onLanguageTap: () => _showComingSoon(),
                            onLogoutTap: _onLogoutTap,
                          );
                        },
                      ),
                      SizedBox(height: UISizes.height.h24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onAuthStateChanged(BuildContext context, AuthState state) {
    if (state is AuthUnauthenticated) {
      context.router.replaceAll([const SplashRoute()]);
    }
  }

  void _showLoginDialog() {
    GetIt.I<DialogService>().show(DialogType.login);
  }

  void _showComingSoon() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: UIText(
          title: 'Tính năng đang phát triển',
          titleColor: UIColors.white,
        ),
        backgroundColor: UIColors.gray700,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(UISizes.width.w16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UISizes.square.r8),
        ),
      ),
    );
  }

  void _onLogoutTap() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: UIText(title: 'Đăng xuất'),
        content: UIText(title: 'Bạn có chắc muốn đăng xuất?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: UIText(
              title: 'Huỷ',
              titleColor: UIColors.gray500,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _authBloc.add(OnLogout());
            },
            child: UIText(
              title: 'Đăng xuất',
              titleColor: UIColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
