import 'package:flutter/material.dart';

void main() {
  runApp(AccountMarketApp());
}

class AccountMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Account Market',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color.fromARGB(255, 255, 81, 0)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AccountListScreen(),
    );
  }
}

class AccountListScreen extends StatelessWidget {
  final List<GameAccount> accounts = [
    GameAccount("Hoàng Văn Thìn", "Chào các bạn nhaaaa", 50),
    GameAccount("Nguyễn Thị Tươi", "hello xin chào chết cả các bạn", 70),
    GameAccount("Hoàng Thị Phương Thanh", "HIHIHHIHIHIH", 60),
    GameAccount("Hoàng Thị Phương Thanh", "Cho test tí đi", 60),
    GameAccount("Hoàng Đức Thuận",
        "Hello xin chào tất cả các bạn mình là Thuận nha", 60),
    GameAccount("Hoàng Thị Hồng Thơm", "Đẳng cấp nhề", 60),
    GameAccount("Hoàng Xuân Thịnh",
        "Hello xin chào tất cả các bạn đã quay trở lại", 60),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Accounts'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              title: Text(
                accounts[index].name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                accounts[index].description,
                style: TextStyle(fontSize: 16),
              ),
              trailing: Text(
                '\$${accounts[index].price.toString()}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Thêm vào giỏ hàng'),
                      content: Text('Thêm tài khoản vào giỏ hàng'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Hủy'),
                        ),
                        TextButton(
                          onPressed: () {
                            ShoppingCart.addAccount(accounts[index]);
                            Navigator.of(context).pop();
                          },
                          child: Text('Thêm vào giỏ hàng'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class AccountDetailScreen extends StatelessWidget {
  final GameAccount account;

  AccountDetailScreen({required this.account});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(account.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Description:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              account.description,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Price: \$${account.price.toString()}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class GameAccount {
  final String name;
  final String description;
  final int price;

  GameAccount(this.name, this.description, this.price);
}

class ShoppingCart {
  static List<GameAccount> _cartItems = [];

  static void addAccount(GameAccount account) {
    _cartItems.add(account);
  }

  static List<GameAccount> getCartItems() {
    return _cartItems;
  }

  static void clearCart() {
    _cartItems.clear();
  }
}

class ShoppingCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<GameAccount> cartItems = ShoppingCart.getCartItems();

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('Your shopping cart is empty!'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(cartItems[index].name),
                  subtitle: Text('\$${cartItems[index].price.toString()}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ShoppingCart.clearCart();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Your shopping cart has been cleared.'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Icon(Icons.clear),
      ),
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
