part of 'app_session_cubit.dart';

sealed class AppSessionState extends Equatable {
  const AppSessionState();

  @override
  List<Object> get props => [];
}

final class AppSessionLoading extends AppSessionState {
  const AppSessionLoading();
}

final class AppSessionUnauthenticated extends AppSessionState {
  const AppSessionUnauthenticated();
}

final class AppSessionAuthenticated extends AppSessionState {
  const AppSessionAuthenticated();
}