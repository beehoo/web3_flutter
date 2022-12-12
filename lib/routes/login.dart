import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import '../iconfont/icon_font.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phone = ''; // 手机号
  String password = ''; // 密码
  String code = ''; // 邀请码
  bool isPassword = true; // 是否为密码登录，否则为验证码登录

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    // 登录
    Future<void> loginSubmit() async {
      if (phone == '') {
        Flushbar(
          // title: '提示',
          message: '请输入手机号',
          duration: const Duration(seconds: 2),
          flushbarPosition: FlushbarPosition.TOP,
          icon: IconFont(IconNames.del, color: '#f00')
        ).show(context);
        return;
      }
      if (isPassword && password == '') {
        Flushbar(
          // title: '提示',
          message: '请输入密码',
          duration: const Duration(seconds: 2),
          flushbarPosition: FlushbarPosition.TOP,
          icon: IconFont(IconNames.del, color: '#f00')
        ).show(context);
        return;
      }
      if (!isPassword && code == '') {
        Flushbar(
          // title: '提示',
          message: '请输入验证码',
          duration: const Duration(seconds: 2),
          flushbarPosition: FlushbarPosition.TOP,
          icon: IconFont(IconNames.del, color: '#f00')
        ).show(context);
        return;
      }

      // 验证手机号格式
      var pattern = r'1\d{10}';
      var regex = RegExp(pattern);
      var match = regex.firstMatch(phone);
      if (match == null) {
        Flushbar(
          // title: '提示',
          message: '请输入正确的手机号',
          duration: const Duration(seconds: 2),
          flushbarPosition: FlushbarPosition.TOP,
          icon: IconFont(IconNames.del, color: '#f00')
        ).show(context);
        return;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Text(
              'Web3夜报',
              style: TextStyle(
                fontFamily: 'youshebiaotihei',
                fontSize: 24,
                color: primaryColor,
              )
            )
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                LoginInput(
                  hintText: '请输入手机号',
                  onChanged: (value) {
                    setState(() {
                      phone = value;
                    });
                  },
                ),
                Visibility(
                  visible: isPassword,
                  child: LoginInput(
                    hintText: '请输入密码',
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    }
                  )
                ),
                Visibility(
                  visible: !isPassword,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      LoginInput(
                        hintText: '请输入验证码',
                        onChanged: (value) {
                          code = value;
                        }
                      ),
                      Positioned(
                        right: 0,
                        child: TextButton(
                          child: const Text('获取验证码'),
                          onPressed: () {},
                        )
                      )
                    ]
                  )
                ),
                LoginInput(
                  hintText: '请输入邀请码（没有可不填）',
                  onChanged: (value) {
                    code = value;
                  }
                ),
                const SizedBox(height: 20),
                // 登录按钮
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primaryColor),
                      ),
                      onPressed: loginSubmit,
                      child: const Text('登录'),
                    )
                  )
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  child: Text(isPassword ? '验证码登录' : '账号密码登录'),
                ),
                const SizedBox(height: 20),
                Visibility(
                  visible: !isPassword,
                  child: const Text(
                    '未注册用户手机号验证码后自动登录',
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 12
                    )
                  )
                )
              ],
            ),
          )
        ]
      )
    );
  }
}

// 登录输入框
class LoginInput extends StatelessWidget {
  const LoginInput({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.obscureText = false
  });
  final String hintText;
  final dynamic onChanged;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText, // 输入内容是否可见
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFDDDDDD)
          )
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Color(0xFF999999)
        )
      ),
      onChanged: onChanged
    );
  }
}