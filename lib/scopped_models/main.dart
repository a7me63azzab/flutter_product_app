import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_course/scopped_models/connected_products.dart';

class MainModel extends Model
    with ConnectedProductsModel, UserModel, ProductsModel, UtilityModel {}
