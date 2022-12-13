import 'package:flutter/material.dart';

// 关于
class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('关于')
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 20, left: 15, right: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Image.asset('assets/images/logo.png',
                    width: 64
                  ),
                  const SizedBox(height: 15),
                  const Text('Web3夜报', style: TextStyle(
                    fontFamily: 'youshebiaotihei'
                  )),
                  const SizedBox(height: 40),
                  DefaultTextStyle(
                    style: const TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 12,
                      height: 1.5
                    ),
                    child: Column(
                      children: const <Widget>[
                        Text('发现Web3世界里的好消息'),
                        Text('分享有趣有用的Web3应用'),
                        Text('成为所有Builder的好帮手'),
                        SizedBox(height: 30),
                        Text('Discover the good Tidings in the Web3 world and share interesting and useful Web3 applications.'),
                        Text('Be a good helper for all Builders.'),
                      ]
                    ),
                  ),
                ],
              ),
              const Text('Copyright 2022 Good Tidings', style: TextStyle(
                color: Color(0xFF999999),
                fontSize: 12
              ))
            ]
          ),
        )
      )
    );
  }
}