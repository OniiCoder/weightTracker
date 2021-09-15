import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/bloc/authenticatedbloc/AuthenticatedBloc.dart';
import 'package:weight_tracker/bloc/authenticatedbloc/AuthenticatedEvent.dart';
import 'package:weight_tracker/bloc/loginbloc/LoginBloc.dart';
import 'package:weight_tracker/bloc/loginbloc/LoginEvent.dart';
import 'package:weight_tracker/bloc/loginbloc/LoginState.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginBloc loginBloc;

  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          cubit: loginBloc,
          listener: (context, state) {
            if(state is LoginSuccessful) {
              BlocProvider.of<AuthenticatedBloc>(context).add(AuthenticatedEvent.authenticate());
            }
          },
        ),
      ],
      child: Container(
        color: Colors.deepPurple,
        child: Center(
          child: FlatButton.icon(
              color: Colors.deepOrange,
              onPressed: (){
                loginBloc.add(LoginEvent.loginAnonymously());
              },
              icon: Icon(Icons.login, color: Colors.white,),
              label: Row(
                children: [
                  Text('Login', style: TextStyle(color: Colors.white),),
                  BlocBuilder(
                    cubit: loginBloc,
                    builder: (context, state) {
                      if(state is LoginLoading) {
                        return Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              backgroundColor: Colors.grey,
                            ),
                          ),
                        );
                      }

                      return SizedBox.shrink();
                    },
                  ),
                ],
              )
          ),
        ),
      )
    );
  }
}
