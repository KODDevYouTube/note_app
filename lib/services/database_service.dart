import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {

  final supabase = Supabase.instance.client;

  database({query}) async {
    try{
      await query(supabase);
    } on PostgrestException catch(error) {
      debugPrint(error.message);
    } catch(error){
      debugPrint(error.toString());
    }
  }

}