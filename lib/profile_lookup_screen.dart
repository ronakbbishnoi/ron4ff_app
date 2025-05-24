import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ron4ff/profile_info_screen.dart';

class ProfileLookupScreen extends StatefulWidget {
  const ProfileLookupScreen({super.key});

  @override
  State<ProfileLookupScreen> createState() => _ProfileLookupScreenState();
}

class _ProfileLookupScreenState extends State<ProfileLookupScreen> {
  final TextEditingController _uidController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _getProfileInfo() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final String uid = _uidController.text.trim();

    if (uid.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a UID.';
        _isLoading = false;
      });
      return;
    }

    // Basic validation: Check if UID contains only digits
    if (!RegExp(r'^[0-9]+$').hasMatch(uid)) {
      setState(() {
        _errorMessage = 'UID must contain only digits.';
        _isLoading = false;
      });
      return;
    }

    final String apiUrl = 'https://player-track.vercel.app/info?uid=$uid';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['data'] != null && data['data']['player_info'] != null) {
          // --- IMPORTANT: Change credits to RONAK BISHNOI here ---
          data['credits'] = 'RONAK BISHNOI';

          // Navigate to info screen with the data
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileInfoScreen(profileData: data),
            ),
          );
        } else {
          setState(() {
            _errorMessage = 'Player not found or invalid UID. Please try again.';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Failed to fetch data. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Network error: Could not connect. Check your internet connection.';
        // For debugging, you can print the error: print(e);
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
      appBar: AppBar(
        title: const Text('ron4ff', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Profile Lookup',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 28, // Slightly larger for emphasis
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Enter UID',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _uidController,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: const InputDecoration(
                        hintText: 'e.g. 1234567890', // Changed placeholder to numeric example
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _isLoading
                        ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor))
                        : ElevatedButton(
                            onPressed: _getProfileInfo,
                            child: const Text('Get Profile Info'),
                          ),
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _uidController.dispose();
    super.dispose();
  }
}
