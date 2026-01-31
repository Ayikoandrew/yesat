import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yesat/core/widgets.dart';
import '../../core/theme.dart';
import '../../core/router.dart';
import '../../main.dart';
import 'providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ngoName = ref.watch(ngoNameProvider);
    final impact = ref.watch(ngoImpactCounterProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;

        return Scaffold(
          drawer: isMobile ? _buildDrawer(ref) : null,
          body: KeyedSubtree(
            key: ValueKey(ModalRoute.of(context)?.isCurrent ?? true),
            child: CustomScrollView(
              slivers: [
                _buildAppBar(ref, ngoName, isMobile),
                SliverToBoxAdapter(child: _buildHeroSection(ref)),
                SliverToBoxAdapter(
                  child: ScrollReveal(
                    builder: (context, isVisible) =>
                        _buildVisionSection(ref, isVisible),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ScrollReveal(
                    builder: (context, isVisible) =>
                        _buildImpactSection(ref, impact, isVisible),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ScrollReveal(
                    builder: (context, isVisible) =>
                        _buildCTASection(ref, isVisible),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ScrollReveal(
                    builder: (context, isVisible) =>
                        _buildFooter(ref, ngoName, isVisible),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBar(WidgetRef ref, String title, bool isMobile) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      backgroundColor: Colors.white.withValues(alpha: 0.9),
      leading: isMobile
          ? Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: WebTheme.primary),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            )
          : null,
      title: Text(
        'YESAT Initiative',
        style: GoogleFonts.libreBaskerville(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: WebTheme.primary,
        ),
      ),
      automaticallyImplyLeading: false,
      actions: isMobile
          ? null
          : [
              _NavBarItem(
                title: 'Impact',
                onTap: () => ref.read(coordinatorProvider).push(ImpactRoute()),
              ),
              _NavBarItem(
                title: 'About',
                onTap: () => ref.read(coordinatorProvider).push(AboutRoute()),
              ),
              _NavBarItem(
                title: 'Projects',
                onTap: () =>
                    ref.read(coordinatorProvider).push(ProjectsRoute()),
              ),
              _NavBarItem(title: 'Contact'),
              const SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Donate Now'),
                ),
              ),
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
            title: 'Impact',
            onTap: () {
              ref.read(coordinatorProvider).push(ImpactRoute());
            },
          ),
          _DrawerItem(
            title: 'About',
            onTap: () {
              ref.read(coordinatorProvider).push(AboutRoute());
            },
          ),
          _DrawerItem(
            title: 'Projects',
            onTap: () {
              ref.read(coordinatorProvider).push(ProjectsRoute());
            },
          ),
          _DrawerItem(title: 'Contact', onTap: () {}),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: WebTheme.accentGold,
                foregroundColor: Colors.white,
              ),
              child: const Text('Donate Now'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(WidgetRef ref) {
    final slogan = ref.watch(sloganProvider);
    final desc = ref.watch(descriptionProvider);
    final image = ref.watch(imageProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final headlineFontSize = screenWidth < 500
            ? 36.0
            : screenWidth < 800
            ? 48.0
            : 64.0;
        final subtitleFontSize = screenWidth < 500
            ? 14.0
            : screenWidth < 800
            ? 16.0
            : 18.0;

        return Container(
          height: 600,
          width: double.infinity,
          color: WebTheme.primary,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(painter: _SubtlePatternPainter()),
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: 0.25,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(color: WebTheme.primary);
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: WebTheme.primary);
                    },
                  ),
                ),
              ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                            slogan,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.libreBaskerville(
                              fontSize: headlineFontSize,
                              height: 1.1,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
                            desc,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: subtitleFontSize,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          )
                          .animate()
                          .fadeIn(
                            delay: 400.ms,
                            duration: WebTheme.animationDuration,
                          )
                          .slideY(
                            begin: WebTheme.animationSlide,
                            end: 0,
                            curve: WebTheme.animationCurve,
                          ),
                      const SizedBox(height: 48),
                      Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 16,
                            runSpacing: 16,
                            children: [
                              ElevatedButton(
                                onPressed: () => ref
                                    .read(coordinatorProvider)
                                    .push(ImpactRoute()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: WebTheme.accentGold,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 20,
                                  ),
                                ),
                                child: const Text('Our Mission'),
                              ),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Join Us',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                          .animate()
                          .fadeIn(
                            delay: 800.ms,
                            duration: WebTheme.animationDuration,
                          )
                          .slideY(
                            begin: WebTheme.animationSlide,
                            end: 0,
                            curve: WebTheme.animationCurve,
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVisionSection(WidgetRef ref, bool isVisible) {
    final vision = ref.watch(visionProvider);
    final visionDataList = ref.watch(visionCardProvider);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 40, height: 2, color: WebTheme.secondary),
              const SizedBox(width: 16),
              Text(
                'OUR VISION',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: WebTheme.secondary,
                ),
              ),
              const SizedBox(width: 16),
              Container(width: 40, height: 2, color: WebTheme.secondary),
            ],
          ).animate(target: isVisible ? 1 : 0).fadeIn(),
          const SizedBox(height: 16),
          Text(
                'A Future of Empowered Youth',
                style: GoogleFonts.libreBaskerville(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: WebTheme.primaryDark,
                ),
              )
              .animate(target: isVisible ? 1 : 0)
              .fadeIn(duration: WebTheme.animationDuration)
              .slideY(begin: 0.1, end: 0, curve: WebTheme.animationCurve),
          const SizedBox(height: 32),
          ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Text(
                  vision,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    height: 1.8,
                    color: WebTheme.darkText.withValues(alpha: 0.7),
                  ),
                ),
              )
              .animate(target: isVisible ? 1 : 0)
              .fadeIn(delay: 400.ms, duration: WebTheme.animationDuration),
          const SizedBox(height: 80),
          Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: visionDataList
                .map(
                  (data) => VisionCard(
                    icon: data.icon,
                    title: data.title,
                    description: data.description,
                    delay: data.delay,
                    isVisible: isVisible,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactSection(
    WidgetRef ref,
    Map<String, String> impact,
    bool isVisible,
  ) {
    final impactDataList = ref.watch(impactStatProvider(impact));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      color: WebTheme.primaryDark,
      child: Column(
        children: [
          Text(
                'Real Action, Real Impact',
                style: GoogleFonts.libreBaskerville(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
              .animate(target: isVisible ? 1 : 0)
              .fadeIn(duration: WebTheme.animationDuration),
          const SizedBox(height: 60),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 80,
            runSpacing: 50,
            children: impactDataList
                .map(
                  (data) => ImpactStat(
                    number: data.number,
                    label: data.label,
                    delay: data.delay,
                    isVisible: isVisible,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection(WidgetRef ref, bool isVisible) {
    final young = ref.watch(youngProvider);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 24),
      color: WebTheme.primaryLight,
      child: Column(
        children: [
          Text(
                'Ready to Transform Lives?',
                style: GoogleFonts.libreBaskerville(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: WebTheme.primaryDark,
                ),
              )
              .animate(target: isVisible ? 1 : 0)
              .fadeIn(duration: WebTheme.animationDuration),
          const SizedBox(height: 24),
          ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  young,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    height: 1.6,
                    color: WebTheme.darkText.withValues(alpha: 0.8),
                  ),
                ),
              )
              .animate(target: isVisible ? 1 : 0)
              .fadeIn(delay: 400.ms, duration: WebTheme.animationDuration),
          const SizedBox(height: 60),
          ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: WebTheme.accentGold,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 24,
                  ),
                ),
                child: const Text('Get Involved Today'),
              )
              .animate(target: isVisible ? 1 : 0)
              .fadeIn(delay: 800.ms, duration: WebTheme.animationDuration)
              .slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }
}

Widget _buildFooter(WidgetRef ref, String title, bool isVisible) {
  final providerTitle = ref.watch(footerProvider(title));
  return Container(
        padding: const EdgeInsets.all(40),
        color: WebTheme.primary,
        child: Column(
          children: [
            Text(providerTitle, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(foregroundColor: Colors.white70),
                  child: const Text('Privacy Policy'),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(foregroundColor: Colors.white70),
                  child: const Text('Terms of Service'),
                ),
              ],
            ),
          ],
        ),
      )
      .animate(target: isVisible ? 1 : 0)
      .fadeIn(duration: WebTheme.animationDuration)
      .slideY(begin: 0.1, end: 0, curve: WebTheme.animationCurve);
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const _NavBarItem({required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Center(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: WebTheme.darkText,
              ),
            ),
          ),
        ),
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
          color: WebTheme.primary,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}

class VisionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Duration delay;
  final bool isVisible;

  const VisionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.delay = Duration.zero,
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 320,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: WebTheme.grayBorder),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: WebTheme.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: WebTheme.primary),
              ),
              const SizedBox(height: 32),
              Text(
                title,
                style: GoogleFonts.libreBaskerville(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: WebTheme.primaryDark,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: GoogleFonts.inter(
                  height: 1.6,
                  fontSize: 15,
                  color: WebTheme.darkText.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        )
        .animate(target: isVisible ? 1 : 0)
        .fadeIn(delay: delay, duration: WebTheme.animationDuration)
        .slideY(
          begin: WebTheme.animationSlide,
          end: 0,
          curve: WebTheme.animationCurve,
        );
  }
}

class ImpactStat extends StatelessWidget {
  final String number;
  final String label;
  final Duration delay;
  final bool isVisible;

  const ImpactStat({
    super.key,
    required this.number,
    required this.label,
    this.delay = Duration.zero,
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Text(
              number,
              style: GoogleFonts.libreBaskerville(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label.toUpperCase(),
              style: GoogleFonts.inter(
                letterSpacing: 1.5,
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ],
        )
        .animate(target: isVisible ? 1 : 0)
        .fadeIn(delay: delay, duration: WebTheme.animationDuration)
        .slideY(
          begin: WebTheme.animationSlide,
          end: 0,
          curve: WebTheme.animationCurve,
        );
  }
}

class _SubtlePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = WebTheme.darkText.withValues(alpha: 0.03)
      ..strokeWidth = 1.0;

    const double gap = 40.0;

    for (double x = 0; x < size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
