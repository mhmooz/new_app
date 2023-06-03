import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget seperatorLine() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey,
      ),
    );

Widget buildArticleItem(model) => Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage("${model['urlToImage']}"),
                    fit: BoxFit.cover)),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(
                  '${model['title']}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )),
                Text(
                  '${model['publishedAt']}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        )
      ],
    );

Widget articleBuilder(list) {
  if (list.length > 0) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index]),
        separatorBuilder: (context, index) => seperatorLine(),
        itemCount: list.length);
  } else {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
