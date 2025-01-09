import 'package:flutter/material.dart';
import 'package:uwuployyy/features/auth/widgets/auth_form_field.dart';
import 'package:uwuployyy/core/services/auth_service.dart';
import 'package:uwuployyy/core/services/firestore_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _idController = TextEditingController();
  bool _isLoading = false;
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _idController.dispose();
    super.dispose();
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final isIdValid = await _firestoreService.isValidId(_idController.text);
        if (!isIdValid) {
          throw Exception('Ungültige oder bereits verwendete ID.');
        }
        await _authService.registerWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
          id: _idController.text,
        );
        // Erfolgreiche Registrierung
        print('Erfolgreich registriert');
        // Hier kannst du zum Login-Bildschirm navigieren
        Navigator.pop(context);
      } catch (e) {
        // Fehler bei der Registrierung
        print('Fehler bei der Registrierung: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler bei der Registrierung: $e')),
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
        title: const Text('Registrieren'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthFormField(
                controller: _idController,
                labelText: 'ID',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte ID eingeben';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
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
                onPressed: _register,
                child: const Text('Registrieren'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}