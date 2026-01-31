import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final companyProvider = Provider<String>((ref) {
  return 'Youth Empowerment through Sustainable Action for Transformation (YESAT) Initiative Uganda Ltd';
});

final vibrantProvider = Provider<String>((ref) {
  return 'Vibrant. Self-reliant. Empowered.';
});

final backgroundProvider = Provider<String>((ref) {
  return 'Our Background';
});

final historyProvider = Provider<String>((ref) {
  return 'YESAT Initiative Uganda Ltd is a youth-led community-based non-governmental organization established in 2025 in the West Nile Sub-region, Uganda. Originally formed as Eco-Frontline Youth Uganda Ltd, the name was revised to reflect the broader scope of service delivery and interests the organization aims to achieve.';
});

final organizationProvider = Provider<String>((ref) {
  return 'The organization was born from recognized social, economic, and environmental challenges in the region that deeply impact youth, women, and vulnerable groups.';
});

final detailProvider = Provider<String>((ref) {
  return 'Uganda has a young and rapidly growing population, yet many face unemployment, poverty, limited skills, and environmental degradation. YESAT was founded by motivated young people who saw a need for practical, community-driven solutions.';
});

final missionProvider = Provider<String>((ref) {
  return 'Our mission is to empower youth to become active agents of change, equipping them with the knowledge and opportunities to contribute substantially to their communities and transform their lives toward self-reliance.';
});

final missionProvider2 = Provider<String>((ref) {
  return 'We work closely with local communities, leaders, government structures, and partners to design programs guided by transparency, volunteerism, accountability, and sustainability.';
});

final visionProvider = Provider<String>((ref) {
  return 'A vibrant, self-reliant, and empowered youth-led community where young people actively contribute to sustainable social and economic development.';
});

final missionVProvider = Provider<String>((ref) {
  return 'To empower youth with skills, knowledge, and opportunities to deliver sustainable community services that improve livelihoods in order to promote self-reliance and transformation in Uganda.';
});

final valuesProvider = Provider<List<Map<String, dynamic>>>((ref) {
  return [
    {'title': 'Leadership', 'icon': Icons.stars},
    {'title': 'Participation', 'icon': Icons.groups},
    {'title': 'Integrity', 'icon': Icons.verified_user},
    {'title': 'Accountability', 'icon': Icons.assignment_turned_in},
    {'title': 'Innovation', 'icon': Icons.psychology},
    {'title': 'Sustainability', 'icon': Icons.eco},
  ];
});

final coreTitleProvider = Provider<String>((ref) {
  return 'Our Core Values';
});

final youthProvider = Provider<String>((ref) {
  return 'Meet Our Youth Leaders';
});

class TeamMemberData {
  final String name;
  final String role;
  final String profile;
  final String strengths;
  final String quote;

  TeamMemberData({
    required this.name,
    required this.role,
    required this.profile,
    required this.strengths,
    required this.quote,
  });
}

final teamProvider = Provider<List<TeamMemberData>>((ref) {
  return [
    TeamMemberData(
      name: 'Jude Augustine Drasiku',
      role: 'Founder',
      profile:
          'Jude is driven by a deep commitment to community transformation led by youth through practical frameworks and systems to deliver impactful grassroot initiatives. With prior experience from community and education outreaches, he has worked with youth to build confidence and create awareness.',
      strengths: 'Strategic thinking | Leadership | Proactive action',
      quote: 'Young people are the catalyst for future change.',
    ),
    TeamMemberData(
      name: 'Ayiko Andrew',
      role: 'Head of Skilling',
      profile:
          'Ayiko Andrew is a software engineer and educator dedicated to bridging the digital divide in rural communities. He designs and implements custom digital curricula to equip youth with 21st-century technical skills, fostering a generation of digital creators rather than just consumers.',
      strengths: 'Software Engineering | Systems Design | Technical Education',
      quote: 'Digital proficiency is the modern tool for liberation.',
    ),
    TeamMemberData(
      name: 'Apangu Philliam',
      role: 'Community Lead',
      profile:
          'Apangu Philliam is a specialist in Sustainable Agriculture with a mission to restore local ecosystems and ensure food security. He leads flagship reforestation and climate-smart agriculture programs, bridging the gap between scientific expertise and grassroots implementation.',
      strengths:
          'Sustainable Agriculture | Environmental Restoration | Grassroots Engagement',
      quote: 'Ecological balance is the foundation of economic empowerment.',
    ),
    TeamMemberData(
      name: 'Indricia Cynthia Onama',
      role: 'Legal Advisor',
      profile:
          'Cynthia is an emerging legal professional with experience in legal research, drafting and policy support. She has a passion for human rights, gender equity and development oriented advocacy.',
      strengths: 'Resilience | Multitasking | Empathy ',
      quote: 'Cowards don’t make history.',
    ),
    TeamMemberData(
      name: 'Lenia Christine',
      role: 'Member',
      profile:
          'Christine is an accomplished community development professional and social justice advocate with demonstrated competence in gender mainstreaming, adolescent and youth empowerment, and promoting growth and resilience among young people.',
      strengths:
          'Strategic Planning |Team leadership | Gender mainstreaming| Policy Advocacy | Partnership Development',
      quote: 'Empowering Youth , for an Empowered Future',
    ),
  ];
});
