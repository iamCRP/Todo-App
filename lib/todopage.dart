import 'package:demo_app/stdmodel.dart';
import 'package:flutter/material.dart';

class Todopage extends StatefulWidget {
  const Todopage({super.key});

  @override
  State<Todopage> createState() => _TodopageState();
}

class _TodopageState extends State<Todopage> {
  List<Usermodel> userList = [Usermodel(name: "Hii GUYS", isfun: false)];
  final TextEditingController inputName = TextEditingController();

  void addUser(String name) {
    if (name.trim().isEmpty) return;
    var addU = Usermodel(name: name, isfun: false);
    setState(() {
      userList.add(addU);
    });
    inputName.clear();
  }

  void deletUser(String deleteName) {
    setState(() {
      userList.removeWhere((e) => e.name == deleteName);
    });
  }

  void taskUser(String comUser) {
    for (var e in userList) {
      if (e.name == comUser) {
        setState(() {
          e.isfun = !e.isfun!;
        });
      }
    }
  }

  void updateUser(Usermodel updateName) {
    TextEditingController updateControl = TextEditingController(
      text: updateName.name,
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Update Todo"),
        content: TextField(
          controller: updateControl,
          decoration: const InputDecoration(
            hintText: "Enter new name",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              setState(() {
                updateName.name = updateControl.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        elevation: 5,
        title: const Text(
          "Todo App",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenW * 0.04),
        child: Column(
          children: [
            // Input Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(screenW * 0.04),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: inputName,
                        decoration: InputDecoration(
                          hintText: "Enter todo...",
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenW * 0.02),
                    ElevatedButton(
                      onPressed: () => addUser(inputName.text),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        padding: EdgeInsets.symmetric(
                          vertical: screenH * 0.018,
                          horizontal: screenW * 0.04,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: screenH * 0.02),

            // Todo List Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Your Todos",
                style: TextStyle(
                  fontSize: screenW * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: screenH * 0.01),

            Expanded(
              child: userList.isEmpty
                  ? const Center(
                      child: Text(
                        "No Todo Added Yet",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        final e = userList[index];
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(
                            vertical: screenH * 0.008,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () => taskUser(e.name!),
                              child: CircleAvatar(
                                backgroundColor: e.isfun!
                                    ? Colors.green.shade300
                                    : Colors.grey.shade200,
                                radius: screenW * 0.06,
                                child: Icon(
                                  e.isfun!
                                      ? Icons.check
                                      : Icons.circle_outlined,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ),
                            title: Text(
                              e.name!,
                              style: TextStyle(
                                fontSize: screenW * 0.05,
                                fontWeight: FontWeight.w600,
                                decoration: e.isfun!
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: e.isfun!
                                    ? Colors.black45
                                    : Colors.black87,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blueAccent,
                                  ),
                                  onPressed: () => updateUser(e),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () => deletUser(e.name!),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
