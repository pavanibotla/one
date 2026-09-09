import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class TechBuy {

    // =========================
    // PRODUCT CLASS
    // =========================
    static class Product {

        private int id;
        private String name;
        private String category;
        private double price;
        private double rating;
        private int stock;

        public Product(int id, String name, String category,
                       double price, double rating, int stock) {

            this.id = id;
            this.name = name;
            this.category = category;
            this.price = price;
            this.rating = rating;
            this.stock = stock;
        }

        public int getId() {
            return id;
        }

        public String getName() {
            return name;
        }

        public String getCategory() {
            return category;
        }

        public double getPrice() {
            return price;
        }

        public double getRating() {
            return rating;
        }

        public int getStock() {
            return stock;
        }

        public void reduceStock() {
            if (stock > 0) {
                stock--;
            }
        }

        public void increaseStock() {
            stock++;
        }

        public void displayProduct() {

            System.out.println(
                    "ID       : " + id +
                    "\nProduct  : " + name +
                    "\nCategory : " + category +
                    "\nPrice    : ₹" + price +
                    "\nRating   : ⭐ " + rating +
                    "\nStock    : " + stock
            );

            System.out.println("--------------------------------");
        }
    }


    // =========================
    // CART ITEM CLASS
    // =========================
    static class CartItem {

        private Product product;
        private int quantity;

        public CartItem(Product product) {

            this.product = product;
            this.quantity = 1;
        }

        public Product getProduct() {
            return product;
        }

        public int getQuantity() {
            return quantity;
        }

        public void increaseQuantity() {
            quantity++;
        }

        public void decreaseQuantity() {
            if (quantity > 1) {
                quantity--;
            }
        }

        public double getTotal() {
            return product.getPrice() * quantity;
        }
    }


    // =========================
    // TECHBUY STORE
    // =========================
    static class Store {

        private List<Product> products;
        private List<CartItem> cart;

        public Store() {

            products = new ArrayList<>();
            cart = new ArrayList<>();

            loadProducts();
        }


        // =========================
        // PRODUCTS
        // =========================
        private void loadProducts() {

            products.add(
                    new Product(
                            101,
                            "iPhone 15",
                            "Cell Phones",
                            69999,
                            4.8,
                            20
                    )
            );

            products.add(
                    new Product(
                            102,
                            "Samsung Galaxy S24",
                            "Cell Phones",
                            74999,
                            4.7,
                            15
                    )
            );

            products.add(
                    new Product(
                            103,
                            "MacBook Air M3",
                            "Computers & Tablets",
                            99999,
                            4.9,
                            10
                    )
            );

            products.add(
                    new Product(
                            104,
                            "HP Pavilion Laptop",
                            "Computers & Tablets",
                            64999,
                            4.5,
                            12
                    )
            );

            products.add(
                    new Product(
                            105,
                            "Sony 55 Inch 4K TV",
                            "TV & Home Theater",
                            64999,
                            4.6,
                            8
                    )
            );

            products.add(
                    new Product(
                            106,
                            "Samsung 65 Inch Smart TV",
                            "TV & Home Theater",
                            89999,
                            4.7,
                            6
                    )
            );

            products.add(
                    new Product(
                            107,
                            "Sony WH-1000XM5",
                            "Headphones & Audio",
                            29999,
                            4.8,
                            25
                    )
            );

            products.add(
                    new Product(
                            108,
                            "Apple AirPods Pro",
                            "Headphones & Audio",
                            24999,
                            4.8,
                            30
                    )
            );

            products.add(
                    new Product(
                            109,
                            "PlayStation 5",
                            "Gaming",
                            54999,
                            4.9,
                            12
                    )
            );

            products.add(
                    new Product(
                            110,
                            "Xbox Series X",
                            "Gaming",
                            49999,
                            4.8,
                            10
                    )
            );

            products.add(
                    new Product(
                            111,
                            "Canon EOS Camera",
                            "Cameras",
                            79999,
                            4.6,
                            7
                    )
            );

            products.add(
                    new Product(
                            112,
                            "Apple Watch Series 9",
                            "Smart Home",
                            42999,
                            4.7,
                            18
                    )
            );
        }


        // =========================
        // DISPLAY ALL PRODUCTS
        // =========================
        public void showProducts() {

            System.out.println("\n=================================");
            System.out.println("       TECHBUY PRODUCTS");
            System.out.println("=================================");

            for (Product product : products) {

                product.displayProduct();
            }
        }


        // =========================
        // FIND PRODUCT
        // =========================
        public Product findProduct(int id) {

            for (Product product : products) {

                if (product.getId() == id) {
                    return product;
                }
            }

            return null;
        }


        // =========================
        // SEARCH PRODUCT
        // =========================
        public void searchProduct(String keyword) {

            boolean found = false;

            System.out.println("\n=================================");
            System.out.println("        SEARCH RESULTS");
            System.out.println("=================================");

            for (Product product : products) {

                if (product.getName()
                        .toLowerCase()
                        .contains(keyword.toLowerCase())
                        ||
                    product.getCategory()
                        .toLowerCase()
                        .contains(keyword.toLowerCase())) {

                    product.displayProduct();

                    found = true;
                }
            }

            if (!found) {

                System.out.println(
                        "❌ No products found for: " + keyword
                );
            }
        }


        // =========================
        // SHOW CATEGORIES
        // =========================
        public void showCategories() {

            System.out.println("\n=================================");
            System.out.println("       TECHBUY CATEGORIES");
            System.out.println("=================================");

            System.out.println("1. Cell Phones");
            System.out.println("2. Computers & Tablets");
            System.out.println("3. TV & Home Theater");
            System.out.println("4. Gaming");
            System.out.println("5. Headphones & Audio");
            System.out.println("6. Cameras");
            System.out.println("7. Smart Home");
        }


        // =========================
        // ADD TO CART
        // =========================
        public void addToCart(int productId) {

            Product product = findProduct(productId);

            if (product == null) {

                System.out.println(
                        "❌ Product not found."
                );

                return;
            }

            if (product.getStock() <= 0) {

                System.out.println(
                        "❌ Product is out of stock."
                );

                return;
            }


            // Check whether product already exists
            // in cart
            for (CartItem item : cart) {

                if (item.getProduct().getId() == productId) {

                    item.increaseQuantity();

                    product.reduceStock();

                    System.out.println(
                            "✅ Quantity increased: "
                            + product.getName()
                    );

                    return;
                }
            }


            // New product
            cart.add(new CartItem(product));

            product.reduceStock();

            System.out.println(
                    "✅ Added to cart: "
                    + product.getName()
            );
        }


        // =========================
        // REMOVE FROM CART
        // =========================
        public void removeFromCart(int productId) {

            for (CartItem item : cart) {

                if (item.getProduct().getId() == productId) {

                    if (item.getQuantity() > 1) {

                        item.decreaseQuantity();

                        item.getProduct().increaseStock();

                        System.out.println(
                                "✅ Quantity reduced."
                        );

                    } else {

                        item.getProduct().increaseStock();

                        cart.remove(item);

                        System.out.println(
                                "✅ Product removed from cart."
                        );
                    }

                    return;
                }
            }

            System.out.println(
                    "❌ Product is not in cart."
            );
        }


        // =========================
        // SHOW CART
        // =========================
        public void showCart() {

            if (cart.isEmpty()) {

                System.out.println(
                        "\n🛒 Your cart is empty."
                );

                return;
            }


            System.out.println("\n=================================");
            System.out.println("          YOUR CART");
            System.out.println("=================================");

            double total = 0;

            for (CartItem item : cart) {

                Product product = item.getProduct();

                double itemTotal = item.getTotal();

                System.out.println(
                        product.getName()
                        + " | Quantity: "
                        + item.getQuantity()
                        + " | ₹"
                        + itemTotal
                );

                total += itemTotal;
            }

            System.out.println("---------------------------------");

            System.out.println(
                    "TOTAL: ₹" + total
            );

            System.out.println("=================================");
        }


        // =========================
        // CART TOTAL
        // =========================
        public double getCartTotal() {

            double total = 0;

            for (CartItem item : cart) {

                total += item.getTotal();
            }

            return total;
        }


        // =========================
        // CHECKOUT
        // =========================
        public void checkout() {

            if (cart.isEmpty()) {

                System.out.println(
                        "❌ Cart is empty."
                );

                return;
            }

            double total = getCartTotal();

            System.out.println("\n=================================");
            System.out.println("           CHECKOUT");
            System.out.println("=================================");

            showCart();

            System.out.println(
                    "\nPayment Options:"
            );

            System.out.println("1. UPI");
            System.out.println("2. Credit/Debit Card");
            System.out.println("3. Cash on Delivery");

            Scanner scanner = new Scanner(System.in);

            System.out.print(
                    "Choose payment method: "
            );

            int payment =
                    scanner.nextInt();

            switch (payment) {

                case 1:
                    System.out.println(
                            "Payment selected: UPI"
                    );
                    break;

                case 2:
                    System.out.println(
                            "Payment selected: Card"
                    );
                    break;

                case 3:
                    System.out.println(
                            "Payment selected: Cash on Delivery"
                    );
                    break;

                default:
                    System.out.println(
                            "Invalid payment option."
                    );
                    return;
            }

            System.out.println(
                    "\n✅ Order placed successfully!"
            );

            System.out.println(
                    "Order Amount: ₹" + total
            );

            System.out.println(
                    "Thank you for shopping with TechBuy!"
            );

            cart.clear();
        }
    }


    // =========================
    // MAIN METHOD
    // =========================
    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);

        Store store = new Store();

        boolean running = true;


        while (running) {

            System.out.println("\n");
            System.out.println("======================================");
            System.out.println("              TECHBUY");
            System.out.println("       Electronics Shopping");
            System.out.println("======================================");

            System.out.println("1. View All Products");
            System.out.println("2. View Categories");
            System.out.println("3. Search Product");
            System.out.println("4. Add Product to Cart");
            System.out.println("5. Remove Product from Cart");
            System.out.println("6. View Cart");
            System.out.println("7. Checkout");
            System.out.println("8. Exit");

            System.out.println("--------------------------------------");

            System.out.print(
                    "Enter your choice: "
            );

            int choice = scanner.nextInt();


            switch (choice) {

                case 1:

                    store.showProducts();

                    break;


                case 2:

                    store.showCategories();

                    break;


                case 3:

                    scanner.nextLine();

                    System.out.print(
                            "Enter product name/category: "
                    );

                    String keyword =
                            scanner.nextLine();

                    store.searchProduct(keyword);

                    break;


                case 4:

                    System.out.print(
                            "Enter Product ID: "
                    );

                    int addId =
                            scanner.nextInt();

                    store.addToCart(addId);

                    break;


                case 5:

                    System.out.print(
                            "Enter Product ID to remove: "
                    );

                    int removeId =
                            scanner.nextInt();

                    store.removeFromCart(removeId);

                    break;


                case 6:

                    store.showCart();

                    break;


                case 7:

                    store.checkout();

                    break;


                case 8:

                    running = false;

                    System.out.println(
                            "\nThank you for visiting TechBuy!"
                    );

                    break;


                default:

                    System.out.println(
                            "❌ Invalid choice. Please try again."
                    );
            }
        }

        scanner.close();
    }
}
