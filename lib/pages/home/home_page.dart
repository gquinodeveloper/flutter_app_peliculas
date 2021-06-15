import 'package:flutter/material.dart';
import 'package:flutter_application_pelicula/pages/home/widgets/card_swiper.dart';
import 'package:flutter_application_pelicula/pages/home/widgets/popular_movies.dart';
import 'package:flutter_application_pelicula/providers/api/movies_api.dart';
import 'package:flutter_application_pelicula/providers/models/movie_model.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("dibujando");
    return Scaffold(
      appBar: AppBar(
        title: Text("Películas"),
      ),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesApiProvider = Provider.of<MoviesApi>(context);
    return ListView(
      children: [
        CardSwiper(
          isLoading: moviesApiProvider.isLoading,
          movies: moviesApiProvider.movies,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "Popular Movies",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        PopularMovies(
          isLoading: moviesApiProvider.isLoading,
          movies: moviesApiProvider.popularMovies,
        )
      ],
    );
  }
}

class Body2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesApiProvider = Provider.of<MoviesApi>(context);
    return FutureBuilder(
      future: moviesApiProvider.getMovies2(),
      builder:
          (BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot) {
        if (snapshot.hasData) {
          return Swiper(
            layout: SwiperLayout.STACK,
            itemCount: snapshot.data.length,
            itemWidth: 300.0,
            itemHeight: 400.0,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: FadeInImage(
                    image: NetworkImage(
                      'https://i.pinimg.com/474x/58/7c/e4/587ce440682f6658a50f7508e6e4d6c8.jpg',
                    ),
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    fadeInDuration: Duration(milliseconds: 600),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }
}
