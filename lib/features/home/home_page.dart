import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
                SliverToBoxAdapter(child: _buildVisionSection()),
                SliverToBoxAdapter(child: _buildImpactSection(impact)),
                SliverToBoxAdapter(child: _buildCTASection()),
                SliverToBoxAdapter(child: _buildFooter(ngoName)),
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
      backgroundColor: WebTheme.creamSurface.withValues(alpha: 0.9),
      leading: isMobile
          ? Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            )
          : null,
      title: Text(
        'YESAT Initiative',
        style: GoogleFonts.libreBaskerville(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: WebTheme.darkText,
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
              child: const Text('Donate Now'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(WidgetRef ref) {
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
          color: WebTheme.creamBackground,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(painter: _SubtlePatternPainter()),
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: 0.25,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?q=80&w=2000&auto=format&fit=crop',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(color: WebTheme.creamBackground);
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: WebTheme.creamBackground);
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
                            'Empowering Youth,\nIgniting Change.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.libreBaskerville(
                              fontSize: headlineFontSize,
                              height: 1.1,
                              fontWeight: FontWeight.bold,
                              color: WebTheme.darkText,
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 1500.ms)
                          .slideY(
                            begin: 0.3,
                            end: 0,
                            curve: Curves.easeOutExpo,
                          ),
                      const SizedBox(height: 24),
                      Text(
                            'Youth Empowerment through Sustainable Action for Transformation (YESAT) Initiative Uganda Ltd\nis a youth-led NGO dedicated to fostering leadership,\ninnovation, and sustainable development across communities.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: subtitleFontSize,
                              color: WebTheme.darkText.withValues(alpha: 0.7),
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 800.ms, duration: 1500.ms)
                          .slideY(
                            begin: 0.3,
                            end: 0,
                            curve: Curves.easeOutExpo,
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
                                  side: BorderSide(color: WebTheme.darkText),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Join Us',
                                  style: TextStyle(color: WebTheme.darkText),
                                ),
                              ),
                            ],
                          )
                          .animate()
                          .fadeIn(delay: 1600.ms, duration: 1500.ms)
                          .scale(
                            begin: const Offset(0.9, 0.9),
                            curve: Curves.easeOutBack,
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

  Widget _buildVisionSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: Colors.white.withValues(alpha: 0.3),
      child: Column(
        children: [
          Text(
            'Our Vision',
            style: GoogleFonts.libreBaskerville(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(duration: 1200.ms).slideY(begin: 0.5),
          const SizedBox(height: 24),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              'A vibrant, self-reliant, and empowered youth-led community where young people actively contribute to sustainable development.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 18,
                height: 1.6,
                color: WebTheme.darkText.withValues(alpha: 0.7),
              ),
            ),
          ).animate().fadeIn(delay: 400.ms),
          const SizedBox(height: 60),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              VisionCard(
                icon: Icons.lightbulb,
                title: 'Empowerment',
                description:
                    'Equipping youth with skills, knowledge, and opportunities.',
                delay: 200.ms,
              ),
              VisionCard(
                icon: Icons.eco,
                title: 'Sustainability',
                description:
                    'Action for long-term social and economic transformation.',
                delay: 400.ms,
              ),
              VisionCard(
                icon: Icons.volunteer_activism,
                title: 'Self-Reliance',
                description:
                    'Transforming communities into states of independent growth.',
                delay: 600.ms,
              ),
            ],
          ).animate().fadeIn(delay: (200).ms, duration: 800.ms).slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }

  Widget _buildImpactSection(Map<String, String> impact) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      color: WebTheme.darkText,
      child: Column(
        children: [
          Text(
            'Our Global Impact',
            style: GoogleFonts.libreBaskerville(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: WebTheme.creamBackground,
            ),
          ).animate().fadeIn(duration: 1200.ms),
          const SizedBox(height: 40),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 60,
            runSpacing: 40,
            children: [
              _ImpactStat(
                number: impact['volunteers']!,
                label: 'Volunteers',
                delay: 200.ms,
              ),
              _ImpactStat(
                number: impact['countries']!,
                label: 'Countries',
                delay: 400.ms,
              ),
              _ImpactStat(
                number: impact['livesAffected']!,
                label: 'Lives Affected',
                delay: 600.ms,
              ),
            ],
          ).animate().fadeIn(delay: 600.ms).scaleX(),
        ],
      ),
    );
  }

  Widget _buildCTASection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      decoration: BoxDecoration(
        color: WebTheme.accentGold.withValues(alpha: 0.1),
      ),
      child: Column(
        children: [
          Text(
            'Ready to make a difference?',
            style: GoogleFonts.libreBaskerville(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: WebTheme.darkText,
            ),
          ).animate().fadeIn().scale(begin: const Offset(0.9, 0.9)),
          const SizedBox(height: 24),
          Text(
            'Join thousands of young leaders in transforming their communities.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 18,
              color: WebTheme.darkText.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 24,
                  ),
                ),
                child: const Text('Get Involved Today'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(String title) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: WebTheme.creamSurface,
      child: Column(
        children: [
          Text(
            '© 2026 $title. All rights reserved.',
            style: TextStyle(color: WebTheme.darkText.withValues(alpha: 0.5)),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: () {}, child: const Text('Privacy Policy')),
              TextButton(
                onPressed: () {},
                child: const Text('Terms of Service'),
              ),
            ],
          ),
        ],
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

class VisionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Duration delay;

  const VisionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 300,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: WebTheme.creamSurface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, size: 48, color: WebTheme.accentGold),
              const SizedBox(height: 24),
              Text(
                title,
                style: GoogleFonts.libreBaskerville(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: WebTheme.darkText.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: delay, duration: 1200.ms)
        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad);
  }
}

class _ImpactStat extends StatelessWidget {
  final String number;
  final String label;
  final Duration delay;

  const _ImpactStat({
    required this.number,
    required this.label,
    this.delay = Duration.zero,
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
                color: WebTheme.creamBackground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label.toUpperCase(),
              style: GoogleFonts.inter(
                letterSpacing: 1.5,
                fontSize: 14,
                color: WebTheme.creamBackground.withValues(alpha: 0.6),
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(delay: delay, duration: 1500.ms)
        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutExpo);
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
