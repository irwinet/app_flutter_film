import 'package:app_flutter_film/src/models/film_model.dart';
import 'package:app_flutter_film/src/providers/films_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{
  
  String select = '';
  final filmsProvider = new FilmsProvider();
  
  final films = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam',
    'Ironman 1',
    'Capitan America',
    'Superman',
    'Ironman 2'
  ];

  final filmsRecents = [
    'Spiderman',
    'Capitan America'
  ];
  
  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    //throw UnimplementedError();
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          //print('CLICK!!!');
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquiera del AppBar
    //throw UnimplementedError();
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation,       
      ),
      onPressed: (){
        //print('Leading Icons Press');
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    //throw UnimplementedError();
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(select),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    //throw UnimplementedError();

    /*final listSugerida = (query.isEmpty)?
                            filmsRecents:
                            films.where((element) => element.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: listSugerida.length,
      itemBuilder: (context,index){
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listSugerida[index]),
          onTap: (){
            select = listSugerida[index];
            showResults(context);
          },
        );
      },
    );*/

    if(query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: filmsProvider.searchFilm(query),
      //initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<Film>> snapshot){
        if(snapshot.hasData){
          final films = snapshot.data;
          
          return ListView(
            children: films.map((film){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(film.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.contain,
                  width: 50.0,
                ),
                title: Text(film.title),
                subtitle: Text(film.originalTitle),
                onTap: (){
                  close(context,null);
                  film.uniqueId = '';
                  Navigator.pushNamed(context, 'detail', arguments: film);
                },
              );
            }).toList(),
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

  }  
}