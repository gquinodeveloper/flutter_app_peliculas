import 'package:flutter/material.dart';
import 'package:flutter_application_pelicula/constant/constant.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_application_pelicula/providers/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  CardSwiper({
    @required this.isLoading,
    @required this.movies,
  });

  final bool isLoading;
  final List<MovieModel> movies;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemCount: isLoading == true ? 5 : movies.length,
        itemWidth: 320.0,
        itemHeight: 430.0,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: isLoading == true
                  ? Image.asset(
                      'assets/loading.gif',
                      fit: BoxFit.cover,
                    )
                  : FadeInImage(
                      image:
                          NetworkImage(kPathImage + movies[index].posterPath),
                      placeholder: AssetImage('assets/no-image.jpg'),
                      fadeInDuration: Duration(milliseconds: 600),
                      fit: BoxFit.cover,
                    ),
            ),
          );
        },
      ),
    );
  }
}
