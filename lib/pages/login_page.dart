import 'package:flutter/material.dart';
import 'package:untitled1/pages/signup_page.dart';
import 'package:untitled1/utils/ProgressHUD.dart';
import 'package:untitled1/api_service.dart';
import 'package:untitled1/utils/form_helper.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();

}
class _LoginPageState extends State<LoginPage>
{
  bool hidePassword =true;
  bool isApiCallProcess =false;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";
  late APIService apiService;

  @override
    void initState(){
    apiService =new APIService();
    super.initState();
  }
  @override
  Widget build(BuildContext context){
  return ProgressHUD(key: _globalKey,child: new Form (key: _formKey,child: _uiSetup(context)), inAsyncCall: isApiCallProcess,opacity: 0.3,);
  }

  _uiSetup(BuildContext context) {
    return MaterialApp(
        title:'Azad Essential',
        home: Scaffold(
      backgroundColor: Colors.redAccent,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                        offset: Offset(0,10),
                        blurRadius: 20
                      )
                    ],
                  ),
                  child: Form(
                    child: Column(
                      children:<Widget> [
                        SizedBox(height: 25),
                        Text("Login",style: TextStyle(color: Colors.redAccent,fontSize: 35,fontWeight: FontWeight.bold ),
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => username = input!,
                          validator: (input) => !input!.contains('@')? "Email Id should be vaild" : null,
                          decoration: new InputDecoration(
                            hintText: "Email Address",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor.withOpacity(0.2)
                              )
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor
                              )
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.text,
                          onSaved: (input) => username = input!,
                          validator: (input) => input!.length < 3? "Password should be more than 3 character" : null,
                          obscureText: hidePassword,
                          decoration: new InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor.withOpacity(0.2)
                                )
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor
                                )
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.redAccent,
                            ),
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Theme.of(context).accentColor.withOpacity(0.4),
                              icon: Icon(
                                hidePassword?Icons.visibility_off:
                                    Icons.visibility
                              ),
                            )
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: () => Icons.message,
                            child:Text("Forgot Password",style: TextStyle(color: Colors.blue,fontStyle: FontStyle.italic)
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                            vertical: 12, horizontal: 80
                          ),
                          onPressed: (){
                            if(validateAndSave()){
                              setState(() {
                                isApiCallProcess = true;
                              });
                              apiService.loginCustomer(username,password).then((ret) => {
                                if(ret != null){
                                  FormHelper.showMessage(context,"Azad Essentials", "Login Successful","Ok",(){},)
                                }
                                else{
                                  FormHelper.showMessage(context,"Azad Essentials","Invalid Login","Ok",(){},)
                                }
                              });
                            }
                          }, child: Text("Login", style: TextStyle(color: Colors.white),
                        ),
                          color: Colors.redAccent,
                          shape: StadiumBorder(),
                        ),
                        SizedBox(height: 30),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 75
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/SignUp');
                          },
                            child:Text("Sign Up",style: TextStyle(color: Colors.white),
                            ),
                        color: Colors.redAccent,
                          shape: StadiumBorder(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
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