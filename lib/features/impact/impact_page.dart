import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yesat/core/widgets.dart';
import '../../core/theme.dart';
import '../../core/router.dart';
import '../../main.dart';

class ImpactPage extends ConsumerWidget {
  const ImpactPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          drawer: isMobile ? _buildDrawer(ref) : null,
          body: KeyedSubtree(
            key: ValueKey(ModalRoute.of(context)?.isCurrent ?? true),
            child: CustomScrollView(
              slivers: [
                _buildAppBar(ref, isMobile),
                SliverToBoxAdapter(child: _buildHeader()),
                SliverToBoxAdapter(
                  child: ScrollReveal(
                    builder: (context, isVisible) =>
                        _buildObjectivesSection(isVisible),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ScrollReveal(
                    builder: (context, isVisible) =>
                        _buildTargetBeneficiariesSection(isVisible),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ScrollReveal(
                    builder: (context, isVisible) =>
                        _buildDetailedPillars(isVisible),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ScrollReveal(
                    builder: (context, isVisible) =>
                        _buildDataVisuals(isVisible),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ScrollReveal(
                    builder: (context, isVisible) => _buildFooter(isVisible),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBar(WidgetRef ref, bool isMobile) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      backgroundColor: Colors.white.withValues(alpha: 0.9),
      leading: isMobile
          ? null
          : IconButton(
              icon: const Icon(Icons.arrow_back, color: WebTheme.primary),
              onPressed: () => ref.read(coordinatorProvider).pop(),
            ),
      title: Text(
        'YESAT Initiative',
        style: GoogleFonts.libreBaskerville(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: WebTheme.primary,
        ),
      ),
      actions: isMobile
          ? null
          : [
              _NavBarItem(
                title: 'Home',
                onTap: () => ref.read(coordinatorProvider).push(HomeRoute()),
              ),
              _NavBarItem(
                title: 'Projects',
                onTap: () =>
                    ref.read(coordinatorProvider).push(ProjectsRoute()),
              ),
              const SizedBox(width: 20),
            ],
    );
  }

  Widget _buildDrawer(WidgetRef ref) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: WebTheme.primary),
            child: Center(
              child: Text(
                'YESAT',
                style: GoogleFonts.libreBaskerville(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          _DrawerItem(
            title: 'Home',
            onTap: () => ref.read(coordinatorProvider).push(HomeRoute()),
          ),
          _DrawerItem(
            title: 'Projects',
            onTap: () => ref.read(coordinatorProvider).push(ProjectsRoute()),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 24),
      decoration: const BoxDecoration(color: WebTheme.primaryLight),
      child: Column(
        children: [
          Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: WebTheme.secondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'OUR STRATEGY',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: WebTheme.secondary,
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: WebTheme.animationDuration)
              .scale(curve: WebTheme.animationCurve),
          const SizedBox(height: 32),
          Text(
                'Strategic Action for\nSustainable Transformation',
                textAlign: TextAlign.center,
                style: GoogleFonts.libreBaskerville(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                  color: WebTheme.darkText,
                ),
              )
              .animate()
              .fadeIn(delay: 400.ms, duration: WebTheme.animationDuration)
              .slideY(
                begin: WebTheme.animationSlide,
                end: 0,
                curve: WebTheme.animationCurve,
              ),
          const SizedBox(height: 32),
          ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Text(
                  'The main objective of YESAT Initiative Uganda Ltd is to mobilize and empower youth to provide essential services that improve social welfare, economic resilience, and environmental sustainability within communities.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    color: WebTheme.darkText.withValues(alpha: 0.7),
                  ),
                ),
              )
              .animate()
              .fadeIn(delay: 800.ms, duration: WebTheme.animationDuration)
              .slideY(
                begin: WebTheme.animationSlide,
                end: 0,
                curve: WebTheme.animationCurve,
              ),
        ],
      ),
    );
  }

  Widget _buildObjectivesSection(bool isVisible) {
    final objectives = [
      'Youth empowerment and skills development',
      'Community sensitization and awareness',
      'Health promotion and social wellbeing',
      'Environmental conservation and climate action',
      'Livelihood support and entrepreneurship',
      'Civic engagement and community participation',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        children: [
          Text(
                'Our Key Objectives',
                style: GoogleFonts.libreBaskerville(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              )
              .animate(target: isVisible ? 1 : 0)
              .fadeIn(duration: WebTheme.animationDuration)
              .slideY(
                begin: WebTheme.animationSlide,
                end: 0,
                curve: WebTheme.animationCurve,
              ),
          const SizedBox(height: 48),
          Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: objectives
                    .map((obj) => _ObjectiveCard(title: obj))
                    .toList(),
              )
              .animate(target: isVisible ? 1 : 0)
              .fadeIn(delay: 400.ms, duration: WebTheme.animationDuration)
              .slideY(
                begin: WebTheme.animationSlide,
                end: 0,
                curve: WebTheme.animationCurve,
              ),
        ],
      ),
    );
  }

  Widget _buildTargetBeneficiariesSection(bool isVisible) {
    final beneficiaries = [
      {'title': 'Youth and adolescents', 'icon': Icons.school},
      {'title': 'Women and girls', 'icon': Icons.face_retouching_natural},
      {'title': 'Children', 'icon': Icons.child_care},
      {'title': 'Vulnerable members', 'icon': Icons.volunteer_activism},
      {'title': 'Refugees', 'icon': Icons.public},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: WebTheme.secondaryLight,
      child: Column(
        children: [
          Text(
                'Target Beneficiaries',
                style: GoogleFonts.libreBaskerville(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: WebTheme.darkText,
                ),
              )
              .animate(target: isVisible ? 1 : 0)
              .fadeIn(duration: WebTheme.animationDuration)
              .slideY(
                begin: WebTheme.animationSlide,
                end: 0,
                curve: WebTheme.animationCurve,
              ),
          const SizedBox(height: 24),
          Text(
                'Serving vulnerable groups within our communities.',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  color: WebTheme.darkText.withValues(alpha: 0.6),
                ),
              )
              .animate(target: isVisible ? 1 : 0)
              .fadeIn(delay: 400.ms, duration: WebTheme.animationDuration),
          const SizedBox(height: 60),
          Wrap(
                spacing: 40,
                runSpacing: 40,
                alignment: WrapAlignment.center,
                children: beneficiaries
                    .map(
                      (b) => _BeneficiaryIcon(
                        title: b['title'] as String,
                        icon: b['icon'] as IconData,
                      ),
                    )
                    .toList(),
              )
              .animate(target: isVisible ? 1 : 0)
              .fadeIn(delay: 800.ms, duration: WebTheme.animationDuration)
              .slideY(
                begin: WebTheme.animationSlide,
                end: 0,
                curve: WebTheme.animationCurve,
              ),
        ],
      ),
    );
  }

  Widget _buildDetailedPillars(bool isVisible) {
    return Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
          child: Center(
            child: Wrap(
              spacing: 40,
              runSpacing: 40,
              alignment: WrapAlignment.center,
              children: [
                _PillarDetail(
                  title: 'Youth Skilling',
                  stats: '2,500+ Graduated',
                  desc:
                      'Vocational training in digital tools, tailoring, and sustainable farming methods.',
                ),
                _PillarDetail(
                  title: 'Environment',
                  stats: '15k Trees Planted',
                  desc:
                      'Active reforestation projects and community-led waste management programs.',
                ),
                _PillarDetail(
                  title: 'Community',
                  stats: '12 Districts Reached',
                  desc:
                      'Infrastructure support for clean water and local leadership development.',
                ),
              ],
            ),
          ),
        )
        .animate(target: isVisible ? 1 : 0)
        .fadeIn(duration: WebTheme.animationDuration)
        .slideY(begin: 0.1, end: 0, curve: WebTheme.animationCurve);
  }

  Widget _buildDataVisuals(bool isVisible) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      color: WebTheme.primaryLight,
      child: Column(
        children: [
          Text(
                'Growth Over Time',
                style: GoogleFonts.libreBaskerville(
                  fontSize: 32,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              )
              .animate(target: isVisible ? 1 : 0)
              .fadeIn(duration: WebTheme.animationDuration),
          const SizedBox(height: 48),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _ChartBar(height: 100, label: '2021', isVisible: isVisible),
                _ChartBar(height: 160, label: '2022', isVisible: isVisible),
                _ChartBar(height: 240, label: '2023', isVisible: isVisible),
                _ChartBar(
                  height: 350,
                  label: '2024 (Proj.)',
                  isVisible: isVisible,
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Text(
                'Beneficiary Growth (Thousands)',
                style: GoogleFonts.inter(
                  color: Colors.black87.withValues(alpha: 0.5),
                  fontSize: 14,
                ),
              )
              .animate(target: isVisible ? 1 : 0)
              .fadeIn(delay: 1000.ms, duration: WebTheme.animationDuration),
        ],
      ),
    );
  }

  Widget _buildFooter(bool isVisible) {
    return Container(
          padding: const EdgeInsets.symmetric(vertical: 60),
          color: WebTheme.primaryDark,
          child: Center(
            child: Text(
              '© 2026 YESAT Initiative Uganda Ltd. Empowering the youth today.',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
            ),
          ),
        )
        .animate(target: isVisible ? 1 : 0)
        .fadeIn(duration: WebTheme.animationDuration);
  }
}

class _ObjectiveCard extends StatelessWidget {
  final String title;

  const _ObjectiveCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: WebTheme.grayBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: WebTheme.secondary),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: WebTheme.darkText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BeneficiaryIcon extends StatelessWidget {
  final String title;
  final IconData icon;

  const _BeneficiaryIcon({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: WebTheme.primaryLight,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
              ),
            ],
          ),
          child: Icon(icon, color: WebTheme.primary, size: 32),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: WebTheme.darkText,
          ),
        ),
      ],
    );
  }
}

class _PillarDetail extends StatelessWidget {
  final String title;
  final String stats;
  final String desc;

  const _PillarDetail({
    required this.title,
    required this.stats,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: WebTheme.darkText.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.libreBaskerville(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            stats,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: WebTheme.accentGold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            desc,
            style: TextStyle(
              color: WebTheme.darkText.withValues(alpha: 0.7),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartBar extends StatelessWidget {
  final double height;
  final String label;
  final bool isVisible;

  const _ChartBar({
    required this.height,
    required this.label,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
              width: 60,
              height: height,
              decoration: BoxDecoration(
                color: WebTheme.accentGold,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
              ),
            )
            .animate(target: isVisible ? 1 : 0)
            .scaleY(
              begin: 0,
              end: 1,
              duration: WebTheme.animationDuration,
              curve: WebTheme.animationCurve,
            ),
        const SizedBox(height: 12),
        Text(
          label,
          style: TextStyle(
            color: Colors.black54.withValues(alpha: 0.7),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const _NavBarItem({required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: TextStyle(color: WebTheme.darkText, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: WebTheme.darkText,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
