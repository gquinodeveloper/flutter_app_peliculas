import 'package:flutter/material.dart';
import 'package:flutter_application_pelicula/constant/constant.dart';
import 'package:flutter_application_pelicula/providers/models/movie_model.dart';

class PopularMovies extends StatelessWidget {
  PopularMovies({
    @required this.isLoading,
    @required this.movies,
  });

  final bool isLoading;
  final List<MovieModel> movies;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.0,
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: isLoading == true ? 5 : movies.length,
        itemBuilder: (_, index) {
          return Column(
            children: [
              Container(
                width: 160.0,
                height: 180.0,
                margin: EdgeInsets.only(left: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: isLoading == true
                      ? Image.asset(
                          'assets/loading.gif',
                          fit: BoxFit.cover,
                        )
                      : FadeInImage(
                          image: NetworkImage(
                              kPathImage + movies[index].posterPath),
                          placeholder: AssetImage('assets/no-image.jpg'),
                          fadeInDuration: Duration(milliseconds: 600),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                width: 180.0,
                child: Text(
                  isLoading == true ? "" : movies[index].title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
