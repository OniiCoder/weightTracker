import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:weight_tracker/bloc/authenticatedbloc/AuthenticatedBloc.dart';
import 'package:weight_tracker/bloc/authenticatedbloc/AuthenticatedEvent.dart';
import 'package:weight_tracker/bloc/crudbloc/CrudBloc.dart';
import 'package:weight_tracker/bloc/crudbloc/CrudEvent.dart';
import 'package:weight_tracker/bloc/loginbloc/LoginBloc.dart';
import 'package:weight_tracker/bloc/loginbloc/LoginEvent.dart';
import 'package:weight_tracker/bloc/loginbloc/LoginState.dart';
import 'package:weight_tracker/bloc/userweightsbloc/UserWeightsBloc.dart';
import 'package:weight_tracker/bloc/userweightsbloc/UserWeightsEvent.dart';
import 'package:weight_tracker/bloc/userweightsbloc/UserWeightsState.dart';
import 'package:weight_tracker/database/SharePrefs.dart';
import 'package:weight_tracker/models/UserWeightData.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightInputFieldController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  LoginBloc loginBloc;
  UserWeightsBloc userWeightsBloc;
  CrudBloc _crudBloc;

  bool editMode = false;
  UserWeightData editModeUserWeightData;

  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    userWeightsBloc = BlocProvider.of<UserWeightsBloc>(context);
    userWeightsBloc.add(UserWeightsEvent.fetchUserWeights());

    _crudBloc = CrudBloc();

    scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Weight Tracker'),
        elevation: 0,
        centerTitle: false,
        actions: [
          FlatButton.icon(
            onPressed: (){
              loginBloc.add(LoginEvent.logOut());
            },
            icon: Icon(Icons.logout, color: Colors.white,),
            label: Row(
              children: [
                Text('Logout', style: TextStyle(color: Colors.white),),
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
          )
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener(
            cubit: loginBloc,
            listener: (context, state) {
              if(state is LogOutSuccessful) {
                BlocProvider.of<AuthenticatedBloc>(context).add(AuthenticatedEvent.unAuthenticate());
              }
            },
          ),
        ],
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 85,
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: Container(
                          color: Color(0xffEFEFF0),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: weightInputFieldController,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffEFEFF0),
                                hintText: 'Enter your weight in kg',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 9, horizontal: 14),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        style: BorderStyle.none)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        style: BorderStyle.none)),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                if(value.isEmpty) {
                                  return 'Enter weight';
                                }
                                return null;
                              },
                            ),
                          ),
                        )
                    ),
                    SizedBox(width: 10,),
                    FlatButton.icon(
                        color: Colors.deepOrange,
                        onPressed: (){

                          if (_formKey.currentState.validate()) {
                            if(editMode) {
                              editModeUserWeightData.weight = int.parse(weightInputFieldController.text);
                              _crudBloc.add(CrudEvent.updateWeight(userWeight: editModeUserWeightData));

                            } else {
                              _crudBloc.add(CrudEvent.addWeight(userWeight: UserWeightData(
                                  id: Uuid().v4(),
                                  timestamp: Timestamp.fromDate(DateTime.now()),
                                  userId: SharePrefs.loggedInUserId,
                                  weight: int.parse(weightInputFieldController.text)
                              )));

                            }
                            //clear input field
                            weightInputFieldController.text = '';

                            setState(() {
                              editMode = false;
                              editModeUserWeightData = null;
                            });
                          }
                        },
                        icon: Icon(Icons.save, color: Colors.white,),
                        label: Text('Save', style: TextStyle(color: Colors.white),)
                    )
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder(
                  cubit: userWeightsBloc,
                  builder: (context, state) {
                    if(state is FetchUserWeightsSuccessful) {
                      return state.userWeights.isNotEmpty ? ListView.builder(
                        controller: scrollController,
                        itemCount: state.userWeights.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: GestureDetector(
                              onTap: () {
                                _crudBloc.add(CrudEvent.deleteWeight(userWeight: state.userWeights[index]));
                              },
                              child: Icon(Icons.delete_forever, color: Colors.red,),
                            ),
                            title: Text('${state.userWeights[index].weight}kg'),
                            trailing: GestureDetector(
                              onTap: () {
                                setState(() {
                                  editMode = true;
                                  editModeUserWeightData = state.userWeights[index];
                                });
                                weightInputFieldController.text = state.userWeights[index].weight.toString();
                              },
                              child: Icon(Icons.edit, color: Colors.green,),
                            ),
                            subtitle: Text('${DateFormat.MMMEd().format(DateTime.fromMillisecondsSinceEpoch(state.userWeights[index].timestamp.seconds * 1000))} | ${DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(state.userWeights[index].timestamp.seconds * 1000))}'),

                          );
                        },
                      ) : Container(
                        child: Center(
                          child: Text('No weight saved!'),
                        ),
                      );
                    }

                    return Container(
                      child: Center(
                        child: Text('Loading user weights...'),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
