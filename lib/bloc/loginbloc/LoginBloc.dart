
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_tracker/bloc/loginbloc/LoginEvent.dart';
import 'package:weight_tracker/bloc/loginbloc/LoginState.dart';
import 'package:weight_tracker/services/authentication.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initialState());

  Authentication _authentication = Authentication();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    yield* event.when(
      loginAnonymously: () => mapToLoginAnonymously(),
      logOut: () => mapToLogOut()
    );
  }

  Stream<LoginState> mapToLoginAnonymously() async* {
    yield LoginState.loginLoading();

    try {
      User user = await _authentication.anonymousSignIn();

      if(user != null) {
        yield LoginState.loginSuccessful(user: user);
      } else{
        yield LoginState.loginFailed(error: 'unable to login');
      }
    } catch (e) {
      yield LoginState.loginFailed(error: e.toString());
    }
  }

  Stream<LoginState> mapToLogOut() async* {
    yield LoginState.logOutLoading();

    try {
      await _authentication.signOutUser();

      yield LoginState.logOutSuccessful();
    } catch (e) {
      yield LoginState.logOutFailed(error: e.toString());
    }
  }

}