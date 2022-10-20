part of 'preferences_bloc.dart';

@immutable
abstract class PreferencesState {
  const PreferencesState();

  List<dynamic> get props => [];
}

class PreferencesInitial extends PreferencesState {}

class PreferencesLoading extends PreferencesState {}

class PreferencesLoaded extends PreferencesState {
  final Map<String, dynamic> preferences;

  const PreferencesLoaded({required this.preferences});

  @override
  List<dynamic> get props => [preferences];

  @override
  String toString() => 'PreferencesLoaded { preferences: $preferences }';
}

class PreferencesError extends PreferencesState {
  final String message;

  const PreferencesError({required this.message});

  @override
  List<dynamic> get props => [message];

  @override
  String toString() => 'PreferencesError { message: $message }';
}

class PreferencesSaving extends PreferencesState {}

class PreferencesSaved extends PreferencesState {
  final Map<String, dynamic> preferences;

  const PreferencesSaved({required this.preferences});

  @override
  List<dynamic> get props => [preferences];

  @override
  String toString() => 'PreferencesSaved { preferences: $preferences }';
}
