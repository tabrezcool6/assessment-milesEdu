import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_state.dart';

/// Cubit to manage the state of the current app user.
class AppUserCubit extends Cubit<AppUserState> {
  /// Initializes the cubit with the initial state.
  AppUserCubit() : super(AppUserInitial());

  /// Updates the state based on the current user.
  /// Emits `AppUserInitial` if the user is null, otherwise emits `AppUserLoggedIn`.
  void currentUser(User? currentUser) {
    if (currentUser == null) {
      emit(AppUserInitial()); // User is not logged in.
    } else {
      emit(AppUserLoggedIn()); // User is logged in.
    }
  }
}
