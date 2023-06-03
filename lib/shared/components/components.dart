import 'package:flutter/material.dart';
import 'package:new_app/app_cubit/main_cubit.dart';

Widget seperatorLine() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey,
      ),
    );
Widget buildArticleItem(model, context) => Row(
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
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(
                  '${model['title']}',
                  style: AppCubit.get(context).isDark
                      ? Theme.of(context).textTheme.displayLarge
                      : Theme.of(context).textTheme.displayLarge,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )),
                // Text(
                //   '${model['publishedAt']}',
                //   style: TextStyle(color: Colors.grey),
                // ),
              ],
            ),
          ),
        )
      ],
    );

Widget articleBuilder(list) {
  if (list.length > 0) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => seperatorLine(),
        itemCount: list.length);
  } else {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
