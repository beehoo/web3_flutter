import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './detail.dart';
import '../config.dart';

// 查询新闻数据
Future<void> getNews(params) async {
  var dio = Dio();
  Response response = await dio.post(
    '$baseUrl/showEssay',
    data: params,
  );
  return response.data;
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          // 搜索框
          const SearchBar(),
          // 内容区
          SizedBox(
            height: MediaQuery.of(context).size.height - 112,
            child: FutureBuilder(
              future: getNews({ 'begin': 0, 'num': 5 }),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  dynamic list = snapshot.data['dataList'];
                  return ListView(
                    padding: const EdgeInsets.all(10),
                    children: <Widget>[
                      for (var i = 0; i < list.length; i++)
                        NewBox(news: list[i])
                    ]
                  );
                } else {
                  return const Center(
                    child: Text(
                      '加载中...',
                      style: TextStyle(
                        color: Color(0xFF999999)
                      )
                    )
                  );
                }
              },
            )
          )
        ]
      )
    );
  }
}

// 搜索框
class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String searchText = '';
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 渐变起始色
    const beginColor = Color(0xFF8134AF);
    // 主题色
    final primaryColor = Theme.of(context).primaryColor;

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 56,
        // 设置渐变
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              beginColor,
              primaryColor,
            ],
          ),
        ),
        child: TextField(
          controller: _controller,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: '搜索关键字',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _controller.text.isEmpty
              ? null
              : IconButton(
                  color: const Color(0xFF999999),
                  iconSize: 16,
                  onPressed: _controller.clear,
                  icon: const Icon(Icons.clear),
                ),
          ),
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
          onSubmitted: (value) {
            // print(value);
          },
        )
      )
    );
  }
}

// 内容
class NewBox extends StatelessWidget {
  const NewBox({super.key, required this.news});
  final dynamic news;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detail(id: news['id']),
          )
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFDDDDDD), width: 1),
          )
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 内容图片
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                news['pic'],
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover
              ),
            ),
            const SizedBox(height: 10), // 间距
            // 内容标题
            Text(
              news['title'],
              maxLines: 2,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              )
            ),
            const SizedBox(height: 5), // 间距
            // 内容简介
            Text(news['desct'],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12
              )
            ),
            const SizedBox(height: 5), // 间距
            // 内容其他信息
            DefaultTextStyle(
              style: const TextStyle(
                color: Color(0xFF999999),
                fontSize: 12
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(news['ownName'] ?? '好消息'),
                      const SizedBox(width: 20),
                      Text(news['createTime'])
                    ]
                  ),
                  Text('${news["essayRNum[1]"] ?? 0}点赞')
                ]
              )
            ),
          ]
        )
      )
    );
  }
}