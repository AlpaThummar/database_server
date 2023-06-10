import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {

  view_data() async {
    var url = Uri.parse('https://demo2811.000webhostapp.com/view.php');
    var response = await http.get(url);

    // print('Response status: ${response.statusCode}'); //statuscode=200
    // print('Response body: ${response.body}');
    List l=jsonDecode(response.body);
    return l;

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    view_data();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Data"),),
      body: FutureBuilder(future: view_data() ,builder: (context, snapshot) {
        print(snapshot.data);
        if(snapshot.connectionState==ConnectionState.active || snapshot.connectionState==ConnectionState.done){

          List l=snapshot.data as List;

          return ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
            return Card(child: ListTile(trailing: Wrap(children: [
           IconButton(onPressed: () {

             Navigator.push(context, MaterialPageRoute(builder: (context) {
               return get_data(l[index]['id'],l[index]['name'],l[index]['contact']);

             },));

           }, icon: Icon(Icons.edit)),
              IconButton(onPressed: () async {

                var url = Uri.parse('https://demo2811.000webhostapp.com/delet.php?id=${l[index]['id']}');
                var response = await http.get(url);
                setState(() {});

              }, icon: Icon(Icons.delete)),
            ]),

              title: Text("${l[index]['name']}"),subtitle: Text("${l[index]['contact']}"),));

          },);

        }else{
          return Text("");

        }

      },),
    );
  }
}
