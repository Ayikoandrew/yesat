import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/router.dart';
import '../../main.dart';

class ProjectsPage extends ConsumerWidget {
  const ProjectsPage({super.key});

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
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 40,
                  ),
                  sliver: _buildProjectGrid(),
                ),
                SliverToBoxAdapter(child: _buildSuccessStories()),
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
              icon: const Icon(Icons.arrow_back),
              onPressed: () => ref.read(coordinatorProvider).pop(),
            ),
      title: Text(
        'YESAT Initiative',
        style: GoogleFonts.libreBaskerville(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppTheme.darkText,
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
                title: 'About',
                onTap: () => ref.read(coordinatorProvider).push(AboutRoute()),
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
              child: Text(
                'YESAT',
                style: GoogleFonts.libreBaskerville(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkText,
                ),
              ),
            ),
          ),
          _DrawerItem(
            title: 'Home',
            onTap: () => ref.read(coordinatorProvider).push(HomeRoute()),
          ),
          _DrawerItem(
            title: 'Impact',
            onTap: () => ref.read(coordinatorProvider).push(ImpactRoute()),
          ),
          _DrawerItem(
            title: 'About',
            onTap: () => ref.read(coordinatorProvider).push(AboutRoute()),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: BoxDecoration(
        color: AppTheme.creamSurface,
        border: Border(
          bottom: BorderSide(color: AppTheme.darkText.withValues(alpha: 0.1)),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Action for Transformation',
            style: GoogleFonts.inter(
              letterSpacing: 4,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xffD4AF37), // Gold accent
            ),
          ).animate().fadeIn().slideY(begin: 0.3, end: 0),
          const SizedBox(height: 16),
          Text(
            'Creating Sustainable Impact',
            textAlign: TextAlign.center,
            style: GoogleFonts.libreBaskerville(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkText,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 24),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              'From digital literacy workshops to reforestation initiatives, our projects are led by youth, for the community.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 18,
                color: AppTheme.darkText.withValues(alpha: 0.7),
              ),
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
        ],
      ),
    );
  }

  Widget _buildProjectGrid() {
    final projects = [
      _ProjectData(
        title: 'Digital Empowerment Hub',
        category: 'Youth Skilling',
        description:
            'Providing computer literacy training to 500+ rural youth annually.',
        icon: Icons.computer,
      ),
      _ProjectData(
        title: 'Green Roots Initiative',
        category: 'Environment',
        description:
            'Planting 10,000 indigenous trees to combat local deforestation.',
        icon: Icons.park,
      ),
      _ProjectData(
        title: 'Youth Leadership Summit',
        category: 'Community',
        description:
            'Annual workshop for emerging grassroot leaders and advocates.',
        icon: Icons.groups,
      ),
      _ProjectData(
        title: 'Clean Water Advocates',
        category: 'Health',
        description:
            'Installing sustainable water filtration systems in primary schools.',
        icon: Icons.water_drop,
      ),
    ];

    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final crossAxisExtent = constraints.crossAxisExtent;
        final isMobile = crossAxisExtent < 600;

        return SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: isMobile ? crossAxisExtent : 450,
            mainAxisSpacing: 32,
            crossAxisSpacing: 32,
            childAspectRatio: isMobile ? 1.1 : 0.85,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            final p = projects[index];
            return _ProjectCard(project: p)
                .animate()
                .fadeIn(delay: (200 * index).ms, duration: 800.ms)
                .slideY(begin: 0.2, end: 0);
          }, childCount: projects.length),
        );
      },
    );
  }

  Widget _buildSuccessStories() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      color: Colors.white.withValues(alpha: 0.5),
      child: Column(
        children: [
          Text(
            'Success Stories',
            style: GoogleFonts.libreBaskerville(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 48),
          const _TestimonialCard(
            quote:
                "Yesat gave me the digital skills I needed to start my own design business. I am now independent and supporting my family.",
            author: "Sarah Nakato",
            role: "Digital Literacy Beneficiary",
          ).animate().fadeIn(duration: 1500.ms),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: AppTheme.darkText,
      child: Column(
        children: [
          // Text(
          //   'YESAT',
          //   style: GoogleFonts.libreBaskerville(
          //     fontSize: 24,
          //     color: AppTheme.creamBackground,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // const SizedBox(height: 20),
          Text(
            '© 2026 YESAT Initiative Uganda Ltd. Empowering the youth today.',
            style: TextStyle(
              color: AppTheme.creamBackground.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectData {
  final String title;
  final String category;
  final String description;
  final IconData icon;

  _ProjectData({
    required this.title,
    required this.category,
    required this.description,
    required this.icon,
  });
}

class _ProjectCard extends StatefulWidget {
  final _ProjectData project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: 300.ms,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: isHovered ? Colors.white : AppTheme.creamSurface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
          border: Border.all(
            color: isHovered
                ? AppTheme.darkText.withValues(alpha: 0.1)
                : Colors.transparent,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.creamBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(widget.project.icon, color: AppTheme.darkText),
            ),
            const SizedBox(height: 24),
            Text(
              widget.project.category.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 12,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
                color: const Color(0xffD4AF37),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.project.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.libreBaskerville(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkText,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Text(
                widget.project.description,
                overflow: TextOverflow.fade,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  height: 1.6,
                  color: AppTheme.darkText.withValues(alpha: 0.7),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Read Case Study →'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final String quote;
  final String author;
  final String role;

  const _TestimonialCard({
    required this.quote,
    required this.author,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Container(
          constraints: const BoxConstraints(maxWidth: 800),
          padding: EdgeInsets.all(isMobile ? 24 : 48),
          decoration: BoxDecoration(
            color: AppTheme.creamSurface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppTheme.darkText.withValues(alpha: 0.05),
            ),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.format_quote,
                size: 48,
                color: Color(0xffD4AF37),
              ),
              const SizedBox(height: 24),
              Text(
                '"$quote"',
                textAlign: TextAlign.center,
                style: GoogleFonts.libreBaskerville(
                  fontSize: isMobile ? 20 : 24,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                author,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 16 : 18,
                ),
              ),
              Text(
                role,
                style: GoogleFonts.inter(
                  color: AppTheme.darkText.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        );
      },
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
