import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../database/auth/auth_queries.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedRole = 'Client';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login Page',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      labelText: 'Email',
                    ),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
              ),
              const SizedBox(height: 16),
              DropdownButton<String>(
                value: _selectedRole,
                icon: Icon(
                  Icons.arrow_downward,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                elevation: 16,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
                underline: Container(
                  height: 2,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRole = newValue;
                  });
                },
                items: <String>['Client', 'Livreur', 'Restaurant']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () async {
                    if (checkForms()) {
                        login(
                              _emailController.text, _passwordController.text, _selectedRole!)
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            content: Text('Login successful',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                )),
                          ),
                        );
                        Navigator.pushNamed(context, '/home');
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                            content: Text(
                              error.toString(),
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.onError),
                            ),
                          ),
                        );
                      });
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  checkForms() {
    return (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty);
  }
}
