import 'package:flutter/material.dart';
import 'package:manage_my_link/functions/auth_functions.dart';
import 'package:manage_my_link/screens/home_screen.dart';
import 'package:manage_my_link/widgets/error.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLogin = true;
  bool isLoading = false;
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passController;

  Future<void> authenticate() async {
    setState(() {
      isLoading = true;
    });
    await AuthFunctions.authenticate(
      name: nameController.text.isNotEmpty ? nameController.text.trim() : null,
      email: emailController.text.trim(),
      password: passController.text.trim(),
      isLogin: isLogin,
    ).then(
      (value) {
        bool isValid = _formKey.currentState!.validate();
        if (!isValid) {
          return;
        }
        setState(() {
          isLoading = false;
        });
        if (value == "Success") {
          Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName,
            (route) => false,
          );
        } else {
          ErrorSnackbar().showError(context, value);
        }
      },
    );
  }

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isLogin ? "Login" : "Signup",
                        textScaler: TextScaler.noScaling,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (!isLogin) ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Name",
                            textScaler: TextScaler.noScaling,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 32,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.secondary,
                          ),
                          validator: (value) {
                            if (value == null) {
                              return "Enter a name";
                            } else if (value.isEmpty) {
                              return "Enter a name";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Email",
                          textScaler: TextScaler.noScaling,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 32,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.secondary,
                        ),
                        validator: (value) {
                          if (value == null) {
                            return "Enter a email";
                          } else if (value.isEmpty) {
                            return "Enter a email";
                          } else if (!value.contains("@")) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
                          textScaler: TextScaler.noScaling,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 32,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: passController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.secondary,
                        ),
                        validator: (value) {
                          if (value == null) {
                            return "Enter a password";
                          } else if (value.isEmpty) {
                            return "Enter a password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (isLoading)
                        Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      if (!isLoading) ...[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.onSecondary,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 20,
                            ),
                          ),
                          onPressed: () async {
                            await authenticate();
                          },
                          child: Text(
                            isLogin ? "Login" : "Signup",
                            textScaler: TextScaler.noScaling,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.onSecondary,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 20,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                          child: Text(
                            isLogin ? "Signup Instead" : "Login Instead",
                            textScaler: TextScaler.noScaling,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
