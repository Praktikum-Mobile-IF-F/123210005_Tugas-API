import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();
  Future<Map<String, dynamic>> loadAgents() {
    // Ada beberapa data yang duplicate, dapat dfilter dengan isPlayableCharacter
    return BaseNetwork.get("agents?isPlayableCharacter=true");
  }

  Future<Map<String, dynamic>> loadDetailAgents(String? idDiterima) {
    // String id = idDiterima.toString();
    return BaseNetwork.get("agents/$idDiterima");
  }
}
