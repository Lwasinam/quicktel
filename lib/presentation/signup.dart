import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:email_validator/email_validator.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {



  @override
  void initState() {
    //log outs all log in instance for demo purposes
      FirebaseAuth.instance.signOut();
    super.initState();
  }
  Widget? iconVal;
  validateName(bool isTrue) {
    if (isTrue) {
      setState(() {
        iconVal = Icon(
          Icons.check_rounded,
          color: Colors.green,
        );
      });
    } else {
      setState(() {
        iconVal = Icon(
          Icons.cancel_outlined,
          color: Colors.red,
        );
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Signup",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    NameField(),
                    const SizedBox(
                      height: 15,
                    ),
                    EmailField(),
                    const SizedBox(
                      height: 15,
                    ),
                    PasswordField(),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: HaveAccountText()),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                            child: Text('SIGN UP',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                ),
                                primary: Colors.orange,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                elevation: 1,
                                shadowColor: Colors.orange),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                showDialog(
                                    context: context,
                                    builder: (context) => Center(
                                        child: CircularProgressIndicator()));
                                print("true");
                                print(emailController);
                                print(passwordController);
                                try {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim());
                                           Navigator.pushNamed(context, '/home');       
                                } on FirebaseAuthException catch (e) {
                                  // print(e);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(e.message.toString())));
                                  print("true");
                                }
                                //  Navigator.pushNamed(context, '/login');
                              } else {
                             
                                print("false");
                              }
                            })),
                    const SizedBox(
                      height: 40,
                    ),
                    const Center(
                      child: Text(
                        "Or sign up with social account",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          height: 70,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Container(
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset('assets/gg.svg'),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          height: 70,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Container(
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset('assets/fb.svg'),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ));
  }
}

class HaveAccountText extends StatelessWidget {
  const HaveAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Icon(Icons.arrow_forward_outlined, color: Colors.orange)
      ],
    );
  }
}

class PasswordField extends StatefulWidget {
  PasswordField({
    Key? key,
  }) : super(key: key);
  Widget? iconVal;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        child: Material(
          elevation: 2.0,
          shadowColor: Colors.grey.withOpacity(0.5),
          child: TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value!.isEmpty || value.length < 7) {
                setState(() {});
                widget.iconVal = Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                );
                return 'empty';
              } else {
                setState(() {
                  widget.iconVal = Icon(
                    Icons.check,
                    color: Colors.green,
                  );
                });
                return null;
              }
            },
            decoration: InputDecoration(
                suffixIcon: widget.iconVal,
                focusColor: Colors.grey,
                errorStyle: TextStyle(color: Colors.transparent),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                // hintText: "Name",
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                filled: true,
                fillColor: Colors.white),
          ),
        ));
  }
}

class EmailField extends StatefulWidget {
  EmailField({
    Key? key,
  }) : super(key: key);
  Widget? iconVal;
  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        child: Material(
          elevation: 2.0,
          shadowColor: Colors.grey.withOpacity(0.5),
          child: TextFormField(
            controller: emailController,
            validator: (value) {
              if (!EmailValidator.validate(value!) || value.isEmpty) {
                setState(() {});
                widget.iconVal = Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                );
                return 'empty';
              } else {
                setState(() {
                  widget.iconVal = Icon(
                    Icons.check,
                    color: Colors.green,
                  );
                });
                return null;
              }
            },
            decoration: InputDecoration(
                suffixIcon: widget.iconVal,
                focusColor: Colors.grey,
                errorStyle: TextStyle(color: Colors.transparent),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                // hintText: "Name",
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                filled: true,
                fillColor: Colors.white),
          ),
        ));
  }
}

class NameField extends StatefulWidget {
  NameField({
    Key? key,
    // required this.iconVal,
  }) : super(key: key);

  Widget? iconVal;

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        child: Material(
          elevation: 2.0,
          shadowColor: Colors.grey.withOpacity(0.5),
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty || value.length < 4) {
                setState(() {});
                widget.iconVal = Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                );
                return 'empty';
              } else {
                setState(() {
                  widget.iconVal = Icon(
                    Icons.check,
                    color: Colors.green,
                  );
                });
              }
              return null;
            },
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                suffixIcon: widget.iconVal,
                focusColor: Colors.grey,
                errorStyle: TextStyle(color: Colors.transparent),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                // hintText: "Name",
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                filled: true,
                fillColor: Colors.white),
          ),
        ));
  }
}
