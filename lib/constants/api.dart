




class Api{
  static const baseUrl = 'http://192.168.0.102:5000/api';


  /// auth apis
  static const userLogin = '$baseUrl/userLogin';
  static const userRegister = '$baseUrl/userSignUp';

/// product apis
  static const getProducts = '$baseUrl/products';
  static const addProduct = '$baseUrl/create-product';

}