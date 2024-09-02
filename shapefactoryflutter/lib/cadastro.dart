
import 'package:flutter/material.dart';


class Cadastro extends StatelessWidget {
  const Cadastro({super.key});


@override
Widget build(BuildContext context) {
return MaterialApp(
home: Scaffold(
backgroundColor: const Color(0xff000000),
body:Align(
alignment:Alignment.center,
child:Padding(
padding:const EdgeInsets.symmetric(vertical: 0,horizontal:16),
child:SingleChildScrollView(
child:
Column(
mainAxisAlignment:MainAxisAlignment.center,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children: [
///***If you have exported images you must have to copy those images in assets/images directory.
Image(
image:const AssetImage("assets/images/SF-removebg-preview.png"),
height:MediaQuery.of(context).size.height * 0.3,
width:MediaQuery.of(context).size.width,
fit:BoxFit.cover,
),
const Align(
alignment:Alignment.centerLeft,
child:Text(
"Cadastrar",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
fontSize:24,
color:Color(0xffffffff),
),
),
),
Padding(
padding:const EdgeInsets.fromLTRB(0, 16, 0, 0),
child:TextField(
controller:TextEditingController(),
obscureText:false,
textAlign:TextAlign.start,
maxLines:1,
style:const TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:16,
color:Color(0xffffffff),
),
decoration:InputDecoration(
disabledBorder:OutlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:const BorderSide(
color:Color(0xff9e9e9e),
width:1
),
),
focusedBorder:OutlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:const BorderSide(
color:Color(0xff9e9e9e),
width:1
),
),
enabledBorder:OutlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:const BorderSide(
color:Color(0xff9e9e9e),
width:1
),
),
labelText:"Nome",
labelStyle:const TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:16,
color:Color(0xff9e9e9e),
),
filled:true,
fillColor:const Color(0x00ffffff),
isDense:false,
contentPadding:const EdgeInsets.symmetric(vertical: 8,horizontal:12),
),
),
),
Padding(
padding:const EdgeInsets.fromLTRB(0, 16, 0, 0),
child:TextField(
controller:TextEditingController(),
obscureText:false,
textAlign:TextAlign.start,
maxLines:1,
style:const TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:16,
color:Color(0xffffffff),
),
decoration:InputDecoration(
disabledBorder:OutlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:const BorderSide(
color:Color(0xff9e9e9e),
width:1
),
),
focusedBorder:OutlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:const BorderSide(
color:Color(0xff9e9e9e),
width:1
),
),
enabledBorder:OutlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:const BorderSide(
color:Color(0xff9e9e9e),
width:1
),
),
labelText:"Email",
labelStyle:const TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:16,
color:Color(0xff9e9e9e),
),
filled:true,
fillColor:const Color(0x00ffffff),
isDense:false,
contentPadding:const EdgeInsets.symmetric(vertical: 8,horizontal:12),
),
),
),
Padding(
padding:const EdgeInsets.fromLTRB(0, 16, 0, 0),
child:TextField(
controller:TextEditingController(),
obscureText:true,
textAlign:TextAlign.start,
maxLines:1,
style:const TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:16,
color:Color(0xffffffff),
),
decoration:InputDecoration(
disabledBorder:OutlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:const BorderSide(
color:Color(0xff9e9e9e),
width:1
),
),
focusedBorder:OutlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:const BorderSide(
color:Color(0xff9e9e9e),
width:1
),
),
enabledBorder:OutlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:const BorderSide(
color:Color(0xff9e9e9e),
width:1
),
),
labelText:"Senha",
labelStyle:const TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:16,
color:Color(0xff9e9e9e),
),
filled:true,
fillColor:const Color(0x00ffffff),
isDense:false,
contentPadding:const EdgeInsets.symmetric(vertical: 8,horizontal:12),
),
),
),
Padding(
padding:const EdgeInsets.fromLTRB(0, 16, 0, 30),
child:TextField(
controller:TextEditingController(),
obscureText:true,
textAlign:TextAlign.start,
maxLines:1,
style:const TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:16,
color:Color(0xffffffff),
),
decoration:InputDecoration(
disabledBorder:OutlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:const BorderSide(
color:Color(0xff9e9e9e),
width:1
),
),
focusedBorder:OutlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:const BorderSide(
color:Color(0xff9e9e9e),
width:1
),
),
enabledBorder:OutlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:const BorderSide(
color:Color(0xff9e9e9e),
width:1
),
),
labelText:"Confimar Senha",
labelStyle:const TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:16,
color:Color(0xff9e9e9e),
),
filled:true,
fillColor:const Color(0x00ffffff),
isDense:false,
contentPadding:const EdgeInsets.symmetric(vertical: 8,horizontal:12),
),
),
),
MaterialButton(
onPressed:(){},
color:const Color(0xff3a57e8),
elevation:0,
shape:RoundedRectangleBorder(
borderRadius:BorderRadius.circular(12.0),
side:const BorderSide(color:Color(0xff808080),width:1),
),
padding:const EdgeInsets.all(16),
textColor:const Color(0xffffffff),
height:40,
minWidth:MediaQuery.of(context).size.width,
child:const Text("Cadastrar", style: TextStyle( fontSize:16,
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
),),
),
Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.min,
children:[

const Padding(
padding:EdgeInsets.fromLTRB(0, 10, 0, 0),
child:Text(
"Já tem uma conta?",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xffffffff),
),
),
),
Padding(
padding:const EdgeInsets.fromLTRB(5, 10, 0, 0),
child: GestureDetector(
onTap: () => {
  Navigator.pop(context)
},
child:const Text(
"Login",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff9e9e9e),
),
),
)

),
],),
],),),),),
)
)
;}
}
