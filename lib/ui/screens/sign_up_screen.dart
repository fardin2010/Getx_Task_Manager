import 'package:flutter/material.dart';
import 'package:task_manager/ui/controllers/sign_up_controller.dart';
import '../widgets/body_background.dart';
import '../widgets/snack_message.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignUpController _signUpController = Get.find<SignUpController>();
@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Join With Us',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                        validator: (v) {
                          if(v == null || v.isEmpty){
                            return "Required A Email Address";
                          }
                          else if(RegExp(r"\w+@\w+\.\w+").hasMatch(v)){
                            return null;
                          }
                          return "Invalid Email";
                        }
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _firstNameTEController,
                      decoration: const InputDecoration(
                        hintText: 'First name',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _lastNameTEController,
                      decoration: const InputDecoration(
                        hintText: 'Last name',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _mobileTEController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Mobile',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your mobile';
                        }
                        if (value!.length < 11) {
                          return 'Enter password more than 11 letters of numbers';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your mobile';
                        }
                        if (value!.length < 6) {
                          return 'Enter password more than 6 letters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<SignUpController>(
                        builder: (signupcontroller) {
                          return Visibility(
                            visible: signupcontroller.RegistrationInProgress == false,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                              onPressed: _signUp,
                              child: const Icon(Icons.arrow_circle_right_outlined),
                            ),
                          );
                        }
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an account?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  // Future<void> _signUp() async {
  //   if (_formKey.currentState!.validate()) {
  //     _signUpInProgress = true;
  //     if (mounted) {
  //       setState(() {});
  //     }
  //     final NetworkResponse response =
  //     await NetworkCaller()
  //         .postRequest(Urls.registration, body: {
  //       "firstName": _firstNameTEController.text.trim(),
  //       "lastName" : _lastNameTEController.text.trim(),
  //       "email" : _emailTEController.text.trim(),
  //       "password" : _passwordTEController.text,
  //       "mobile": _mobileTEController.text.trim(),
  //     });
  //     _signUpInProgress = false;
  //     if (mounted) {
  //       setState(() {});
  //     }
  //     if (response.isSuccess) {
  //       _clearTextFields();
  //       if (mounted) {
  //         showSnackMessage('Account has been created! Please login.');
  //       }
  //     } else {
  //       if (mounted) {
  //         showSnackMessage(
  //             'Account creation failed! Please try again.',
  //             true);
  //       }
  //     }
  //   }
  // }
  //
  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final response = await _signUpController.registration(
      _emailTEController.text.trim(),
      _passwordTEController.text,
      _firstNameTEController.text.trim(),
      _lastNameTEController.text.trim(),
      _mobileTEController.text.trim() ,
    );
    if (response) {
      showSnackMessage("Account Creation Success ! Please Log in",);
      _clearTextFields();
    } else {
        showSnackMessage("Account Creation Failed",true);
    }
  }
  void _clearTextFields() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
