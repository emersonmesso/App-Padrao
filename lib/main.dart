import 'dart:convert';
import 'package:app_site/index.dart';
import 'package:app_site/torrent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() async {

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  Dados _dados = await getTorrents();

  List _filmes = _dados.filmes;
  List _series = _dados.series;

  runApp(new MaterialApp(
    home: Main(_filmes, _series)
  ));
}


class Main extends StatefulWidget {
  List _filmes;
  List _series;
  Main(this._filmes, this._series);

  @override
  _MainState createState() => _MainState(_filmes, _series);
}

class _MainState extends State<Main> {
  List _series;
  List _filmes;
  _MainState(this._filmes, this._series);

  void initState() {
    super.initState();
  }

  //Método de atualização
  Future<Dados> atualizaDados () async {
    final response = await http.get('http://padraotorrent.com/Backend/pages/api/mobile/getFilmes.php');

    //verifica se o status é 200
    if(response.statusCode == 200){

      return Dados.fromJson(json.decode(response.body));

    }else{
      throw Exception("Falhou");
    }
  }

  //Atualiza

  void atualiza () async {
    Dados _dadosAtu = await atualizaDados();

    setState(() {
      _filmes = _dadosAtu.filmes;
      _series = _dadosAtu.series;
    });

  }

  //

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: new AppBar(
              elevation: 1.0,
              backgroundColor: Colors.black45,
              title: Text("Padrão Torrent",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.exit_to_app),
                  onPressed: () => Navigator.pop(context),
                  color: Colors.white,)
              ],
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.movie),),
                  Tab(icon: Icon(Icons.tv),)
                ],
              ),
            ),

            bottomNavigationBar: new BottomAppBar(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.refresh), padding: EdgeInsets.all(20.0),
                      onPressed: atualiza)
                ],
              ),
            ),

            body: TabBarView(
              children: <Widget>[


                /*Filmes*/
                new Container(
                    child: ListView.builder(
                        itemCount: _filmes.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 35.0),
                            child: ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.all(15.0),
                              leading: new ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: new Image.network(_filmes[index]['capa'],
                                  height: 150.0,
                                  width: 100.0,
                                  filterQuality: FilterQuality.low,
                                ),
                              ),
                              title: Text("${_filmes[index]['nome']}",
                              style: TextStyle(fontSize: 20.0),),
                              subtitle: Text("${_filmes[index]['sin']}"),
                              isThreeLine: true,
                              onTap: () {

                                Navigator.push(context, MaterialPageRoute(builder: (context) => More(Torrent(_filmes[index]['nome'], _filmes[index]['capa'], _filmes[index]['sinopse'], _filmes[index]['ano'], _filmes[index]['tamanho'], _filmes[index]['downloads'], _filmes[index]['qualidade'], _filmes[index]['audio'], _filmes[index]['fundo'], _filmes[index]['video']))));
                              },
                            ),
                          );
                        }
                    )
                ),




                /*Séries*/
                new Container(
                    child: ListView.builder(
                        itemCount: _series.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 35.0),
                            child: ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.all(15.0),
                              leading: new ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: new Image.network(_series[index]['capa'],
                                  height: 150.0,
                                  width: 100.0,
                                  filterQuality: FilterQuality.low,
                                ),
                              ),
                              title: Text("${_series[index]['nome']}",
                                style: TextStyle(fontSize: 20.0),),
                              subtitle: Text("${_series[index]['sin']}"),
                              isThreeLine: true,
                              onTap: () {

                                Navigator.push(context, MaterialPageRoute(builder: (context) => More(Torrent(_series[index]['nome'], _series[index]['capa'], _series[index]['sinopse'], _series[index]['ano'], _series[index]['tamanho'], _series[index]['downloads'], _series[index]['qualidade'], _series[index]['audio'], _series[index]['fundo'], _series[index]['video']))));
                              },
                            ),
                          );
                        }
                    )
                )
              ],
            )
          )
        )
    );
  }
}





/*Acesso ao site*/
Future<Dados> getTorrents () async{
  final response = await http.get('http://padraotorrent.com/Backend/pages/api/mobile/getFilmes.php');

  //verifica se o status é 200
  if(response.statusCode == 200){

    return Dados.fromJson(json.decode(response.body));

  }else{
    throw Exception("Falhou");
  }

}