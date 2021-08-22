import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/api_service.dart';
import 'package:untitled1/models/customer.dart';
import 'package:untitled1/utils/ProgressHUD.dart';
import 'package:untitled1/utils/form_helper.dart';
import 'package:untitled1/utils/validator_services.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late APIService apiService;
  late CustomerModel model;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;

  @override
  void initState() {
    apiService = new APIService();
    model = new CustomerModel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Azad Essential',
      home:  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: true,
        title: Text("Sign Up"),
      ),
      body: ProgressHUD(
        key: _globalKey,
        child: new Form(
          child: _formUI(),
          key: _formKey,
        ),
        inAsyncCall: isApiCallProcess,
      ),
    )
    );
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHelper.fieldLabel("First Name"),
                FormHelper.textInput(
                  context,
                  model.firstName,
                      (value) => {this.model.firstName = value},
                  onValidate: (value) {
                    if (value
                        .toString()
                        .isEmpty) {
                      return 'Please enter First Name.';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Last Name"),
                FormHelper.textInput(
                  context,
                  model.lastName,
                      (value) => {this.model.lastName = value},
                  onValidate: (value) {
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Email Id"),
                FormHelper.textInput(
                  context,
                  model.email,
                      (value) => {this.model.email = value},
                  onValidate: (value) {
                    if (value
                        .toString()
                        .isEmpty) {
                      return 'Please enter Email Id.';
                    }
                    if (value.isNotEmpty && !value.toString().isValidEmail()) {
                      return 'Please enter valid email id.';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Password"),
                FormHelper.textInput(
                  context,
                  model.password,
                      (value) => {this.model.password = value},
                  onValidate: (value) {
                    if (value
                        .toString()
                        .isEmpty) {
                      return 'Please enter Password.';
                    }
                    return null;
                  },
                  obscureText: hidePassword,
                  suffixIcon: IconButton(onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                    color: Theme
                        .of(context)
                        .accentColor
                        .withOpacity(0.4),
                    icon: Icon(hidePassword ? Icons.visibility_off : Icons
                        .visibility,),),
                ),
                SizedBox(height: 20,),
                new Center(
                  child: FormHelper.saveButton("Register", () {
                    if (validateAndSave()) {
                      print(model.toJson());
                      setState(() {
                        isApiCallProcess = true;
                      });
                      apiService.createCustomer(model).then((ret) {
                        setState(() {
                          isApiCallProcess = false;
                        });
                        if (ret) {
                          // Flushbar(
                          //   message: 'Team added successfully',
                          //   duration: Duration(seconds: 3),
                          // ).show(context);
                          //
                          // Navigator.of(context).pop();

                          FormHelper.showMessage(context, "Azad Essential",
                            "Registration Successful", "Ok", () {
                              Navigator.of(context).pop();
                            },
                          );
                        } else {
                          FormHelper.showMessage(context, "Azad Essential",
                            "Email Id already registered.", "Ok", () {
                              Navigator.of(context).pop();
                            },
                          );
                        }
                      },);
                    }
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

