import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcomePage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const _nameKey = 'name';

  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Created once here, not inside build()
  late Future<String?> _nameFuture;

  @override
  void initState() {
    super.initState();
    _nameFuture = _loadName();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<String?> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }

  Future<void> _saveName() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_nameKey, _nameController.text.trim());

      if (!mounted) return;
      // New future -> FutureBuilder re-reads and switches to HomeScreen
      setState(() {
        _nameFuture = _loadName();
      });
    } catch (e, stacktrace) {
      print('saveName ERROR: $e\n$stacktrace');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not save the name')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // FutureBuilder is the top-level widget, so HomeScreen replaces the
    // whole page instead of being nested inside the login Scaffold.
    return FutureBuilder<String?>(
      future: _nameFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Something went wrong'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        setState(() => _nameFuture = _loadName()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        final name = snapshot.data;
        if (name != null && name.isNotEmpty) {
          return HomeScreen(name: name);
        }

        return _buildLoginForm();
      },
    );
  }

  Widget _buildLoginForm() {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Enter your full name to continue'),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _nameController,
                  validator: _validateName,
                  decoration: const InputDecoration(
                    labelText: 'Full name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: _saveName,
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? _validateName(String? value) {
  final name = value?.trim() ?? '';
  if (name.isEmpty) {
    return 'Enter a name';
  }
  if (name.length <= 3) {
    return 'Enter a name longer than 3 characters';
  }
  return null;
}