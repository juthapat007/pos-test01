import 'package:flutter/material.dart';
import 'package:flutter_application_2/config/cons.dart';
import 'package:flutter_application_2/screens/product_item.dart';
import 'package:flutter_application_2/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/product_item.dart';
import 'package:flutter_application_2/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await AuthService.login(
        username: _usernameController.text.trim(),
        password: _passwordController.text,
      );

      final String token = result['token'];

      // ✅ login สำเร็จ → ไปหน้า ProductItem พร้อม token
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ProductItem(token: token)),
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login', style: Theme.of(context).textTheme.headlineMedium),

            const SizedBox(height: 24),

            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),

            SizedBox(height: AppSpacing.md),

            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),

            const SizedBox(height: AppSpacing.md),

            if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),

            const SizedBox(height: AppSpacing.lg),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
