import 'package:flutter_riverpod/flutter_riverpod.dart';

final ngoNameProvider = Provider<String>((ref) {
  return 'YESAT Initiative Uganda Ltd';
});

final ngoImpactCounterProvider = Provider<Map<String, String>>((ref) {
  return {'volunteers': '00', 'countries': '1', 'livesAffected': '0'};
});
