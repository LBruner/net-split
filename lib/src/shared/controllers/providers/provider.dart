import 'package:flutter/material.dart';
import 'package:net_split/src/models/calculadora_model.dart';

class CalculatorState extends ChangeNotifier {
  // Input values
  String _inputIp = '';
  String _inputMask = '255.255.255.0';
  int _inputCidr = 24;
  bool get canCalculate {
    // Re-validate in case something changed without setting errors
    final ipValid = _isValidIp(_inputIp);
    final cidrValid = _isValidCidr(_inputCidr);
    return ipValid && cidrValid && _inputIp.isNotEmpty && liveCidrError == null;
  }

  SubnetCalculator? _calculator;
  SubnetCalculator? get calculator => _calculator;
  // Error states
  String? _ipError;
  String? _cidrError;
  String? _liveCidrError;

  // Calculation result
  // Getters
  String get inputIp => _inputIp;
  String get inputMask => _inputMask;
  int get inputCidr => _inputCidr;
  String? get ipError => _ipError;
  String? get cidrError => _cidrError;
  String? get liveCidrError => _liveCidrError;

  // Setters
  void setIp(String ip) {
    _inputIp = ip;
    _ipError = null; // Clear error when typing
    notifyListeners();
  }

  void updateCidrAndMask(int cidr) {
    if (!_isValidCidr(cidr)) {
      _cidrError = 'CIDR Inválido';
      return;
    }
    _inputCidr = cidr;
    _inputMask = _calculateMaskFromCIDR(
      cidr,
    ); // Make sure to define this method
    _cidrError = null;
    notifyListeners();
  }

  String _calculateMaskFromCIDR(int cidr) {
    String binaryMask = '1' * cidr + '0' * (32 - cidr);
    List<int> maskParts = [
      int.parse(binaryMask.substring(0, 8), radix: 2),
      int.parse(binaryMask.substring(8, 16), radix: 2),
      int.parse(binaryMask.substring(16, 24), radix: 2),
      int.parse(binaryMask.substring(24, 32), radix: 2),
    ];
    return maskParts.join('.');
  }

  void setMask(String mask) {
    _inputMask = mask;

    _cidrError = null;
    _liveCidrError = null;

    print(mask);
    notifyListeners();
  }

  void setCidr(int cidr) {
    if (!_isValidCidr(cidr)) {
      _cidrError = 'CIDR Inválido';
      return;
    }
    _inputCidr = cidr;
    _cidrError = null;
    notifyListeners();
  }

  void setIpError(String? error) {
    _ipError = error;
    notifyListeners();
  }

  void setCidrError(String? error) {
    _cidrError = error;
    notifyListeners();
  }

  bool _isValidIp(String ip) {
    final parts = ip.split('.');
    if (parts.length != 4) return false;

    for (final part in parts) {
      final number = int.tryParse(part);
      if (number == null || number < 0 || number > 255) {
        return false;
      }
    }
    return true;
  }

  bool _isValidCidr(int cidr) {
    return cidr > 0 && cidr <= 32 && cidr == cidr.roundToDouble();
  }

  // Live validation for CIDR
  void validateCidrLive(String input) {
    _liveCidrError =
        _isValidCidr(int.parse(input)) || input.isEmpty ? null : 'Entre 1-32';
    notifyListeners();
  }

  // Main calculation function
  void calculateSubnet() {
    if (!_isValidIp(_inputIp)) {
      setIpError('Endereço Inválido');
      return;
    }

    if (!_isValidCidr(_inputCidr)) {
      setCidrError('Entre 1-32');
      return;
    }

    _ipError = null;
    _cidrError = null;
    _liveCidrError = null;

    notifyListeners();
  }

  // Reset all fields
  void reset() {
    _inputIp = '192.168.1.1';
    _inputMask = '255.255.255.0';
    _inputCidr = 24;
    _ipError = null;
    _cidrError = null;
    _liveCidrError = null;
    notifyListeners();
  }
}
