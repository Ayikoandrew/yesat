import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
                SliverToBoxAdapter(child: _buildHeaderSection()),
                SliverToBoxAdapter(child: _buildStorySection()),
                SliverToBoxAdapter(child: _buildVisionMissionSection()),
                SliverToBoxAdapter(child: _buildCoreValuesSection()),
                SliverToBoxAdapter(child: _buildTeamSection()),
                SliverToBoxAdapter(child: _buildTransparencySection()),
                SliverToBoxAdapter(child: _buildFooter()),
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

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
      color: AppTheme.creamBackground,
      child: Column(
        children: [
          Text(
            'Youth Empowerment through Sustainable Action for Transformation (YESAT) Initiative Uganda Ltd',
            textAlign: TextAlign.center,
            style: GoogleFonts.libreBaskerville(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkText,
            ),
          ).animate().fadeIn(duration: 1200.ms).slideY(begin: 0.2),
          const SizedBox(height: 24),
          Text(
            'Vibrant. Self-reliant. Empowered.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 18,
              letterSpacing: 4,
              fontWeight: FontWeight.w300,
              color: AppTheme.accentGold,
            ),
          ).animate().fadeIn(delay: 400.ms),
          const SizedBox(height: 24),
          Container(
            width: 80,
            height: 4,
            color: AppTheme.accentGold,
          ).animate().fadeIn(delay: 600.ms).scaleX(),
        ],
      ),
    );
  }

  Widget _buildStorySection() {
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
                    Expanded(flex: 3, child: _buildStoryText())
                  else
                    _buildStoryText(),
                  SizedBox(width: isMobile ? 0 : 80, height: isMobile ? 60 : 0),
                  if (!isMobile)
                    Expanded(flex: 2, child: _buildStoryImage())
                  else
                    _buildStoryImage(),
                ],
              ),
              const SizedBox(height: 60),
              _buildDetailedBackground(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStoryText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Background',
          style: GoogleFonts.libreBaskerville(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'YESAT Initiative Uganda Ltd is a youth-led community-based non-governmental organization established in 2025 in the West Nile Sub-region, Uganda. Originally formed as Eco-Frontline Youth Uganda Ltd, the name was revised to reflect the broader scope of service delivery and interests the organization aims to achieve.',
          style: GoogleFonts.inter(
            fontSize: 18,
            height: 1.6,
            color: AppTheme.darkText.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'The organization was born from recognized social, economic, and environmental challenges in the region that deeply impact youth, women, and vulnerable groups.',
          style: GoogleFonts.inter(
            fontSize: 18,
            height: 1.6,
            color: AppTheme.darkText.withValues(alpha: 0.8),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 1200.ms).slideX(begin: -0.1);
  }

  Widget _buildDetailedBackground() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Uganda has a young and rapidly growing population, yet many face unemployment, poverty, limited skills, and environmental degradation. YESAT was founded by motivated young people who saw a need for practical, community-driven solutions.',
          style: GoogleFonts.inter(
            fontSize: 18,
            height: 1.6,
            color: AppTheme.darkText.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Our mission is to empower youth to become active agents of change, equipping them with the knowledge and opportunities to contribute substantially to their communities and transform their lives toward self-reliance.',
          style: GoogleFonts.inter(
            fontSize: 18,
            height: 1.6,
            color: AppTheme.darkText.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'We work closely with local communities, leaders, government structures, and partners to design programs guided by transparency, volunteerism, accountability, and sustainability.',
          style: GoogleFonts.inter(
            fontSize: 18,
            height: 1.6,
            color: AppTheme.darkText.withValues(alpha: 0.8),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildVisionMissionSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: AppTheme.creamSurface,
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
                      content:
                          'A vibrant, self-reliant, and empowered youth-led community where young people actively contribute to sustainable social and economic development.',
                      icon: Icons.lightbulb_outline,
                    ),
                  ),
                  const SizedBox(width: 40, height: 40),
                  Expanded(
                    flex: isSmall ? 0 : 1,
                    child: _buildVisionMissionCard(
                      title: 'Mission',
                      content:
                          'To empower youth with skills, knowledge, and opportunities to deliver sustainable community services that improve livelihoods in order to promote self-reliance and transformation in Uganda.',
                      icon: Icons.rocket_launch_outlined,
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
  }) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppTheme.creamBackground,
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
          Icon(icon, color: AppTheme.accentGold, size: 40),
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
              color: AppTheme.darkText.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1);
  }

  Widget _buildCoreValuesSection() {
    final values = [
      {'title': 'Leadership', 'icon': Icons.stars},
      {'title': 'Participation', 'icon': Icons.groups},
      {'title': 'Integrity', 'icon': Icons.verified_user},
      {'title': 'Accountability', 'icon': Icons.assignment_turned_in},
      {'title': 'Innovation', 'icon': Icons.psychology},
      {'title': 'Sustainability', 'icon': Icons.eco},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        children: [
          Text(
            'Our Core Values',
            style: GoogleFonts.libreBaskerville(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildStoryImage() {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.creamSurface,
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
        color: AppTheme.accentGold,
      ),
    ).animate().fadeIn(duration: 1200.ms).scale();
  }

  Widget _buildTeamSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: AppTheme.creamSurface,
      child: Column(
        children: [
          Text(
            'Meet Our Youth Leaders',
            style: GoogleFonts.libreBaskerville(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
              _TeamMemberCard(
                name: 'Jude Augustine Drasiku',
                role: 'Founder',
                profile:
                    'Jude is driven by a deep commitment to community transformation led by youth through practical frameworks and systems to deliver impactful grassroot initiatives. With prior experience from community and education outreaches, he has worked with youth to build confidence and create awareness.',
                strengths: 'Strategic thinking | Leadership | Proactive action',
                quote: 'Young people are the catalyst for future change.',
              ),
              _TeamMemberCard(
                name: 'Ayiko Andrew',
                role: 'Head of Skilling',
                profile:
                    'Ayiko Andrew is a software engineer and educator dedicated to bridging the digital divide in rural communities. He designs and implements custom digital curricula to equip youth with 21st-century technical skills, fostering a generation of digital creators rather than just consumers.',
                strengths:
                    'Software Engineering | Systems Design | Technical Education',
                quote: 'Digital proficiency is the modern tool for liberation.',
              ),
              _TeamMemberCard(
                name: 'Apangu Philliam',
                role: 'Community Lead',
                profile:
                    'Apangu Philliam is a specialist in Sustainable Agriculture with a mission to restore local ecosystems and ensure food security. He leads flagship reforestation and climate-smart agriculture programs, bridging the gap between scientific expertise and grassroots implementation.',
                strengths:
                    'Sustainable Agriculture | Environmental Restoration | Grassroots Engagement',
                quote:
                    'Ecological balance is the foundation of economic empowerment.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransparencySection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Container(
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 60 : 100,
            horizontal: isMobile ? 20 : 40,
          ),
          child: Card(
            color: AppTheme.darkText,
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
                      color: AppTheme.creamBackground,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'We hold ourselves to the highest standards of accountability. Funders can access our annual reports and independent audits at any time.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 16 : 18,
                      color: AppTheme.creamBackground.withValues(alpha: 0.8),
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
        ).animate().fadeIn(duration: 1200.ms).slideY(begin: 0.2);
      },
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(40),
      color: AppTheme.creamSurface,
      child: Center(
        child: Text(
          '© 2026 YESAT NGO. Empowering the youth today.',
          style: TextStyle(color: AppTheme.darkText.withValues(alpha: 0.5)),
        ),
      ),
    );
  }
}

class _TeamMemberCard extends StatelessWidget {
  final String name;
  final String role;
  final String profile;
  final String strengths;
  final String quote;

  const _TeamMemberCard({
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
            color: AppTheme.creamBackground,
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
                  backgroundColor: AppTheme.accentGold.withValues(alpha: 0.1),
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: AppTheme.accentGold,
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
                        color: AppTheme.accentGold,
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
                          color: AppTheme.darkText.withValues(alpha: 0.8),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        strengths,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                          color: AppTheme.darkText,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppTheme.accentGold.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppTheme.accentGold.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Text(
                          '“$quote”',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.libreBaskerville(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: AppTheme.darkText,
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
          color: AppTheme.creamBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.accentGold.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppTheme.accentGold.withValues(alpha: 0.1),
              child: const Icon(
                Icons.person,
                size: 40,
                color: AppTheme.accentGold,
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
                color: AppTheme.accentGold,
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
                color: AppTheme.darkText.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Read Profile →',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppTheme.accentGold,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 1000.ms).slideY(begin: 0.1);
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
        color: AppTheme.creamSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.accentGold.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.accentGold, size: 32),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkText,
            ),
          ),
        ],
      ),
    ).animate().fadeIn().scale(delay: 200.ms);
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
        side: const BorderSide(color: AppTheme.creamBackground),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        foregroundColor: AppTheme.creamBackground,
      ),
      child: Text(label),
    );
  }
}
