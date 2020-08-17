import 'package:app_flutter_film/src/providers/films_provider.dart';
import 'package:app_flutter_film/src/search/search_delegate.dart';
import 'package:app_flutter_film/src/widgets/card_swiper_widget.dart';
import 'package:app_flutter_film/src/widgets/movie_horizontal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);

  final filmsProvider = new FilmsProvider();

  @override
  Widget build(BuildContext context) {

    filmsProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Films'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white,),
            onPressed: (){
              showSearch(
                context: context,
                delegate: DataSearch(),
                //query: 'Hola'
              );
            },
          )
        ],
      ),
      /*body: SafeArea(
        child: Text('Films'),
      ),*/
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperCards() {

    return FutureBuilder(
      future: filmsProvider.getNowMovie(),
      //initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        
        if(snapshot.hasData){
          return CardSwiper(
            films: snapshot.data,
          );            
        }else{
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
                
      },
    );
    
    /*filmsProvider.getNowMovie();

    return CardSwiper(
      films: [1,2,3,4,5],
    );*/
  }

  Widget _footer(BuildContext context){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Popular', style: Theme.of(context).textTheme.subhead,)
          ),
          SizedBox(height: 5.0,),

          /*FutureBuilder(
            future: filmsProvider.getPopulares(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot){
              
              //snapshot.data?.forEach((element) => print(element.title));
              if(snapshot.hasData){
                return MovieHorizontal(films: snapshot.data,);
              }
              else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),*/

          StreamBuilder(
            stream: filmsProvider.popularesStream,
            //initialData: [],
            builder: (BuildContext context, AsyncSnapshot<List> snapshot){
              
              //snapshot.data?.forEach((element) => print(element.title));
              if(snapshot.hasData){
                return MovieHorizontal(
                  films: snapshot.data,
                  nextPage: filmsProvider.getPopulares
                );
              }
              else{
                return Center(child: CircularProgressIndicator());
              }
            },
          )

        ],
      ),
    );
  }

}