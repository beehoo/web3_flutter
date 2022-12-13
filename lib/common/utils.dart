// 验证手机号格式
bool checkPhone (phone) {
  var pattern = r'^1[3456789]\d{9}$';
  var regex = RegExp(pattern);
  return regex.hasMatch(phone);
}