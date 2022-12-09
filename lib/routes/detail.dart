import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:dio/dio.dart';
import '../iconfont/icon_font.dart';
import '../config.dart';

class Detail extends StatefulWidget {
  const Detail({super.key, required this.id});
  final int id;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  dynamic _data;

  @override
  void initState() {
    super.initState();
    getDetail({ 'id': widget.id });
  }

  // 查询新闻详情
  Future<void> getDetail(params) async {
    var dio = Dio();
    Response response = await dio.post(
      '$baseUrl/showEssay',
      data: params,
    );
    setState(() {
      _data = response.data['dataList'][0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(_data != null ? _data['title'] : '')
      ),
      body: _data == null
        ? const SizedBox(
            height: double.infinity,
            child: Center(
              child: Text(
                '加载中...',
                style: TextStyle(
                  color: Color(0xFF999999)
                )
              ),
            )
          )
        : SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _data['title'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  )
                ),
                const SizedBox(height: 10),
                DefaultTextStyle(
                  style: const TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 12
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(_data['ownName'] ?? '好消息'),
                      const SizedBox(width: 20),
                      Text(_data['createTime'])
                    ]
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconFont(IconNames.label, size: 14, color: '#999999'),
                      const SizedBox(width: 10),
                      Expanded( // 不加的话Text无法自动换行
                        child: Text(
                          _data['desct'],
                          style: const TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 12
                          )
                        )
                      ),
                    ]
                  )
                ),
                const SizedBox(height: 10),
                Html(
                  data: _data['con'],
                  style: {
                    'div': Style(
                      margin: const EdgeInsets.only(bottom: 10),
                    ),
                    'p': Style(
                      margin: const EdgeInsets.only(bottom: 10),
                      fontSize: FontSize.rem(1.0),
                    ),
                    'img': Style(
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10)
                    )
                  }
                )
              ]
            )
          )
    );
  }
}