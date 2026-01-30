import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yesat/features/about/about_providers.dart';
import 'package:yesat/core/widgets.dart';
import '../../core/router.dart';
import '../../core/theme.dart';
import '../../main.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;

        return Scaffold(
          drawer: isMobile ? _buildDrawer(ref) : null,
          body: KeyedSubtree(
            key: ValueKey(ModalRoute.of(context)?.isCurrent ?? true),
            child: CustomScrollView(
              slivers: [
                _buildAppBar(context, ref, isMobile),
                SliverToBoxAdapter(child: _buildHeaderSection(ref)),
                SliverToBoxAdapter(
                  child: ScrollReveal(
                    builder: (context, isVisible) =>
                        _buildStorySection(ref, isVisible),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ScrollReveal(
                    builder: (context, isVisible) =>
                        _buildVisionMissionSection(ref, isVisible),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ScrollReveal(
                    builder: (context, isVisible) =>
                        _buildCoreValuesSection(ref, isVisible),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ScrollReveal(
                    builder: (context, isVisible) =>
                        _buildTeamSection(ref, isVisible),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ScrollReveal(
                    builder: (context, isVisible) =>
                        _buildTransparencySection(isVisible),
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

  Widget _buildAppBar(BuildContext context, WidgetRef ref, bool isMobile) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      backgroundColor: WebTheme.creamSurface.withValues(alpha: 0.9),
      leading: isMobile
          ? null
          : IconButton(
              icon: const Icon(Icons.arrow_back, color: WebTheme.darkText),
              onPressed: () => ref.read(coordinatorProvider).pop(),
            ),
      title: Text(
        'YESAT Initiative',
        style: GoogleFonts.libreBaskerville(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: WebTheme.darkText,
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
                title: 'Impact',
                onTap: () => ref.read(coordinatorProvider).push(ImpactRoute()),
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
      backgroundColor: WebTheme.creamBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: WebTheme.creamSurface),
            child: Center(
              child: Text(
                'YESAT',
                style: GoogleFonts.libreBaskerville(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: WebTheme.darkText,
                ),
              ),
            ),
          ),
          _DrawerItem(
            title: 'Home',
            onTap: () {
              ref.read(coordinatorProvider).push(HomeRoute());
            },
          ),
          _DrawerItem(
            title: 'Impact',
            onTap: () {
              ref.read(coordinatorProvider).push(ImpactRoute());
            },
          ),
          _DrawerItem(
            title: 'Projects',
            onTap: () {
              ref.read(coordinatorProvider).push(ProjectsRoute());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(WidgetRef ref) {
    final company = ref.watch(companyProvider);
    final vibrant = ref.watch(vibrantProvider);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
      color: WebTheme.creamBackground,
      child: Column(
        children: [
          Text(
                company,
                textAlign: TextAlign.center,
                style: GoogleFonts.libreBaskerville(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: WebTheme.darkText,
                ),
              )
              .animate()
              .fadeIn(duration: WebTheme.animationDuration)
              .slideY(
                begin: WebTheme.animationSlide,
                end: 0,
                curve: WebTheme.animationCurve,
              ),
          const SizedBox(height: 24),
          Text(
                vibrant,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  letterSpacing: 4,
                  fontWeight: FontWeight.w300,
                  color: WebTheme.accentGold,
                ),
              )
              .animate()
              .fadeIn(delay: 400.ms, duration: WebTheme.animationDuration)
              .slideY(
                begin: WebTheme.animationSlide,
                end: 0,
                curve: WebTheme.animationCurve,
              ),
          const SizedBox(height: 24),
          Container(width: 80, height: 4, color: WebTheme.accentGold)
              .animate()
              .fadeIn(delay: 800.ms, duration: WebTheme.animationDuration)
              .scaleX(curve: WebTheme.animationCurve),
        ],
      ),
    );
  }

  Widget _buildStorySection(WidgetRef ref, bool isVisible) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMobile)
                    Expanded(flex: 3, child: _buildStoryText(ref, isVisible))
                  else
                    _buildStoryText(ref, isVisible),
                  SizedBox(width: isMobile ? 0 : 80, height: isMobile ? 60 : 0),
                  if (!isMobile)
                    Expanded(flex: 2, child: _buildStoryImage(isVisible))
                  else
                    _buildStoryImage(isVisible),
                ],
              ),
              const SizedBox(height: 60),
              _buildDetailedBackground(ref, isVisible),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStoryText(WidgetRef ref, bool isVisible) {
    final background = ref.watch(vibrantProvider);
    final history = ref.watch(historyProvider);
    final organization = ref.watch(organizationProvider);
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              background,
              style: GoogleFonts.libreBaskerville(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              history,
              style: GoogleFonts.inter(
                fontSize: 18,
                height: 1.6,
                color: WebTheme.darkText.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              organization,
              style: GoogleFonts.inter(
                fontSize: 18,
                height: 1.6,
                color: WebTheme.darkText.withValues(alpha: 0.8),
              ),
            ),
          ],
        )
        .animate(target: isVisible ? 1 : 0)
        .fadeIn(duration: WebTheme.animationDuration)
        .slideX(begin: -0.1, end: 0, curve: WebTheme.animationCurve);
  }

  Widget _buildDetailedBackground(WidgetRef ref, bool isVisible) {
    final detail = ref.watch(detailProvider);
    final mission = ref.watch(missionProvider);
    final mission2 = ref.watch(missionProvider2);
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              detail,
              style: GoogleFonts.inter(
                fontSize: 18,
                height: 1.6,
                color: WebTheme.darkText.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              mission,
              style: GoogleFonts.inter(
                fontSize: 18,
                height: 1.6,
                color: WebTheme.darkText.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              mission2,
              style: GoogleFonts.inter(
                fontSize: 18,
                height: 1.6,
                color: WebTheme.darkText.withValues(alpha: 0.8),
              ),
            ),
          ],
        )
        .animate(target: isVisible ? 1 : 0)
        .fadeIn(delay: 400.ms, duration: WebTheme.animationDuration);
  }

  Widget _buildVisionMissionSection(WidgetRef ref, bool isVisible) {
    final vision = ref.watch(visionProvider);
    final mission = ref.watch(missionVProvider);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: WebTheme.creamSurface,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 700;
          return Column(
            children: [
              Flex(
                direction: isSmall ? Axis.vertical : Axis.horizontal,
                children: [
                  Expanded(
                    flex: isSmall ? 0 : 1,
                    child: _buildVisionMissionCard(
                      title: 'Vision',
                      content: vision,
                      icon: Icons.lightbulb_outline,
                      isVisible: isVisible,
                    ),
                  ),
                  const SizedBox(width: 40, height: 40),
                  Expanded(
                    flex: isSmall ? 0 : 1,
                    child: _buildVisionMissionCard(
                      title: 'Mission',
                      content: mission,
                      icon: Icons.rocket_launch_outlined,
                      isVisible: isVisible,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildVisionMissionCard({
    required String title,
    required String content,
    required IconData icon,
    required bool isVisible,
  }) {
    return Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: WebTheme.creamBackground,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: WebTheme.accentGold, size: 40),
              const SizedBox(height: 24),
              Text(
                title,
                style: GoogleFonts.libreBaskerville(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                content,
                style: GoogleFonts.inter(
                  fontSize: 17,
                  height: 1.6,
                  color: WebTheme.darkText.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        )
        .animate(target: isVisible ? 1 : 0)
        .fadeIn(duration: WebTheme.animationDuration)
        .slideY(
          begin: WebTheme.animationSlide,
          end: 0,
          curve: WebTheme.animationCurve,
        );
  }

  Widget _buildCoreValuesSection(WidgetRef ref, bool isVisible) {
    final values = ref.watch(valuesProvider);
    final title = ref.watch(coreTitleProvider);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        children: [
          Text(
                title,
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
          const SizedBox(height: 60),
          Wrap(
                spacing: 30,
                runSpacing: 30,
                alignment: WrapAlignment.center,
                children: values
                    .map(
                      (v) => _CoreValueCard(
                        title: v['title'] as String,
                        icon: v['icon'] as IconData,
                      ),
                    )
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

  Widget _buildStoryImage(bool isVisible) {
    return Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            color: WebTheme.creamSurface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.history_edu,
            size: 100,
            color: WebTheme.accentGold,
          ),
        )
        .animate(target: isVisible ? 1 : 0)
        .fadeIn(duration: WebTheme.animationDuration)
        .scale(curve: WebTheme.animationCurve);
  }

  Widget _buildTeamSection(WidgetRef ref, bool isVisible) {
    final youth = ref.watch(youthProvider);
    final leaders = ref.watch(teamProvider);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: WebTheme.creamSurface,
      child: Column(
        children: [
          Text(
                youth,
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
          const SizedBox(height: 60),
          Wrap(
                spacing: 40,
                runSpacing: 40,
                alignment: WrapAlignment.center,
                children: leaders,
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

  Widget _buildTransparencySection(bool isVisible) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Container(
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 60 : 100,
                horizontal: isMobile ? 20 : 40,
              ),
              child: Card(
                color: WebTheme.darkText,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? 30.0 : 60.0),
                  child: Column(
                    children: [
                      Text(
                        'Transparency & Governance',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.libreBaskerville(
                          fontSize: isMobile ? 24 : 32,
                          fontWeight: FontWeight.bold,
                          color: WebTheme.creamBackground,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'We hold ourselves to the highest standards of accountability. Funders can access our annual reports and independent audits at any time.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: isMobile ? 16 : 18,
                          color: WebTheme.creamBackground.withValues(
                            alpha: 0.8,
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 20,
                        runSpacing: 20,
                        children: [
                          _TransparencyButton(label: '2025 Annual Report'),
                          _TransparencyButton(label: 'Board Structure'),
                          _TransparencyButton(label: 'Financial Audits'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
            .animate(target: isVisible ? 1 : 0)
            .fadeIn(duration: WebTheme.animationDuration)
            .slideY(
              begin: WebTheme.animationSlide,
              end: 0,
              curve: WebTheme.animationCurve,
            );
      },
    );
  }

  Widget _buildFooter(bool isVisible) {
    return Container(
          padding: const EdgeInsets.all(40),
          color: WebTheme.creamSurface,
          child: Center(
            child: Text(
              '© 2026 YESAT Initiative Uganda Ltd. Empowering the youth today.',
              style: TextStyle(color: WebTheme.darkText.withValues(alpha: 0.5)),
            ),
          ),
        )
        .animate(target: isVisible ? 1 : 0)
        .fadeIn(duration: WebTheme.animationDuration);
  }
}

class TeamMemberCard extends StatelessWidget {
  final String name;
  final String role;
  final String profile;
  final String strengths;
  final String quote;

  const TeamMemberCard({
    super.key,
    required this.name,
    required this.role,
    required this.profile,
    required this.strengths,
    required this.quote,
  });

  void _showDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: WebTheme.creamBackground,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: WebTheme.accentGold.withValues(alpha: 0.1),
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: WebTheme.accentGold,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.libreBaskerville(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      role.toUpperCase(),
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: WebTheme.accentGold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 32),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          height: 1.8,
                          color: WebTheme.darkText.withValues(alpha: 0.8),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        strengths,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                          color: WebTheme.darkText,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: WebTheme.accentGold.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: WebTheme.accentGold.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Text(
                          '“$quote”',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.libreBaskerville(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: WebTheme.darkText,
                          ),
                        ),
                      ),
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDetails(context),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: WebTheme.creamBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: WebTheme.accentGold.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: WebTheme.accentGold.withValues(alpha: 0.1),
              child: const Icon(
                Icons.person,
                size: 40,
                color: WebTheme.accentGold,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              name,
              textAlign: TextAlign.center,
              style: GoogleFonts.libreBaskerville(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              role.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: WebTheme.accentGold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '“$quote”',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.libreBaskerville(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: WebTheme.darkText.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Read Profile →',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: WebTheme.accentGold,
              ),
            ),
          ],
        ),
      ),
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

class _CoreValueCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _CoreValueCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: WebTheme.creamSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: WebTheme.accentGold.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: WebTheme.accentGold, size: 32),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: WebTheme.darkText,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransparencyButton extends StatelessWidget {
  final String label;
  const _TransparencyButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: WebTheme.creamBackground),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        foregroundColor: WebTheme.creamBackground,
      ),
      child: Text(label),
    );
  }
}
