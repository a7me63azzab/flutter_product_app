import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_course/scopped_models/products.dart';
import 'package:flutter_course/scopped_models/user.dart';

class MainModel extends Model with UserModel, ProductsModel {}
