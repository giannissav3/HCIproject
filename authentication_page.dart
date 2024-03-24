import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget {
  final void Function(bool isAuthenticated) onAuthenticated;

  const AuthenticationPage({Key? key, required this.onAuthenticated})
      : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isSignIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSignIn ? 'Sign In' : 'Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isSignIn ? _handleSignIn : _handleSignUp,
              child: Text(_isSignIn ? 'Sign In' : 'Sign Up'),
            ),
            TextButton(
              onPressed: _toggleSignInSignUp,
              child: Text(_isSignIn
                  ? 'Don\'t have an account? Sign Up'
                  : 'Already have an account? Sign In'),
            ),
            TextButton(
              onPressed: _handleForgotPassword,
              child: Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSignIn() {
    // Pseudo sign-in logic
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      widget.onAuthenticated(true);
      _showMessage('Sign In Successful');
    } else {
      _showMessage('Invalid email or password');
    }
  }

  void _handleSignUp() {
    // Pseudo sign-up logic
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      widget.onAuthenticated(true);
      _showMessage('Sign Up Successful');
    } else {
      _showMessage('Invalid email or password');
    }
  }

  void _handleForgotPassword() {
    // Pseudo forgot password logic
    if (_emailController.text.isNotEmpty) {
      _showMessage('Password reset email sent to ${_emailController.text}');
    } else {
      _showMessage('Please enter your email');
    }
  }

  void _toggleSignInSignUp() {
    setState(() {
      _isSignIn = !_isSignIn;
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AuthenticationPage(
      onAuthenticated: (isAuthenticated) {
        // Handle the authentication state here
      },
    ),
  ));
}
