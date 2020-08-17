import 'package:app_flutter_film/src/models/film_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  //const CardSwiper({Key key}) : super(key: key);

  final List<Film> films;

  CardSwiper({@required this.films});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;    

    return Container(
      padding: EdgeInsets.only(top:10.0),      
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context,int index){

          films[index].uniqueId = '${films[index].id}-card';

          return Hero(
            tag: films[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                child: FadeInImage(
                  image: NetworkImage(films[index].getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
                onTap: (){
                  Navigator.pushNamed(context, 'detail', arguments: films[index]);
                },
              ),
            ),
          );          
        },
        itemCount: films.length,
        //itemWidth: 200.0,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),        
      ),
    );
  }
}