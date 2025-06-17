// lib/features/onboarding/presentation/screens/onboarding_screen.dart

import 'package:aboapp/core/routing/app_router.dart';
import 'package:aboapp/features/onboarding/presentation/widgets/onboarding_page_content_widget.dart';
import 'package:aboapp/features/onboarding/presentation/widgets/page_indicator_widget.dart';
import 'package:aboapp/features/onboarding/presentation/widgets/salary_onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aboapp/core/di/injection.dart';
import 'package:aboapp/core/utils/haptic_feedback.dart' as app_haptics;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenData {
  final String titleKey;
  final String descriptionKey;
  final IconData iconData;
  final Color iconColor;
  final Widget? customContent;

  _OnboardingScreenData({
    required this.titleKey,
    required this.descriptionKey,
    required this.iconData,
    required this.iconColor,
    this.customContent,
  });
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  final GlobalKey<SalaryOnboardingPageState> _salaryPageKey = GlobalKey();
  late final List<_OnboardingScreenData> _onboardingPages;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _onboardingPages = [
      _OnboardingScreenData(
        titleKey: 'Welcome to AboApp',
        descriptionKey: 'Easily manage all your subscriptions in one place.',
        iconData: Icons.account_balance_wallet_outlined,
        iconColor: Theme.of(context).colorScheme.primary,
      ),
      _OnboardingScreenData(
        titleKey: 'Add Subscriptions',
        descriptionKey:
            'Track your recurring payments and never miss a due date.',
        iconData: Icons.add_circle_outline_rounded,
        iconColor: Colors.green.shade600,
      ),
      _OnboardingScreenData(
        titleKey: 'Salary Insights',
        descriptionKey:
            'Enter your salary to see how much you spend on subscriptions.',
        iconData: Icons.insights_rounded,
        iconColor: Colors.blue.shade600,
        customContent: SalaryOnboardingPage(key: _salaryPageKey),
      ),
      _OnboardingScreenData(
        titleKey: 'Get Notified',
        descriptionKey: 'Receive reminders before your next billing date.',
        iconData: Icons.notifications_active_outlined,
        iconColor: Colors.purple.shade600,
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    app_haptics.HapticFeedback.lightImpact();
    final salaryPageState = _salaryPageKey.currentState;
    if (salaryPageState != null) {
      await salaryPageState.saveSettings();
    }
    final prefs = getIt<SharedPreferences>();
    await prefs.setBool('onboarding_complete', true);
    if (mounted) {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLastPage = _currentPageIndex == _onboardingPages.length - 1;

    return Scaffold(
      // FIX: Setting resizeToAvoidBottomInset to false prevents the UI from
      // squashing. The scroll views inside the pages will handle the keyboard.
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: Text(isLastPage ? 'Done' : 'Skip'),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingPages.length,
                onPageChanged: (index) {
                  app_haptics.HapticFeedback.selectionClick();
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final pageData = _onboardingPages[index];
                  // The SalaryOnboardingPage now has its own scroll view.
                  // Wrap other pages too for consistency and to prevent overflow.
                  if (pageData.customContent != null) {
                    return pageData.customContent!;
                  }
                  return SingleChildScrollView(
                    child: OnboardingPageContentWidget(
                      title: pageData.titleKey,
                      description: pageData.descriptionKey,
                      iconData: pageData.iconData,
                      iconColor: pageData.iconColor,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: PageIndicatorWidget(
                currentPageIndex: _currentPageIndex,
                pageCount: _onboardingPages.length,
                activeColor: theme.colorScheme.primary,
                inactiveColor: theme.colorScheme.onSurface.withAlpha(51), // 20%
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // FIX: Explicitly set background and foreground colors for contrast.
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    app_haptics.HapticFeedback.lightImpact();
                    if (!isLastPage) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _completeOnboarding();
                    }
                  },
                  child: Text(
                    isLastPage ? 'Get Started' : 'Next',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}