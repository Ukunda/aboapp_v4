import 'package:aboapp/core/routing/app_router.dart';
import 'package:aboapp/features/onboarding/presentation/widgets/onboarding_page_content_widget.dart';
import 'package:aboapp/features/onboarding/presentation/widgets/page_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aboapp/core/di/injection.dart'; 

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
    // Initialized here because context is needed for Theme.of(context)
    // Deferring full context-dependent initialization to build or didChangeDependencies might be safer for Theme access
    // For now, direct color usage is replaced for simplicity for this fix.
    // It's better to initialize this in didChangeDependencies if theme colors are used.
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize _onboardingPages here if they depend on Theme.of(context)
     _onboardingPages = [
      _OnboardingScreenData(
        titleKey: 'onboarding_page1_title',
        descriptionKey: 'onboarding_page1_desc',
        iconData: Icons.account_balance_wallet_outlined,
        iconColor: Theme.of(context).colorScheme.primary, 
      ),
      _OnboardingScreenData(
        titleKey: 'onboarding_page2_title',
        descriptionKey: 'onboarding_page2_desc', 
        iconData: Icons.add_circle_outline_rounded,
        iconColor: Colors.green.shade600,
      ),
      _OnboardingScreenData(
        titleKey: 'onboarding_page3_title',
        descriptionKey: 'onboarding_page3_desc',
        iconData: Icons.pie_chart_outline_rounded,
        iconColor: Colors.orange.shade700,
      ),
      _OnboardingScreenData(
        titleKey: 'onboarding_page4_title',
        descriptionKey: 'onboarding_page4_desc',
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
    final prefs = getIt<SharedPreferences>();
    await prefs.setBool('onboarding_complete', true);
    if (mounted) {
      context.goNamed(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            if (_currentPageIndex < _onboardingPages.length - 1)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                  child: TextButton(
                    onPressed: _completeOnboarding,
                    child: Text('Skip', style: TextStyle(color: theme.colorScheme.primary)), 
                  ),
                ),
              )
            else
              const SizedBox(height: 56), 

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
                    title: pageData.titleKey.replaceAll('_', ' ').split(' ').map((e) => e[0].toUpperCase() + e.substring(1)).join(' '), 
                    description: pageData.descriptionKey.replaceAll('_', ' ').split(' ').map((e) => e[0].toUpperCase() + e.substring(1)).join(' '), 
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
                inactiveColor: theme.colorScheme.onSurface.withOpacity(0.2), // Kept withOpacity for non-const dynamic color
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    if (_currentPageIndex < _onboardingPages.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _completeOnboarding();
                    }
                  },
                  child: Text(
                    _currentPageIndex < _onboardingPages.length - 1
                        ? 'Next' 
                        : 'Get Started', 
                    style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
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