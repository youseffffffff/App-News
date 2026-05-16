import 'package:app_news/core/views/widgets/app_bar_widget.dart';
import 'package:app_news/features/home/views/widgets/carousel_slider_widget.dart';
import 'package:app_news/core/views/widgets/drawer_widget.dart';
import 'package:app_news/features/home/views/widgets/recommendations_widget.dart';
import 'package:app_news/features/home/views/widgets/title_headlines_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,

      drawer: DrawerWidget(),
      appBar: AppBar(
        


        leading: AppBarWidget(
          icon: Icons.menu,
          onTap: () {

            _scaffoldKey.currentState?.openDrawer();
          },
          hasPaddingBetween: true,

        ),

        actions: [
          AppBarWidget(
            icon: Icons.search,
            onTap: () {},
            hasPaddingBetween: true,
          ),
          const SizedBox(width: 8.0),

          AppBarWidget(
            icon: Icons.notifications,
            onTap: () {},
            hasPaddingBetween: true,
          ),
          const SizedBox(width: 16.0),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TitleHeadlinesWidget(
                title: 'Breaking News',
                onTap: () {
                  // Handle "See All" tap
                },
              ),

              Container(
                height: size.height * 0.25,
                //width: double.infinity,
                child: CarouselSliderWidget(),
              ),

              const SizedBox(height: 10.0),

              TitleHeadlinesWidget(
                title: 'Recommendations',
                onTap: () {
                  // Handle "See All" tap
                },
              ),

              RecommendationsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
