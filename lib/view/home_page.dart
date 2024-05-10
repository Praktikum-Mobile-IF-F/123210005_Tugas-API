import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_api/view/detail_page.dart';
import 'package:tugas_api/view/login_page.dart';
import 'package:tugas_api/view/profile_page.dart';
import 'api_data_source.dart';
import 'agents_model.dart';

class HomePage extends StatelessWidget {
  late SharedPreferences logindata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Home",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                icon: Icon(Icons.person)),
            IconButton(
                onPressed: () async {
                  logindata = await SharedPreferences.getInstance();
                  logindata.remove("login");

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                icon: Icon(Icons.logout))
          ],
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Container(
            padding: EdgeInsets.all(8),
            child: _buildListAgentsBody()
        )
    );
  }

  Widget _buildListAgentsBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadAgents(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            AgentsModel agentsModel = AgentsModel.fromJson(snapshot.data);
            ;
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

  Widget _buildSuccessSection(AgentsModel data) {
    return GridView.builder(
      itemCount: data.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemUsers(context, data.data![index]);
      },
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }

  Widget _buildItemUsers(BuildContext context, Data agentData) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AgentDetailPage(
                    idAgent: agentData.uuid,
                  ))),
      child: Card(
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              child: Image.network(agentData.displayIcon!),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(agentData.displayName!),
                Text(agentData.role!.displayName!)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
