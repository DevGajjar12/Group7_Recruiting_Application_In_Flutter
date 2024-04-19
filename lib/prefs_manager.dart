import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsRepo {
  static const apply = 'apply';

  Future<void> setApply({required JobApply data}) async {
    List<JobApply> applyList = await getApply();

    // Remove existing entry with the same name
    applyList.removeWhere((job) => job.name == data.name);

    // Add the new entry
    applyList.add(JobApply(apply: data.apply, name: data.name));

    List<String> jsonStringList = applyList.map((result) {
      return jsonEncode(result.toJson());
    }).toList();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(apply, jsonStringList);
  }

  Future<void> removeApply(String name) async {
    List<JobApply> applyList = await getApply();
    applyList.removeWhere((job) => job.name == name);

    List<String> jsonStringList = applyList.map((result) {
      return jsonEncode(result.toJson());
    }).toList();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(apply, jsonStringList);
  }

  Future<void> clearAllApplied() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(apply);
  }

  Future<List<JobApply>> getApply() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList(apply);

    if (jsonStringList == null) {
      return [];
    }

    List<JobApply> applyList = jsonStringList.map((jsonString) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return JobApply.fromJson(jsonMap);
    }).toList();

    return applyList;
  }
}

class JobApply {
  final bool apply;
  final String name;

  JobApply({required this.apply, required this.name});

  factory JobApply.fromJson(Map<String, dynamic> json) {
    return JobApply(apply: json['apply'] ?? false, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'apply': apply, 'name': name};
  }
}
