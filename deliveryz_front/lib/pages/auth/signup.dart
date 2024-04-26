import 'package:deliveryz_front/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../database/auth/auth_queries.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _cookerNameController = TextEditingController();

  String? _selectedRole = 'Client';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Inscription',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Visibility(
                  visible: _selectedRole == 'Restaurant',
                  child: Stack(
                    children: [
                      const SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextField(
                            controller: _cookerNameController,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                              labelText: 'Nom du restaurant',
                            ),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            )),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _selectedRole != 'Restaurant',
                  child: Stack(
                    children: [
                      const SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextField(
                            controller: _firstnameController,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                              labelText: 'Prénom',
                            ),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            )),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _selectedRole != 'Restaurant',
                  child: Stack(
                    children: [
                      const SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextField(
                            controller: _lastnameController,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                              labelText: 'Nom',
                            ),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            )),
                      ),
                    ],
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
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        labelText: 'Adresse',
                      ),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      )),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        labelText: 'Ville',
                      ),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      )),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextField(
                      controller: _postalCodeController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        labelText: 'Code Postal',
                      ),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      )),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        labelText: 'Téléphone',
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
                    onPressed: submit,
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text(
                      'Connexion',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkForms() {
    bool valid = false;
    switch (_selectedRole) {
      case 'Client':
        valid = _emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty &&
            _firstnameController.text.isNotEmpty &&
            _lastnameController.text.isNotEmpty &&
            _addressController.text.isNotEmpty &&
            _cityController.text.isNotEmpty &&
            _postalCodeController.text.isNotEmpty &&
            _phoneNumberController.text.isNotEmpty;
        break;
      case 'Livreur':
        valid = _emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty &&
            _firstnameController.text.isNotEmpty &&
            _lastnameController.text.isNotEmpty &&
            _addressController.text.isNotEmpty &&
            _cityController.text.isNotEmpty &&
            _postalCodeController.text.isNotEmpty &&
            _phoneNumberController.text.isNotEmpty;
        break;
      case 'Restaurant':
        valid = _emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty &&
            _addressController.text.isNotEmpty &&
            _cityController.text.isNotEmpty &&
            _postalCodeController.text.isNotEmpty &&
            _phoneNumberController.text.isNotEmpty &&
            _cookerNameController.text.isNotEmpty;
        break;
      default:
        valid = false;
    }
    return valid;
  }

  submit() async {
    if (checkForms()) {
      User user;

      switch (_selectedRole) {
        case 'Client':
          user = Client(
            firstName: _firstnameController.text,
            lastName: _lastnameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            address: _addressController.text,
            city: _cityController.text,
            postalCode: _postalCodeController.text,
            phoneNumber: _phoneNumberController.text,
          );
          break;
        case 'Livreur':
          user = Deliverer(
            firstName: _firstnameController.text,
            lastName: _firstnameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            address: _addressController.text,
            city: _cityController.text,
            postalCode: _postalCodeController.text,
            phoneNumber: _phoneNumberController.text,
          );
          break;
        case 'Restaurant':
          user = Cooker(
              email: _emailController.text,
              password: _passwordController.text,
              address: _addressController.text,
              city: _cityController.text,
              postalCode: _postalCodeController.text,
              phoneNumber: _phoneNumberController.text,
              cookerName: _cookerNameController.text,
              menu: []);
          break;
        default:
          user = Client(
            firstName: _firstnameController.text,
            lastName: _lastnameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            address: _addressController.text,
            city: _cityController.text,
            postalCode: _postalCodeController.text,
            phoneNumber: _phoneNumberController.text,
          );
      }
      signup(user, _selectedRole!).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            content: Text('Signup successful',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                )),
          ),
        );
        if (_selectedRole == 'Client') {
          Navigator.pushReplacementNamed(context, '/home-client');
        } else if (_selectedRole == 'Livreur') {
          Navigator.pushReplacementNamed(context, '/home-deliverer');
        } else if (_selectedRole == 'Restaurant') {
          Navigator.pushReplacementNamed(context, '/home-cooker');
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            content: Text(
              error.toString(),
              style: TextStyle(color: Theme.of(context).colorScheme.onError),
            ),
          ),
        );
      });
    }
  }
}
