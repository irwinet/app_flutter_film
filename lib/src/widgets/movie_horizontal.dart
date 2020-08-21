import 'package:app_flutter_film/src/models/film_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  //const MovieHorizontal({Key key}) : super(key: key);

  final List<Film> films;
  final Function nextPage;

  MovieHorizontal({@required this.films, @required this.nextPage});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3, 
  );

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;
    
    _pageController.addListener(() {
      if(_pageController.position.pixels>=_pageController.position.maxScrollExtent-200){
        //print('Load Films');
        nextPage();
      }
    });

    return Container(
      //height: _screenSize.height * 0.25
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        //children: _cards(context),        
        itemBuilder: (context, i){
          return _card(context,films[i]);
        },
        itemCount: films.length,
      ),
    );
  }

  Widget _card(BuildContext context, Film film){

    film.uniqueId = '${film.id}-poster';

    var filmCard = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: film.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(film.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 130.0,
                ),
              ),
            ),
            SizedBox(height: 5.0,),
            Text(
              film.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );

    return GestureDetector(
      child: filmCard,
      onTap: (){
        //print('Title Film: ${film.title}');
        Navigator.pushNamed(context, 'detail', arguments: film);
      },
    );
  }

  List<Widget> _cards(BuildContext context) {
    return films.map((film) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(film.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 130.0,
              ),
            ),
            SizedBox(height: 5.0,),
            Text(
              film.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}