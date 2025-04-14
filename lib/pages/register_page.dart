import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/widgets/my_button.dart';
import 'package:chatapp/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  void registerMethod(BuildContext context) {
    AuthService authService = AuthService();

    // password criteria
    if (passwordController.text.length < 6) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text("Password is too short")),
      );
    }

    //if passwords don't match (confirm == password) then create user
    if (passwordConfirmController.text == passwordController.text) {
      try {
        authService.signUpWithEmailPassword(
          emailController.text,
          passwordController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())),
        );
      }
    }
    //if passwords don't match (confirm != password) display error msg
    else {
      showDialog(
        context: context,
        builder:
            (context) =>
                const AlertDialog(title: Text("Passwords do not match")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 50),

            //welcome back
            Text(
              "Let's create an account for you",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            //textfields email + pass
            MyTextfield(
              hintText: "Email",
              obSecure: false,
              controller: emailController,
            ),
            SizedBox(height: 10),
            MyTextfield(
              hintText: "Password",
              obSecure: true,
              controller: passwordController,
            ),
            SizedBox(height: 10),
            MyTextfield(
              hintText: "Confirm Password",
              obSecure: true,
              controller: passwordConfirmController,
            ),
            SizedBox(height: 20),

            // login button
            MyButton(text: "Register", onTap: () => registerMethod(context)),
            SizedBox(height: 20),

            // register
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      " Login now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
