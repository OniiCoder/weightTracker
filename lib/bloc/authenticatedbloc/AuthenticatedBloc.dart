
import 'package:bloc/bloc.dart';
import 'package:weight_tracker/bloc/authenticatedbloc/AuthenticatedEvent.dart';
import 'package:weight_tracker/bloc/authenticatedbloc/AuthenticatedState.dart';
import 'package:weight_tracker/database/SharePrefs.dart';

class AuthenticatedBloc extends Bloc<AuthenticatedEvent, AuthenticatedState> {
  AuthenticatedBloc() : super(AuthenticatedState.initialState());

  @override
  Stream<AuthenticatedState> mapEventToState(AuthenticatedEvent event) async* {
    yield* event.when(
      checkAuthentication: () => mapToCheckAuthentication(),
      authenticate: () => mapToAuthenticate(),
      unAuthenticate: () => mapToUnAuthenticate()
    );
  }

  Stream<AuthenticatedState> mapToCheckAuthentication() async* {
    if(SharePrefs.isLoggedIn) {
      yield AuthenticatedState.userAuthenticated();
    } else {
      yield AuthenticatedState.userNotAuthenticated();
    }
  }

  Stream<AuthenticatedState> mapToAuthenticate() async* {
    SharePrefs.isLoggedIn = true;
    yield AuthenticatedState.userAuthenticated();
  }

  Stream<AuthenticatedState> mapToUnAuthenticate() async* {
    SharePrefs.isLoggedIn = false;
    SharePrefs.idToken = '';
    yield AuthenticatedState.userNotAuthenticated();
  }

}