import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/sizingTools/sizeConfig.dart';
import 'package:flutter/services.dart';
import 'package:myapp/appIcons_icons.dart' as iconClass;

class Timer extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Area Calculator App',
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "coin",
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 11,
              letterSpacing: 4,
              fontFamily: "Comfortaa",
            ),
          ),
          backgroundColor: Colors.blueGrey.shade700,
          centerTitle: true,
        ),
        body: Home(),
      ),
    );
  }
  

}
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Container(
      width: sizeX,
      height: sizeY,
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: 25,
        itemBuilder: (context, index) => createSquare(index),
        separatorBuilder: (context, index) => createSeparator(index),
      ),
    );
  }

  Widget createSquare(int position){
   List colors = [Colors.blueGrey.shade100, Colors.blueGrey.shade200, Colors.blueGrey.shade300, Colors.blueGrey.shade400];

      Container square = Container(

          color: colors[position % 4],
          width: 3 * SizeConfig.safeBlockHorizontal,
          height: 9 * SizeConfig.safeBlockVertical,
          child: Center(
            child: Text(position.toString()),
          ),
      );


    return square;
  }

  Widget createSeparator(int position){
    Widget Separator = Container(
      height: 15,
      color: Colors.black,
    );

    return Separator;
  }
  List<Widget> showCertainLayout(double sizeX, double sizeY){

    List<Widget> layoutChildren = List<Widget>();
    Positioned card = Positioned(
      child: Card(
        elevation: 12,
        color: Colors.blueGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          children: <Widget>[
            Text(
              "Example"
            ),

          ],
        ),
      ),
    );
    layoutChildren.add(card);
    Positioned buttonOrder = Positioned(
      bottom:  sizeY /20,
      left: sizeX/ 20,
      width: sizeX - sizeX/10,
      child: RaisedButton(
        elevation: 12,
        color: Colors.black,
        child: Text(
          "second example"
        ),
        onPressed: (){},
      ),
    );
    layoutChildren.add(buttonOrder);
    return layoutChildren;
  }
}


class Contact {
  String name;
  String subtitle;
  IconData icon;
  Contact(this.name, this.subtitle, this.icon);
}

