import 'package:flutter/material.dart';
import 'package:uwuployyy/features/auth/widgets/auth_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uwuployyy/features/auth/screens/welcome_screen.dart';
import 'package:uwuployyy/features/auth/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        // Erfolgreiche Anmeldung
        print('Erfolgreich angemeldet');
        // Navigiere zum WelcomeScreen
        Navigator.pushReplacementNamed(context, '/welcome');
      } on FirebaseAuthException catch (e) {
        // Fehler bei der Anmeldung
        print('Fehler bei der Anmeldung: ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler bei der Anmeldung: ${e.message}')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthFormField(
                controller: _emailController,
                labelText: 'E-Mail',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte E-Mail eingeben';
                  }
                  if (!value.contains('@')) {
                    return 'Bitte gültige E-Mail eingeben';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AuthFormField(
                controller: _passwordController,
                labelText: 'Passwort',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte Passwort eingeben';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _login,
                child: const Text('Anmelden'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Noch kein Konto? Registrieren'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}