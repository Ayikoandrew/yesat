import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme.dart';
import 'core/router.dart';

final coordinatorProvider = Provider((ref) => AppCoordinator());

void main() {
  runApp(const ProviderScope(child: YesatApp()));
}

class YesatApp extends ConsumerWidget {
  const YesatApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coordinator = ref.watch(coordinatorProvider);

    return MaterialApp.router(
      title: 'Yesat NGO',
      debugShowCheckedModeBanner: false,
      theme: WebTheme.lightTheme,
      routerDelegate: coordinator.routerDelegate,
      routeInformationParser: coordinator.routeInformationParser,
      restorationScopeId: 'yesat_app',
    );
  }
}
