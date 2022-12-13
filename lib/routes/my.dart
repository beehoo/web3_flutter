import 'package:flutter/material.dart';
import './login.dart';
import '../iconfont/icon_font.dart';
import './about.dart';

// 个人中心
class My extends StatelessWidget {
  const My({super.key});

  // 路由，route为路由对象，valid为校验是否已登录
  _handleRoute (context, route, valid) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => valid ? const Login() : route,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(40),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30)),
                backgroundColor: MaterialStateProperty.all(primaryColor),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  )
                );
              },
              child: const Text('去登录'),
            )
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const <Widget>[
            ItemBox(
              num: '0',
              icon: IconNames.zan,
              iconColor: '#ff0040',
              label: '点赞'
            ),
            ItemBox(
              num: '0',
              icon: IconNames.shoucang,
              iconColor: '#f9be59',
              label: '收藏'
            ),
            ItemBox(
              num: '0',
              icon: IconNames.liulan,
              iconColor: '#6190e8',
              label: '浏览'
            )
          ],
        ),
        const SizedBox(height: 20),
        Column(
          children: <Widget>[
            MenuItem(
              icon: IconNames.jifen,
              label: '波波文具店',
              textStyle: TextStyle(
                fontFamily: 'youshebiaotihei',
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
              onTap: () {}
            ),
            MenuItem(
              icon: IconNames.diamond,
              label: '积分计划',
              onTap: () {}
            ),
            MenuItem(
              icon: IconNames.tags,
              label: '我的标签',
              onTap: () {}
            ),
            MenuItem(
              icon: IconNames.setting,
              label: '账号设置',
              onTap: () {}
            ),
            MenuItem(
              icon: IconNames.share,
              label: '推荐分享',
              onTap: () {}
            ),
            MenuItem(
              icon: IconNames.xiaoxi,
              label: '消息中心',
              onTap: () {}
            ),
            MenuItem(
              icon: IconNames.guanyu,
              label: '关于Web3夜报',
              onTap: () {
                _handleRoute(context, const About(), false);
              }
            ),
          ]
        )
      ]
    );
  }
}

class ItemBox extends StatelessWidget {
  const ItemBox({
    super.key,
    required this.num, // 数量
    required this.icon, // 图标名称
    required this.iconColor, // 图标颜色
    required this.label // 文字内容
  });
  final String num;
  final dynamic icon;
  final String iconColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          num,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          )
        ),
        const SizedBox(height: 5),
        Row(
          children: <Widget>[
            IconFont(icon, size: 14, color: iconColor),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12
              )
            )
          ]
        )
      ]
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.icon, // 图标
    required this.label, // 标题
    this.textStyle = const TextStyle(), // 文本样式
    required this.onTap
  });
  final dynamic icon;
  final String label;
  final dynamic textStyle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final primaryColor = '#${Theme.of(context).primaryColor.value.toRadixString(16)}';

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconFont(icon, size: 18, color: primaryColor),
                const SizedBox(width: 10),
                Text(label, style: textStyle)
              ],
            ),
            IconFont(IconNames.arrow, size: 12, color: '#999')
          ],
        )
      )
    );
  }
}