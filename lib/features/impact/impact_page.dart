import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
          backgroundColor: AppTheme.creamBackground,
          drawer: isMobile ? _buildDrawer(ref) : null,
          body: KeyedSubtree(
            key: ValueKey(ModalRoute.of(context)?.isCurrent ?? true),
            child: CustomScrollView(
              slivers: [
                _buildAppBar(ref, isMobile),
                SliverToBoxAdapter(child: _buildHeader()),
                SliverToBoxAdapter(child: _buildObjectivesSection()),
                SliverToBoxAdapter(child: _buildTargetBeneficiariesSection()),
                SliverToBoxAdapter(child: _buildDetailedPillars()),
                SliverToBoxAdapter(child: _buildDataVisuals()),
                SliverToBoxAdapter(child: _buildFooter()),
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
      backgroundColor: AppTheme.creamSurface.withValues(alpha: 0.9),
      leading: isMobile
          ? null
          : IconButton(
              icon: const Icon(Icons.arrow_back, color: AppTheme.darkText),
              onPressed: () => ref.read(coordinatorProvider).pop(),
            ),
      title: Image.asset('assets/images/YESAT_Logo.png', height: 40),
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
      backgroundColor: AppTheme.creamBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppTheme.creamSurface),
            child: Center(
              child: Image.asset(
                'assets/images/YESAT_Logo.png',
                height: 60,
                fit: BoxFit.contain,
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
      decoration: BoxDecoration(color: AppTheme.creamSurface),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.accentGold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'OUR STRATEGY',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: AppTheme.accentGold,
              ),
            ),
          ).animate().fadeIn().scale(),
          const SizedBox(height: 32),
          Text(
            'Strategic Action for\nSustainable Transformation',
            textAlign: TextAlign.center,
            style: GoogleFonts.libreBaskerville(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              height: 1.1,
              color: AppTheme.darkText,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
          const SizedBox(height: 32),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              'The main objective of YESAT Initiative Uganda Ltd is to mobilize and empower youth to provide essential services that improve social welfare, economic resilience, and environmental sustainability within communities.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 20,
                color: AppTheme.darkText.withValues(alpha: 0.7),
              ),
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
        ],
      ),
    );
  }

  Widget _buildObjectivesSection() {
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
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: objectives
                .map((obj) => _ObjectiveCard(title: obj))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTargetBeneficiariesSection() {
    final beneficiaries = [
      {'title': 'Youth and adolescents', 'icon': Icons.school},
      {'title': 'Women and girls', 'icon': Icons.face_retouching_natural},
      {'title': 'Children', 'icon': Icons.child_care},
      {'title': 'Vulnerable members', 'icon': Icons.volunteer_activism},
      {'title': 'Refugees', 'icon': Icons.public},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: AppTheme.creamSurface,
      child: Column(
        children: [
          Text(
            'Target Beneficiaries',
            style: GoogleFonts.libreBaskerville(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Serving vulnerable groups within our communities.',
            style: GoogleFonts.inter(
              fontSize: 18,
              color: AppTheme.darkText.withValues(alpha: 0.6),
            ),
          ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedPillars() {
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
    );
  }

  Widget _buildDataVisuals() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      color: AppTheme.darkText,
      child: Column(
        children: [
          Text(
            'Growth Over Time',
            style: GoogleFonts.libreBaskerville(
              fontSize: 32,
              color: AppTheme.creamBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 48),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _ChartBar(height: 100, label: '2021'),
                _ChartBar(height: 160, label: '2022'),
                _ChartBar(height: 240, label: '2023'),
                _ChartBar(height: 350, label: '2024 (Proj.)'),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'Beneficiary Growth (Thousands)',
            style: GoogleFonts.inter(
              color: AppTheme.creamBackground.withValues(alpha: 0.5),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      color: AppTheme.creamSurface,
      child: Center(
        child: Text(
          '© 2026 YESAT Initiative Uganda Ltd.',
          style: TextStyle(color: AppTheme.darkText.withValues(alpha: 0.5)),
        ),
      ),
    );
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
        color: AppTheme.creamBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.accentGold.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: AppTheme.accentGold),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppTheme.darkText,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: 0.1);
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
            color: AppTheme.creamBackground,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
              ),
            ],
          ),
          child: Icon(icon, color: AppTheme.accentGold, size: 32),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkText,
          ),
        ),
      ],
    ).animate().fadeIn().scale(delay: 300.ms);
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
        border: Border.all(color: AppTheme.darkText.withValues(alpha: 0.05)),
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
              color: AppTheme.accentGold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            desc,
            style: TextStyle(
              color: AppTheme.darkText.withValues(alpha: 0.7),
              height: 1.6,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.1);
  }
}

class _ChartBar extends StatelessWidget {
  final double height;
  final String label;

  const _ChartBar({required this.height, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: height,
          decoration: BoxDecoration(
            color: AppTheme.accentGold,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
        ).animate().scaleY(
          begin: 0,
          end: 1,
          duration: 1500.ms,
          curve: Curves.easeOutExpo,
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: TextStyle(color: AppTheme.creamBackground, fontSize: 13),
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
        style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w600),
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
          color: AppTheme.darkText,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
