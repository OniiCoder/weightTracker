import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/bloc/authenticatedbloc/AuthenticatedBloc.dart';
import 'package:weight_tracker/bloc/authenticatedbloc/AuthenticatedEvent.dart';
import 'package:weight_tracker/bloc/authenticatedbloc/AuthenticatedState.dart';
import 'package:weight_tracker/ui/auth/login.dart';
import 'package:weight_tracker/ui/others/home.dart';

class SwitchPage extends StatefulWidget {
  @override
  _SwitchPageState createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {

  AuthenticatedBloc _authenticatedBloc;

  @override
  void initState() {
    _authenticatedBloc = BlocProvider.of<AuthenticatedBloc>(context);
    _authenticatedBloc.add(AuthenticatedEvent.checkAuthentication());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: _authenticatedBloc,
      builder: (context, state) {
        if(state is UserAuthenticated) {
          return Home();
        }

        if(state is UserNotAuthenticated) {
          return Login();
        }

        return Login();
    });
  }
}
