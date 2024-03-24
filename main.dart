// main.dart

import 'package:flutter/material.dart';
import 'profile.dart';
import 'homepage.dart';
import 'notification.dart';
import 'authentication_page.dart';
import 'camera.dart';

void main() {
  runApp(StyleUpApp());
}

GlobalKey<ProfilePageState> profilePageKey = GlobalKey<ProfilePageState>();

class StyleUpApp extends StatelessWidget {
  const StyleUpApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthenticationWrapper(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({Key? key});

  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  bool _isAuthenticated = false;

  void _setAuthenticated(bool isAuthenticated) {
    setState(() {
      _isAuthenticated = isAuthenticated;
    });

    if (_isAuthenticated) {
      // Navigate to the existing app
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ExistingApp(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isAuthenticated
        ? const ExistingApp()
        : AuthenticationPage(onAuthenticated: _setAuthenticated);
  }
}

class ExistingApp extends StatelessWidget {
  const ExistingApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // Initially set to the index of the home page

  final HomePage homePage = HomePage();
  final CameraPage cameraPage = CameraPage(
    onPhotoCapture: (String photoPath) {
      profilePageKey.currentState?.onPhotoCapture(photoPath);
    },
    profilePageKey: profilePageKey,
  );
  final NotificationPage notificationPage = NotificationPage();
  final ProfilePage profilePage = ProfilePage(key: profilePageKey);

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('StyleUp'),
      ),
      // backgroundColor
      body: _buildPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: colorScheme.surfaceVariant,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
            backgroundColor: colorScheme.surfaceVariant,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
            backgroundColor: colorScheme.surfaceVariant,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: colorScheme.surfaceVariant,
          ),
        ],
        selectedItemColor: Color(0xFF5E49C6),
        unselectedItemColor: Colors.black,
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return homePage;
      case 1:
        return cameraPage;
      case 2:
        return notificationPage;
      case 3:
        return profilePage;
      default:
        return Container();
    }
  }
}
