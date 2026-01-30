import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ngoNameProvider = Provider<String>((ref) {
  return 'YESAT Initiative Uganda Ltd';
});

final sloganProvider = Provider<String>((ref) {
  return 'Empowering Youth,\nIgniting Change.';
});

final descriptionProvider = Provider<String>((ref) {
  return 'Youth Empowerment through Sustainable Action for Transformation (YESAT) Initiative Uganda Ltd\nis a youth-led NGO dedicated to fostering leadership,\ninnovation, and sustainable development across communities.';
});

final imageProvider = Provider<String>((ref) {
  return 'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?q=80&w=2000&auto=format&fit=crop';
});

final ngoImpactCounterProvider = Provider<Map<String, String>>((ref) {
  return {'volunteers': '00', 'countries': '1', 'livesAffected': '0'};
});

class ImpactData {
  final String number;
  final String label;
  final Duration delay;
  ImpactData({required this.number, required this.label, required this.delay});
}

final impactStatProvider =
    Provider.family<List<ImpactData>, Map<String, String>>((ref, impact) {
      return [
        ImpactData(
          number: impact['volunteers']!,
          label: 'Volunteers',
          delay: const Duration(milliseconds: 200),
        ),
        ImpactData(
          number: impact['countries']!,
          label: 'Countries',
          delay: const Duration(milliseconds: 400),
        ),
        ImpactData(
          number: impact['livesAffected']!,
          label: 'Lives Affected',
          delay: const Duration(milliseconds: 600),
        ),
      ];
    });

final visionProvider = Provider<String>((ref) {
  return 'A vibrant, self-reliant, and empowered youth-led community where young people actively contribute to sustainable development.';
});

class VisionData {
  final IconData icon;
  final String title;
  final String description;
  final Duration delay;
  VisionData({
    required this.icon,
    required this.title,
    required this.description,
    required this.delay,
  });
}

final visionCardProvider = Provider<List<VisionData>>((ref) {
  return [
    VisionData(
      icon: Icons.lightbulb,
      title: 'Empowerment',
      description: 'Equipping youth with skills, knowledge, and opportunities.',
      delay: const Duration(milliseconds: 200),
    ),
    VisionData(
      icon: Icons.eco,
      title: 'Sustainability',
      description: 'Action for long-term social and economic transformation.',
      delay: const Duration(milliseconds: 400),
    ),
    VisionData(
      icon: Icons.volunteer_activism,
      title: 'Self-Reliance',
      description:
          'Transforming communities into states of independent growth.',
      delay: const Duration(milliseconds: 600),
    ),
  ];
});

final youngProvider = Provider<String>((ref) {
  return 'Join thousands of young leaders in transforming their communities.';
});

final footerProvider = Provider.family<String, String>((ref, title) {
  return '© 2026 $title. All rights reserved.';
});
