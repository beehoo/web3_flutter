import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:another_flushbar/flushbar.dart';
import '../iconfont/icon_font.dart';
import '../common/utils.dart' show checkPhone;

// 登录
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
  bool? isChecked = false; // 协议是否勾选

  late TapGestureRecognizer _tapServer;
  late TapGestureRecognizer _tapPolicy;

  @override
  void initState() {
    super.initState();
    _tapServer = TapGestureRecognizer()..onTap = () {
      print('用户服务协议');
    };

    _tapPolicy = TapGestureRecognizer()..onTap = () {
      print('隐私政策');
    };
  }

  @override
  void dispose() {
    // 销毁对象 
    _tapServer.dispose(); 
    _tapPolicy.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    // 登录
    Future<void> loginSubmit() async {
      String errorMsg = '';

      if (phone == '') {
        errorMsg = '请输入手机号';
      }
      if (isPassword && password == '') {
        errorMsg = '请输入密码';
      }
      if (!isPassword && code == '') {
        errorMsg = '请输入验证码';
      }
      if (isChecked == false) {
        errorMsg = '请阅读并勾选协议';
      }
      // 验证手机号格式
      if (!checkPhone(phone)) {
        errorMsg = '请输入正确的手机号';
      }

      if (errorMsg != '') {
        Flushbar(
          // title: '提示',
          message: errorMsg,
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
                // 忘记密码
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Visibility(
                        visible: isPassword,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            '忘记密码',
                            style: TextStyle(
                              color: Color(0xFF999999)
                            )
                          )
                        )
                      )
                    ],
                  )
                ),
                // 勾选协议
                DefaultTextStyle(
                  style: const TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 12
                  ),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value;
                          });
                        }
                      ),
                      Expanded(
                        child: Text.rich(TextSpan(
                          children: [
                            const TextSpan(text: '我已阅读并同意《'),
                            TextSpan(
                              text: '用户服务协议',
                              style: const TextStyle(
                                color: Colors.blue
                              ),
                              recognizer: _tapServer
                            ),
                            const TextSpan(text: '》和《'),
                            TextSpan(
                              text: '隐私政策',
                              style: const TextStyle(
                                color: Colors.blue
                              ),
                              recognizer: _tapPolicy
                            ),
                            const TextSpan(text: '》')
                          ]
                        ))
                      )
                    ]
                  ),
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
    required this.hintText, // 占位文字
    required this.onChanged, // 修改事件
    this.obscureText = false // 输入内容是否可见
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