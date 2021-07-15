import 'package:flutter/material.dart';
import 'package:flutter_gmcwallet/Screen/Login/Singup/FindID/components/ShapeClipper.dart';
import 'package:flutter_gmcwallet/Screen/Login/loginScreen.dart';
import 'package:flutter_gmcwallet/repository/repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'Mypage.dart';

class PwdChange extends StatefulWidget {
  const PwdChange({Key key}) : super(key: key);

  @override
  _PwdChangeState createState() => _PwdChangeState();
}

class _PwdChangeState extends State<PwdChange> {

  final _userRepository = UserRepository();
  final _oldPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  _onchangeButtonPressed()  {
    String _oldPassword = _oldPasswordController.text;
    String _password = _passwordController.text;
    String _confirmPassword = _confirmPasswordController.text;

    Pattern pattern = r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$';
    RegExp regExp = new RegExp(pattern);

    if(_password != _confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("확인 입력한 패스워드가 틀립니다. 확인바랍니다.", style: TextStyle(fontSize: 18))]),
        backgroundColor: Colors.red,
      ));
    } else if(!regExp.hasMatch(_passwordController.text)){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("비밀번호는 대소문자, 특수문자(!@#\$), 숫자로만 입력하세요.", style: TextStyle(fontSize: 18))
        ]),
        backgroundColor: Colors.red,
      ));
      _passwordController.text = "";
    } else {
      String email = "";

      _getEmail().then((val) =>
          setState(() {
            if (val == null) {
              Get.to(LoginScreen());
            } else {
              email = val.toString();
              _userRepository.changePassword(
                  email, _oldPassword, _password, _confirmPassword).then((
                  result) =>
                  setState(() {
                    print(result);
                    if (result == email) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 2),
                        content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("변경이 완료 되었습니다.",
                                  style: TextStyle(fontSize: 18))
                            ]),
                        backgroundColor: Colors.green,
                      ));
                      Get.to(MyPage());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 2),
                        content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("비밀번호가 틀렸습니다. 확인바랍니다.",
                                  style: TextStyle(fontSize: 18))
                            ]),
                        backgroundColor: Colors.red,
                      ));
                    }
                  }));
            }
          }));
    }
     // _getEmail().then((val) => () {
     //   String email = val.toString();
     //    _userRepository.changePassword(email, _oldPassword, _password, _confirmPassword).then((result) =>() {
     //        });
     //  });
  }

  Future<String> _getEmail() async{
    final FlutterSecureStorage storage = FlutterSecureStorage();
    return await storage.read(key: "User");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        Stack(children: [
          ClipPath(
            clipper: ShapeClipper2(),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffffb473), Color(0xffcc3494)])),
            ),
          ),
          Container(
            child: ClipPath(
              clipper: ShapeClipper1(),
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xffd25a7c), Color(0xfff9cc83)])),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Center(
                    child: Text(
                      "비밀번호 변경",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "현재 비밀번호",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 9,
                      offset: Offset(0, 2),
                    )
                  ]),
                  child: TextFormField(
                    controller: _oldPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "새로운 비밀번호",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 9,
                      offset: Offset(0, 2),
                    )
                  ]),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "새로운 비밀번호 재확인",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 9,
                      offset: Offset(0, 2),
                    )
                  ]),
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 90,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  colors: [Color(0xffd25a7c), Color(0xfff9cc83)]),
            ),
            child: TextButton(
              onPressed: () {
                _onchangeButtonPressed();
                //Get.to(LoginScreen());
              },
              child: Center(
                child: Text(
                  "변경 완료",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}



