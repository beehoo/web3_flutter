import 'package:flutter/material.dart';
import './iconfont/icon_font.dart';
import 'routes/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFFDD2A7B),
      ),
      home: const MyHomePage(title: 'Web3夜报'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 主题色
    final primaryColor = Theme.of(context).primaryColor;
    // 主题色转字符串
    final activeColor = '#${primaryColor.value.toRadixString(16)}';

    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: _selectedIndex == 0 ? const Home() : Text('Selected Index: $_selectedIndex')
      ),
      bottomNavigationBar: SizedBox(
        height: 56,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: IconFont(IconNames.home),
              activeIcon: IconFont(IconNames.home, color: activeColor),
              label: '发现',
            ),
            BottomNavigationBarItem(
              icon: IconFont(IconNames.music),
              activeIcon: IconFont(IconNames.music, color: activeColor),
              label: 'LuckyBGM'
            ),
            BottomNavigationBarItem(
              icon: IconFont(IconNames.personal),
              activeIcon: IconFont(IconNames.personal, color: activeColor),
              label: '我的'
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        )
      )
    );
  }
}
