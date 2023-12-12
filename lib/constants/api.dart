




class Api{
  static const baseUrl = 'https://shop-server-sw10.onrender.com/api';
  //static const baseUrl = 'http://192.168.0.102:5000/api';


  /// auth apis
  static const userLogin = '$baseUrl/userLogin';
  static const userRegister = '$baseUrl/userRegister';
  static const userUpdate = '$baseUrl/userUpdate';

/// product apis
  static const getProducts = '$baseUrl/products';
  static const addProduct = '$baseUrl/createProduct';
  static const upDateProduct = '$baseUrl/productUpdate';
  static const commonProduct = '$baseUrl/product';


  /// order apis
  static const getAllOrders = '$baseUrl/orders';
  static const addOrder = '$baseUrl/createOrder';
  static const orderByUser = '$baseUrl/user/order';
  static const getOrderDetail = '$baseUrl/api/order';

}