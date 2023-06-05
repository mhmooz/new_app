import 'package:flutter/material.dart';
import 'package:new_app/app_cubit/main_cubit.dart';
import 'package:new_app/modules/webview/webview.dart';

Widget defaultFormField({
  required TextEditingController? controller,
  required String hintText,
  required TextInputType keyboardType,
  required Icon prefix,
  required String? Function(String?)? validat,
  bool isPassword = false,
  bool enable_Suggestion = false,
  bool auto_correct = false,
  Color hint_color = Colors.black,
  Color fillColor = Colors.white,
  double radius = 25,
  bool filled = true,
  Function()? onTap,
  Function()? show_password,
  void Function(String)? onchanged,
  Icon? suffix,
  Function()? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: hint_color),
          prefixIcon: prefix,
          suffixIcon: suffix != null
              ? IconButton(onPressed: suffixPressed, icon: suffix)
              : null,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
          filled: filled,
          fillColor: fillColor),
      validator: validat,
      enableSuggestions: enable_Suggestion,
      autocorrect: auto_correct,
      keyboardType: keyboardType,
      obscureText: isPassword ? true : false,
      onTap: onTap,
      onChanged: onchanged,
    );

Widget seperatorLine() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey,
      ),
    );
Widget buildArticleItem(
  model,
  context,
) =>
    InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(model['url']));
      },
      child: Row(
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
                    style: Theme.of(context).textTheme.displayLarge,
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
      ),
    );

Widget articleBuilder(list, {isSearch = false}) {
  if (list.length > 0) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => seperatorLine(),
        itemCount: list.length);
  } else {
    if (isSearch) {
      return Container();
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
