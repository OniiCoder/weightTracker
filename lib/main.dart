import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/bloc/authenticatedbloc/AuthenticatedBloc.dart';
import 'package:weight_tracker/bloc/loginbloc/LoginBloc.dart';
import 'package:weight_tracker/bloc/userweightsbloc/UserWeightsBloc.dart';
import 'package:weight_tracker/database/SharePrefs.dart';
import 'package:weight_tracker/ui/others/SwitchPage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharePrefs.init();
  await Firebase.initializeApp();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (BuildContext context) =>LoginBloc()),
        BlocProvider<AuthenticatedBloc>(create: (BuildContext context) =>AuthenticatedBloc()),
        BlocProvider<UserWeightsBloc>(create: (BuildContext context) =>UserWeightsBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SwitchPage(),
      )
    )
  );
}
