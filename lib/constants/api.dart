




class Api{
  //static const baseUrl = 'https://shop-site-i4z0.onrender.com/api';
  static const baseUrl = 'http://192.168.0.102:5000/api';


  /// auth apis
  static const userLogin = '$baseUrl/userLogin';
  static const userRegister = '$baseUrl/userRegister';

/// product apis
  static const getProducts = '$baseUrl/products';
  static const addProduct = '$baseUrl/createProduct';
  static const upDateProduct = '$baseUrl/productUpdate';
  static const commonProduct = '$baseUrl/product';

}