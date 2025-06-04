import 'package:aboapp/core/localization/app_localizations.dart';
import 'package:aboapp/core/routing/app_router.dart';
import 'package:aboapp/features/onboarding/presentation/widgets/onboarding_page_content_widget.dart';
import 'package:aboapp/features/onboarding/presentation/widgets/page_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aboapp/core/di/injection.dart'; // For GetIt to access SharedPreferences
import 'package:aboapp/core/theme/app_colors.dart'; // For distinct icon colors if needed

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

// Private class to hold data for each onboarding page
class _OnboardingScreenData {
  final String titleKey;
  final String descriptionKey;
  final IconData iconData;
  final Color iconColor;

  _OnboardingScreenData({
    required this.titleKey,
    required this.descriptionKey,
    required this.iconData,
    required this.iconColor,
  });
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  late final List<_OnboardingScreenData> _onboardingPages;

  @override
  void initState() {
    super.initState();
    // It's better to initialize _onboardingPages here or in didChangeDependencies
    // if they depend on Theme.of(context) which is not available in initState directly without a context.
    // However, since AppColors are static, we can initialize here.
    _onboardingPages = [
      _OnboardingScreenData(
        titleKey: 'onboarding_page1_title',
        descriptionKey: 'onboarding_page1_desc',
        iconData: Icons.account_balance_wallet_outlined,
        iconColor: AppColors.primary, // Using AppColors
      ),
      _OnboardingScreenData(
        titleKey: 'onboarding_page2_title',
        descriptionKey: 'onboarding_page2_desc',
        iconData: Icons.add_circle_outline_rounded,
        iconColor: AppColors.success, // Using AppColors
      ),
      _OnboardingScreenData(
        titleKey: 'onboarding_page3_title',
        descriptionKey: 'onboarding_page3_desc',
        iconData: Icons.pie_chart_outline_rounded,
        iconColor: AppColors.warning, // Using AppColors
      ),
      _OnboardingScreenData(
        titleKey: 'onboarding_page4_title',
        descriptionKey: 'onboarding_page4_desc',
        iconData: Icons.notifications_active_outlined,
        iconColor: AppColors.info, // Using AppColors
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = getIt<SharedPreferences>();
    await prefs.setBool('onboarding_complete', true);
    if (mounted) {
      context.goNamed(AppRoutes.home); // Navigate using GoRouter
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Skip Button - only show if not on the last page
            if (_currentPageIndex < _onboardingPages.length - 1)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                  child: TextButton(
                    onPressed: _completeOnboarding,
                    child: Text(
                      localizations.translate('onboarding_skip_button'),
                      style: TextStyle(color: theme.colorScheme.primary),
                    ),
                  ),
                ),
              )
            else
              // Maintain space even if skip button is not visible
              const SizedBox(height: 56.0), 

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingPages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final pageData = _onboardingPages[index];
                  return OnboardingPageContentWidget(
                    title: localizations.translate(pageData.titleKey),
                    description: localizations.translate(pageData.descriptionKey),
                    iconData: pageData.iconData,
                    iconColor: pageData.iconColor,
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
                inactiveColor: theme.colorScheme.onSurface.withOpacity(0.2),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: SizedBox(
                width: double.infinity, // Make button full width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0), // More rounded
                    ),
                    // backgroundColor & foregroundColor will be inherited from ElevatedButtonTheme
                  ),
                  onPressed: () {
                    if (_currentPageIndex < _onboardingPages.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOutCubic, // Smoother curve
                      );
                    } else {
                      _completeOnboarding();
                    }
                  },
                  child: Text(
                    _currentPageIndex < _onboardingPages.length - 1
                        ? localizations.translate('onboarding_next_button')
                        : localizations.translate('onboarding_get_started_button'),
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      // color: theme.colorScheme.onPrimary, // Ensure text color contrasts with button
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0), // Consistent bottom padding
          ],
        ),
      ),
    );
  }
}