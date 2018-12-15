import 'package:app_site/torrent.dart';
import 'package:flutter/material.dart';
import 'package:custom_chewie/custom_chewie.dart';
import 'package:video_player/video_player.dart';

class More extends StatefulWidget {
  Torrent torrent;
  More(this.torrent);
  @override
  _MoreState createState() => _MoreState(torrent);
}

class _MoreState extends State<More> {
  Torrent torrent;

  _MoreState(this.torrent);

  VideoPlayerController _controller;
  bool _isPlaying = false;

  void initState() {
    super.initState();
    if(torrent.video != "null"){
      _controller = VideoPlayerController.network(torrent.video)
        ..setVolume(1.0)
        ..addListener(() {
          final bool isPlaying = _controller.value.isPlaying;
          if (isPlaying != _isPlaying) {
            setState(() {
              _isPlaying = isPlaying;
            });
          }
        })
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    }

  }


  void _onItemTapped(int index) {
    setState(() {
      if(torrent.video != null){
        if (index == 0) {
          (_controller.value.isPlaying)? _controller.pause() : _controller.play();
        }
        if (index == 1) {
          //stop
          debugPrint("Stop");
        }
      }else{
        debugPrint("Sem Vídeo");
        if (index == 0) {
          Navigator.pop(context);
        }
        if (index == 1) {
          //stop
          debugPrint("Stop");
        }
      }

    });
  }

  void _requestPop(){
    _controller = null;
  }


  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
      onWillPop: () {
        _requestPop();
        Navigator.pop(context);
      },
      child: new Scaffold(

        bottomNavigationBar: new BottomNavigationBar(
          items: [
            (torrent.video != null)?
            (_isPlaying)?
            BottomNavigationBarItem(
              icon: Icon(Icons.pause),
              title: new Text("Pause"),
            )
                :
            BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_filled),
              title: new Text("Play"),
            )
                :
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: new Text("Home"),
            )
            ,
            BottomNavigationBarItem(
              icon: new Icon(Icons.file_download),
              title: new Text('Download'),
            ),
          ],
          onTap: _onItemTapped,
        ),

        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                backgroundColor: Colors.black45,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("${torrent.nome}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image.network(
                      torrent.fundo,
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },


          body: new ListView(
            children: <Widget>[
              new Column(
                children: <Widget>[

                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Container(
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.only(
                                  topLeft:  const  Radius.circular(40.0),
                                  topRight: const  Radius.circular(40.0))
                          ),
                          child: new Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: new BoxDecoration(
                                color: Colors.lightBlue
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Sinopse",
                                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )

                      )
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text("${torrent.sinopse}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),

                  /**/
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Container(
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.only(
                                  topLeft:  const  Radius.circular(40.0),
                                  topRight: const  Radius.circular(40.0))
                          ),
                          child: new Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: new BoxDecoration(
                                color: Colors.lightBlue
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Assistir",
                                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )

                      )
                  ),
                  /**/
                  new Center(
                    child: (torrent.video != null)?
                        Chewie(
                          _controller,
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          looping: false
                        )
                     : Text(""),

                  ),

                ],
              ),
            ],
          ),
        ),

      ),
    );
  }
}