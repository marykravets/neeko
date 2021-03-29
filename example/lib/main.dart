import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neeko/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      home: MyHomePage(title: 'Neeko Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  static const String beeUri = 'https://media.w3.org/2010/05/sintel/trailer.mp4';
  static const String beeUri =
      'http://vfx.mtime.cn/Video/2019/03/09/mp4/190309153658147087.mp4';

  final VideoControllerWrapper videoControllerWrapper = VideoControllerWrapper(
      DataSource.network(
          'http://vfx.mtime.cn/Video/2019/03/09/mp4/190309153658147087.mp4',
          displayName: "displayName"));

//  final VideoControllerWrapper videoControllerWrapper = VideoControllerWrapper(
//      DataSource.network(
//          'http://vfx.mtime.cn/Video/2019/03/09/mp4/190309153658147087.mp4',
//          displayName: "displayName"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NeekoPlayerWidget(
        onSkipPrevious: () {
          print("skip");
          videoControllerWrapper.prepareDataSource(DataSource.network(
              "http://vfx.mtime.cn/Video/2019/03/12/mp4/190312083533415853.mp4",
              displayName: "This house is not for sale"));
        },
        onSkipNext: () {
          videoControllerWrapper.prepareDataSource(DataSource.network(
              'http://vfx.mtime.cn/Video/2019/03/09/mp4/190309153658147087.mp4',
              displayName: "displayName"));
        },
        videoControllerWrapper: videoControllerWrapper,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () {
                print("share");
              })
        ],
      ),
    );
  }
}
