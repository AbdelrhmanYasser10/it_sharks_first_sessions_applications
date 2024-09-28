import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_sharks_first_app/shared/cubit/app_cubit.dart';
import 'package:it_sharks_first_app/shared/utlis/card_component.dart';

import '../../models/news_model.dart';
import '../../shared/constants/constants.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        if(state is GetHomeDataLoading){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(state is GetHomeDataError){
          return Center(
            child: Text(
              "Error while getting home data"
            ),
          );
        }
        else{
          var cubit = AppCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                      items: generateSliderCards(cubit.homeData!.articles!),
                      options: CarouselOptions(
                        height: 200,
                        aspectRatio: 16/9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        onPageChanged: (index, reason) {

                        },
                        scrollDirection: Axis.horizontal,
                      )
                  ),
                  const Padding(
                    padding:  EdgeInsets.symmetric(
                        vertical: 20.0,
                    ),
                    child: Text(
                      "Breaking news",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.separated(
                     physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CardComponent(article: cubit.homeData!.articles![index]);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 20.0,
                        );
                      },
                      itemCount: cubit.homeData!.articles!.length,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
  Widget cardWidget(Articles article){
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
          children: [
            Image.network(
              article.urlToImage ?? PLACEHOLDERIMAGE,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    article.title ??"[Title]",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    article.description ??"[Description]",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                  ),
                  Text(
                    article.author ??"[Author]",
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            )
          ],
      ),
    );
  }
  List<Widget> generateSliderCards(List<Articles> articles){
    List<Widget> finalResult = [];
    if(articles.length < 5){
      for(var element in articles){
        finalResult.add(
          cardWidget(
            element
          ),
        );
      }
    }
    else{
      for(int i = 0 ; i < 5; i++){
        finalResult.add(
          cardWidget(
            articles[i],
          ),
        );
      }
    }
    return finalResult;
  }
}
