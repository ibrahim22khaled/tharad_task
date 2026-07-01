import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad_task/core/di/di_container.dart';
import 'package:tharad_task/core/session/cubit/app_session_cubit.dart';
import 'package:tharad_task/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:tharad_task/features/auth/presentation/cubits/otp/otp_cubit.dart';
import 'package:tharad_task/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:tharad_task/features/auth/presentation/screens/login_screen.dart';
import 'package:tharad_task/features/auth/presentation/screens/otp_screen.dart';
import 'package:tharad_task/features/auth/presentation/screens/registration_screen.dart';
import 'package:tharad_task/features/home/presentation/cubits/get_profile/get_profile_cubit.dart';
import 'package:tharad_task/features/home/presentation/cubits/update_profile/update_profile_cubit.dart';
import 'package:tharad_task/features/home/presentation/screens/home_screen.dart';
import 'package:tharad_task/features/home/presentation/screens/profile_screen.dart';
import 'package:tharad_task/features/home/presentation/widgets/home_shell.dart';
import 'package:tharad_task/features/splash/splash_screen.dart';

GoRouter createRouter(AppSessionCubit authCubit) => GoRouter(
  initialLocation: '/splash',
  refreshListenable: _AuthNotifier(authCubit),
  redirect: (context, state) {
    final authState = authCubit.state;
    final location = state.matchedLocation;

    if (authState is AppSessionLoading) {
      return location == '/splash' ? null : '/splash';
    }

    if (authState is AppSessionUnauthenticated) {
      final onAuthPage =
          location == '/login' || location == '/register' || location == '/otp';
      return onAuthPage ? null : '/login';
    }

    if (authState is AppSessionAuthenticated) {
      final onAuthPage =
          location == '/login' ||
          location == '/register' ||
          location == '/splash';
      return onAuthPage ? '/homeshell' : null;
    }

    return null;
  },
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/login',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<LoginCubit>(),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<RegisterCubit>(),
        child: const RegistrationScreen(),
      ),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<OtpCubit>(),
        child: OtpScreen(email: state.extra as String),
      ),
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
     GoRoute(
      path: '/homeshell',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<GetProfileCubit>()..getProfile()),
          BlocProvider(create: (_) => getIt<UpdateProfileCubit>()),
        ],
        child: const HomeShell(),
      ),
    ),
  ],
);

class _AuthNotifier extends ChangeNotifier {
  _AuthNotifier(AppSessionCubit cubit) {
    cubit.stream.listen((_) => notifyListeners());
  }
}
