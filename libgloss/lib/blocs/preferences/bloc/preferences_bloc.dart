import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  PreferencesBloc() : super(PreferencesInitial()) {
    on<LoadPreferencesEvent>(_loadPreferences);
    on<SavePreferencesEvent>(_savePreferences);
  }

  FutureOr<void> _loadPreferences(PreferencesEvent event, Emitter emit) async {
    if (kDebugMode) print("\x1B[32m[PreferencesBloc] Loading preferences");
    emit(PreferencesLoading());
    final prefs = await SharedPreferences.getInstance();
    var preferences;

    try {
      preferences = prefs.getKeys().fold<Map<String, dynamic>>(
          {}, (map, key) => map..putIfAbsent(key, () => prefs.get(key)));
    } catch (e) {
      emit(PreferencesError(message: e.toString()));
    }

    if (preferences.isNotEmpty) {
      emit(PreferencesLoaded(preferences: preferences));
    } else {
      print("\x1B[32m[PreferencesBloc] No preferences found, using defaults");

      // TODO: Add default preferences
      preferences = {};

      emit(PreferencesLoaded(preferences: preferences));
    }
  }

  FutureOr<void> _savePreferences(
      SavePreferencesEvent event, Emitter<PreferencesState> emit) async {
    emit(PreferencesSaving());
    final prefs = await SharedPreferences.getInstance();
    try {
      event.preferences.forEach((key, value) {
        if (value is String) {
          prefs.setString(key, value);
        } else if (value is int) {
          prefs.setInt(key, value);
        } else if (value is double) {
          prefs.setDouble(key, value);
        } else if (value is bool) {
          prefs.setBool(key, value);
        } else if (value is List<String>) {
          prefs.setStringList(key, value);
        }
      });
    } catch (e) {
      emit(PreferencesError(message: e.toString()));
    }
    emit(PreferencesSaved(preferences: event.preferences));
  }
}
