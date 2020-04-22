import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youtimizer/Modal/Shared.dart';
import 'package:youtimizer/Modal/CustomError.dart';
import 'package:youtimizer/Modal/User.dart';

final String url = 'http://youtimizer.com/wp-json/chart/v1';

class Authentication {
  /*
   * Login API.
   * */
  Future login(UserLogin login) async {
    var response = await http.post(
      '${url}/login',
      body: {
        'username': login.username,
        'password': login.password,
      },
    );
    if (response.statusCode == 503) {
      return throw new CustomError("Internal server error.");
    } else {
      final data = json.decode(response.body);
      Response result = Response.fromJSON(data);
      if (response.statusCode == 200) {
        Shared shared = Shared();
        shared.save(result.responseData.data['uid']);
        return result.responseData.data['uid'];
      } else {
        if (result.code == 'no_user') {
          throw new CustomError("Invalid username or password");
        }
        throw new CustomError("Something went wrong.Please try later.");
      }
    }
  }

  /*
  * User Register api.
  * */
  Future singup(Register register) async {
    var response = await http.post(
      '${url}/signup',
      body: {
        'username': register.username,
        'password': register.password,
        'cpassword': register.password,
        'fname': register.fname,
        'lname': register.lname,
        'email': register.email,
      },
    );
    if (response.statusCode == 503) {
      return throw new CustomError("Internal server error.");
    } else {
      final data = json.decode(response.body);

      Response result = Response.fromJSON(data);
      print("SATUS ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return result.msg;
      } else {
        print("RESUILT SIGNUP");
        if (result.code == 'existing_user_login') {
          throw new CustomError(result.msg);
        }
        if (result.code == 'existing_user_email') {
          throw new CustomError(result.msg);
        }
        throw new CustomError("Something went wrong.Please try later.");
      }
    }
  }

  /*
  * Forgot password api.
  * */
  Future forgotPassword({String email}) async {
    var response = await http.post(
      '${url}/forgot_password',
      body: {
        'email': email,
      },
    );
    if (response.statusCode == 503) {
      return throw new CustomError("Internal server error.");
    } else {
      final data = json.decode(response.body);
      Response result = Response.fromJSON(data);
      if (response.statusCode == 200) {
        return result.msg;
      } else {
        if (result.code == 'invalid_username') {
          throw new CustomError(result.msg);
        }
        throw new CustomError("Something went wrong.Please try later.");
      }
    }
  }

  /*
  * fetch home page data
  * */
  Future fetchHomeData(uid) async {
    try {
      var response = await http
          .get('${url}/get_table_data/${uid}');
      if (response.statusCode == 503) {
        return throw new CustomError("Internal server error.");
      } else {
        final data = json.decode(response.body);
        Response result = Response.fromJSON(data);
        if (response.statusCode == 200) {
          return result.responseData.data;
        } else {
          if (result.code == 'invalid_user') {
            throw new CustomError(result.msg);
          }
          throw new CustomError("Something went wrong.Please try later.");
        }
      }
    } catch (e) {}
  }

  /*
  * Future fetchDefualtValueData() async
  * Author: Sophie
  * Created Date & Time:  Apr 2 2020 8:34AM
  * 
  * Future: fetchDefaultValueData
  * Description:  fetch home page data
  * */
  Future fetchDefualtValueData() async {
    try {
      var response = await http
          .get('${url}/default_value');
      if (response.statusCode == 503) {
        return throw new CustomError("Internal server error.");
      } else {
        final data = json.decode(response.body);
        Response result = Response.fromJSON(data);
        if (response.statusCode == 200) {
          return result.responseData.data;
        } else {
          if (result.code == 'invalid_user') {
            throw new CustomError(result.msg);
          }
          throw new CustomError("Something went wrong.Please try later.");
        }
      }
    } catch (e) {}
  }

  /*
  * fetch home page data
  * */
  Future fetchYearGainTableData(uid, year) async {
    try {
      var response = await http
          .get('${url}/gain_table_year_data?id=${uid}&year=${year}');
      if (response.statusCode == 503) {
        return throw new CustomError("Internal server error.");
      } else {
        final data = json.decode(response.body);
        Response result = Response.fromJSON(data);
        if (response.statusCode == 200) {
          return result.responseData.data;
        } else {
          if (result.code == 'invalid_user') {
            throw new CustomError(result.msg);
          }
          throw new CustomError("Something went wrong.Please try later.");
        }
      }
    } catch (e) {}
  }

  /*
  * fetch home page data
  * */
  Future fetchGraphData(uid) async {
    try {
      var response = await http
          .get('${url}/chart_data/${uid}');
      if (response.statusCode == 503) {
        return throw new CustomError("Internal server error.");
      } else {
        final data = json.decode(response.body);
        Response result = Response.fromJSON(data);
        if (response.statusCode == 200) {
          return result.responseData.data;
        } else {
          if (result.code == 'invalid_user') {
            throw new CustomError(result.msg);
          }
          throw new CustomError("Something went wrong.Please try later.");
        }
      }
    } catch (e) {}
  }

  /*
  * fetch year graph data
  * */
  Future fetchYearGraphData(uid, year) async {
    try {
      var response = await http
          .get('${url}/chart_year_data?id=${uid}&year=${year}');
      if (response.statusCode == 503) {
        return throw new CustomError("Internal server error.");
      } else {
        final data = json.decode(response.body);
        Response result = Response.fromJSON(data);
        if (response.statusCode == 200) {
          return result.responseData.data;
        } else {
          if (result.code == 'invalid_user') {
            throw new CustomError(result.msg);
          }
          throw new CustomError("Something went wrong.Please try later.");
        }
      }
    } catch (e) {}
  }

  /*
  * fetch year data
  * */
  Future fetchYearData() async {
    try {
      var response = await http
          .get('${url}/club_all_years/');
      if (response.statusCode == 503) {
        return throw new CustomError("Internal server error.");
      } else {
        final data = json.decode(response.body);
        Response result = Response.fromJSON(data);
        if (response.statusCode == 200) {
          return result.responseData.data;
        } else {
          if (result.code == 'invalid_user') {
            throw new CustomError(result.msg);
          }
          throw new CustomError("Something went wrong.Please try later.");
        }
      }
    } catch (e) {}
  }

  /*
  * fetch gain year data
  * */
  Future fetchGainYearData(uid) async {
    try {
      var response = await http
          .get('${url}/gain_all_years/${uid}');
      if (response.statusCode == 503) {
        return throw new CustomError("Internal server error.");
      } else {
        final data = json.decode(response.body);
        Response result = Response.fromJSON(data);
        if (response.statusCode == 200) {
          return result.responseData.data;
        } else {
          if (result.code == 'invalid_user') {
            throw new CustomError(result.msg);
          }
          throw new CustomError("Something went wrong.Please try later.");
        }
      }
    } catch (e) {}
  }

  /*
  * fetch user data
  * */
  Future fetchUserData(uid) async {
    try {
      var response = await http
          .get('${url}/user_info/${uid}');
      if (response.statusCode == 503) {
        return throw new CustomError("Internal server error.");
      } else {
        final data = json.decode(response.body);
        Response result = Response.fromJSON(data);
        if (response.statusCode == 200) {
          return result.responseData.data;
        } else {
          if (result.code == 'invalid_user') {
            throw new CustomError(result.msg);
          }
          throw new CustomError("Something went wrong.Please try later.");
        }
      }
    } catch (e) {}
  }

  /*
  * Send betting tips
  * */
  Future sendBettingTip(BettingModal modal) async {
    try {
      var response = await http.post(
        '${url}/send_batting_app',
        body: {
          'fname': modal.fname,
          'lname': modal.lname,
          'text': modal.text,
          'email': modal.email
        },
      );
      if (response.statusCode == 503) {
        return throw new CustomError("Internal server error.");
      } else {
        final data = json.decode(response.body);
        Response result = Response.fromJSON(data);
        if (response.statusCode == 200) {
          return result.responseData.data;
        } else {
          if (result.code == 'invalid_user') {
            throw new CustomError(result.msg);
          }
          throw new CustomError("Something went wrong.Please try later.");
        }
      }
    } catch (e) {}
  }

  /*
  * Address data
  * */
  Future fetchAddressData() async {
    try {
      var response = await http.get(
        '${url}/get_app_footer',
      );
      if (response.statusCode == 503) {
        return throw new CustomError("Internal server error.");
      } else {
        final data = json.decode(response.body);
        Response result = Response.fromJSON(data);
        if (response.statusCode == 200) {
          return result.msg;
        } else {
          if (result.code == 'invalid_user') {
            throw new CustomError(result.msg);
          }
          throw new CustomError("Something went wrong.Please try later.");
        }
      }
    } catch (e) {}
  }
}
