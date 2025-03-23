import 'dart:math';

class SubnetCalculator {
  String ip;
  String mask;

  SubnetCalculator(this.ip, this.mask);

  List<int> _ipToList(String ip) {
    return ip.split('.').map(int.parse).toList();
  }

  String _listToIp(List<int> list) {
    return list.join('.');
  }

  int _ipToInteger(String ip) {
    List<int> parts = _ipToList(ip);
    return (parts[0] << 24) + (parts[1] << 16) + (parts[2] << 8) + parts[3];
  }

  String getNetworkAddress() {
    List<int> ipParts = _ipToList(ip);
    List<int> maskParts = _ipToList(mask);
    List<int> networkParts = List.generate(4, (i) => ipParts[i] & maskParts[i]);
    return _listToIp(networkParts);
  }

  String getBroadcastAddress() {
    List<int> ipParts = _ipToList(ip);
    List<int> maskParts = _ipToList(mask);
    List<int> broadcastParts = List.generate(
      4,
      (i) => ipParts[i] | (255 - maskParts[i]),
    );
    return _listToIp(broadcastParts);
  }

  int getTotalHosts() {
    int maskBits =
        _ipToList(mask)
            .map((e) => e.toRadixString(2).padLeft(8, '0'))
            .join()
            .split('')
            .where((bit) => bit == '1')
            .length;
    return pow(2, (32 - maskBits)).toInt();
  }

  String getUsableHostRange() {
    List<int> networkParts = _ipToList(getNetworkAddress());
    List<int> broadcastParts = _ipToList(getBroadcastAddress());

    if (getTotalHosts() <= 2) {
      return "No usable hosts";
    }

    networkParts[3] += 1;
    broadcastParts[3] -= 1;

    return "${_listToIp(networkParts)} - ${_listToIp(broadcastParts)}";
  }

  String getWildcardMask() {
    List<int> maskParts = _ipToList(mask);
    List<int> wildcardParts = List.generate(4, (i) => 255 - maskParts[i]);
    return _listToIp(wildcardParts);
  }

  String getBinarySubnetMask() {
    return _ipToList(
      mask,
    ).map((e) => e.toRadixString(2).padLeft(8, '0')).join('.');
  }

  String getCIDRNotation() {
    int prefix =
        _ipToList(mask)
            .map((e) => e.toRadixString(2).padLeft(8, '0'))
            .join()
            .split('')
            .where((bit) => bit == '1')
            .length;
    return "/$prefix";
  }

  String getIPClass() {
    int firstOctet = _ipToList(ip)[0];
    if (firstOctet >= 1 && firstOctet <= 126) return "Class A";
    if (firstOctet >= 128 && firstOctet <= 191) return "Class B";
    if (firstOctet >= 192 && firstOctet <= 223) return "Class C";
    if (firstOctet >= 224 && firstOctet <= 239) return "Class D (Multicast)";
    return "Class E (Reserved)";
  }

  String getIPType() {
    List<int> ipParts = _ipToList(ip);
    if (ipParts[0] == 10 ||
        (ipParts[0] == 172 && ipParts[1] >= 16 && ipParts[1] <= 31) ||
        (ipParts[0] == 192 && ipParts[1] == 168)) {
      return "Private";
    }
    return "Public";
  }

  String getShortNotation() {
    return "$ip${getCIDRNotation()}";
  }

  String getBinaryID() {
    return _ipToList(
      ip,
    ).map((e) => e.toRadixString(2).padLeft(8, '0')).join('');
  }

  String getIntegerID() {
    return _ipToInteger(ip).toString();
  }

  String getHexID() {
    return "0x${_ipToInteger(ip).toRadixString(16).toUpperCase()}";
  }

  String getInAddrArpa() {
    return _ipToList(ip).reversed.join('.') + ".in-addr.arpa";
  }

  String getIPv4MappedAddress() {
    return "::ffff:$ip";
  }

  String get6to4Prefix() {
    List<int> ipParts = _ipToList(ip);
    int intIp = _ipToInteger(ip);
    return "2002:${((intIp >> 16) & 0xFFFF).toRadixString(16)}:${(intIp & 0xFFFF).toRadixString(16)}::/48";
  }

  void printAll() {
    print("IP Address: $ip");
    print("Network Address: ${getNetworkAddress()}");
    print("Usable Host IP Range: ${getUsableHostRange()}");
    print("Broadcast Address: ${getBroadcastAddress()}");
    print("Total Number of Hosts: ${getTotalHosts()}");
    print("Subnet Mask: $mask");
    print("Wildcard Mask: ${getWildcardMask()}");
    print("Binary Subnet Mask: ${getBinarySubnetMask()}");
    print("IP Class: ${getIPClass()}");
    print("CIDR Notation: ${getCIDRNotation()}");
    print("IP Type: ${getIPType()}");
    print("Short Notation: ${getShortNotation()}");
    print("Binary ID: ${getBinaryID()}");
    print("Integer ID: ${getIntegerID()}");
    print("Hex ID: ${getHexID()}");
    print("in-addr.arpa: ${getInAddrArpa()}");
    print("IPv4 Mapped Address: ${getIPv4MappedAddress()}");
    print("6to4 Prefix: ${get6to4Prefix()}");
  }
}
