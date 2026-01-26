import 'package:flutter/material.dart';
import 'package:zenrouter/zenrouter.dart';
import '../features/home/home_page.dart';
import '../features/about/about_page.dart';
import '../features/projects/projects_page.dart';
import '../features/impact/impact_page.dart';

abstract class AppRoute extends RouteTarget with RouteUnique, RouteTransition {
  @override
  StackTransition<T> transition<T extends RouteUnique>(
    covariant Coordinator coordinator,
  ) {
    return StackTransition.custom(
      builder: (context) => build(coordinator, context),
      pageBuilder: (context, key, child) =>
          FadeSlidePage(key: key, child: child),
    );
  }

  @override
  Widget build(covariant Coordinator coordinator, BuildContext context);
}

class FadeSlidePage<T> extends Page<T> {
  final Widget child;

  const FadeSlidePage({required this.child, super.key});

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder<T>(
      settings: this,
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideTween = Tween<Offset>(
          begin: const Offset(0.0, 0.05),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic));

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(slideTween),
            child: child,
          ),
        );
      },
    );
  }
}

class HomeRoute extends AppRoute {
  @override
  Uri toUri() => Uri.parse('/');

  @override
  Widget build(AppCoordinator coordinator, BuildContext context) {
    return const HomePage();
  }
}

class AboutRoute extends AppRoute {
  @override
  Uri toUri() => Uri.parse('/about');

  @override
  Widget build(AppCoordinator coordinator, BuildContext context) {
    return const AboutPage();
  }
}

class ProjectsRoute extends AppRoute {
  @override
  Uri toUri() => Uri.parse('/projects');

  @override
  Widget build(AppCoordinator coordinator, BuildContext context) {
    return const ProjectsPage();
  }
}

class ImpactRoute extends AppRoute {
  @override
  Uri toUri() => Uri.parse('/impact');

  @override
  Widget build(AppCoordinator coordinator, BuildContext context) {
    return const ImpactPage();
  }
}

class NotFoundRoute extends AppRoute {
  @override
  Uri toUri() => Uri.parse('/404');

  @override
  Widget build(AppCoordinator coordinator, BuildContext context) {
    return const Scaffold(body: Center(child: Text('404 - Not Found')));
  }
}

class AppCoordinator extends Coordinator<AppRoute> {
  AppCoordinator() : super();

  @override
  AppRoute parseRouteFromUri(Uri uri) {
    return switch (uri.pathSegments) {
      [] => HomeRoute(),
      ['about'] => AboutRoute(),
      ['projects'] => ProjectsRoute(),
      ['impact'] => ImpactRoute(),
      _ => NotFoundRoute(),
    };
  }
}
