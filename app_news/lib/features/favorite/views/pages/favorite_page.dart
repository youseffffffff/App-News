import 'package:app_news/core/views/widgets/news_Items_widget.dart';
import 'package:app_news/features/favorite/cubit/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Articles')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(children: [NewsItems(cubit: favoriteCubit)]),
        ),
      ),
    );
  }
}
