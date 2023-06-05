import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/layouts/news_app/cubit/cubit.dart';
import 'package:new_app/layouts/news_app/cubit/states.dart';
import 'package:new_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                    controller: searchController,
                    hintText: "Search for an article",
                    keyboardType: TextInputType.text,
                    prefix: Icon(Icons.search),
                    validat: (value) {
                      if (value!.isEmpty) {
                        return 'Search must not be empty.';
                      }
                      return null;
                    },
                    onchanged: (String value) {
                      NewsCubit.get(context).getSearch(value);
                    }),
              ),
              Expanded(child: articleBuilder(list, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
