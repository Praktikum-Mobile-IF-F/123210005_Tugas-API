import 'package:flutter/material.dart';
import 'agent_detail_model.dart';
import 'api_data_source.dart';

class AgentDetailPage extends StatelessWidget {
  final String? idAgent;

  const AgentDetailPage({Key? key, required this.idAgent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Detail Agent", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: _buildDetailAgentBody(),
    );
  }

  Widget _buildDetailAgentBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadDetailAgents(idAgent),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            DetailAgentModel agentsModel =
                DetailAgentModel.fromJson(snapshot.data);
            return _buildSuccessSection(agentsModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(DetailAgentModel data) {
    return Center(
      child: Container(
        color: Colors.grey,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(data.data!.displayIcon!),
            SizedBox(
              height: 16,
            ),
            Text(data.data!.displayName!),
            SizedBox(
              height: 16,
            ),
            Text(data.data!.description!),
            SizedBox(
              height: 16,
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: data.data!.abilities!.length,
                  itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(data.data!.abilities![index].displayName!),
                    subtitle: Text(data.data!.abilities![index].description!),
                    leading:
                      Image.network(data.data!.abilities![index].displayIcon!),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
