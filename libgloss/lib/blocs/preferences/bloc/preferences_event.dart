part of 'preferences_bloc.dart';

@immutable
abstract class PreferencesEvent {
  const PreferencesEvent();

  List<dynamic> get props => [];
}

class LoadPreferencesEvent extends PreferencesEvent {
  const LoadPreferencesEvent();

  @override
  String toString() => 'LoadPreferencesEvent {}';
}

class SavePreferencesEvent extends PreferencesEvent {
  final Map<String, dynamic> preferences;

  const SavePreferencesEvent({
    required Map<String, dynamic> this.preferences,
  });

  @override
  String toString() => 'SavePreferencesEvent { preferences: $preferences }';
}
