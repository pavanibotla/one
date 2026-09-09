import java.util.*;

// Base Product class
abstract class Product {
    private String id;
    private String name;
    private double price;

    public Product(String id, String name, double price) {
        this.id = id;
        this.name = name;
        this.price = price;
    }

    public String getId() { return id; }
    public String getName() { return name; }
    public double getPrice() { return price; }

    public abstract String getCategory();

    @Override
    public String toString() {
        return String.format("[%s] %s (%s) - $%.2f", id, name, getCategory(), price);
    }
}

// Electronics subclass
class Electronic extends Product {
    private String brand;
    private int warrantyMonths;

    public Electronic(String id, String name, double price, String brand, int warrantyMonths) {
        super(id, name, price);
        this.brand = brand;
        this.warrantyMonths = warrantyMonths;
    }

    @Override
    public String getCategory() {
        return "Electronics";
    }
}

// Appliance subclass
class Appliance extends Product {
    private String energyRating;

    public Appliance(String id, String name, double price, String energyRating) {
        super(id, name, price);
        this.energyRating = energyRating;
    }

    @Override
    public String getCategory() {
        return "Appliances";
    }
}

// Inventory system tracking stock levels
class Inventory {
    private Map<String, Product> products = new HashMap<>();
    private Map<String, Integer> stock = new HashMap<>();

    public void addProduct(Product product, int quantity) {
        products.put(product.getId(), product);
        stock.put(product.getId(), stock.getOrDefault(product.getId(), 0) + quantity);
    }

    public Product getProduct(String id) {
        return products.get(id);
    }

    public boolean isAvailable(String id, int quantity) {
        return stock.getOrDefault(id, 0) >= quantity;
    }

    public void reduceStock(String id, int quantity) {
        if (isAvailable(id, quantity)) {
            stock.put(id, stock.get(id) - quantity);
        }
    }

    public void displayCatalog() {
        System.out.println("=== Best Buy Product Catalog ===");
        for (Product p : products.values()) {
            int qty = stock.get(p.getId());
            System.out.printf("%s | In Stock: %d\n", p, qty);
        }
    }
}

// Shopping Cart item wrapper
class CartItem {
    private Product product;
    private int quantity;

    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    public Product getProduct() { return product; }
    public int getQuantity() { return quantity; }
    public double getTotalPrice() { return product.getPrice() * quantity; }
}

// User's Shopping Cart
class ShoppingCart {
    private List<CartItem> items = new ArrayList<>();

    public void addItem(Product product, int quantity) {
        items.add(new CartItem(product, quantity));
        System.out.printf("Added %dx %s to cart.\n", quantity, product.getName());
    }

    public List<CartItem> getItems() { return items; }

    public double calculateSubtotal() {
        double subtotal = 0;
        for (CartItem item : items) {
            subtotal += item.getTotalPrice();
        }
        return subtotal;
    }
}

// Order processing engine
class OrderEngine {
    private static final double TAX_RATE = 0.08; // 8% sales tax

    public static void checkout(ShoppingCart cart, Inventory inventory) {
        System.out.println("\n=== Processing Checkout ===");
        
        // Stock verification
        for (CartItem item : cart.getItems()) {
            if (!inventory.isAvailable(item.getProduct().getId(), item.getQuantity())) {
                System.out.printf("Error: Item %s is out of stock in requested quantity.\n", item.getProduct().getName());
                return;
            }
        }

        // Deduct inventory
        for (CartItem item : cart.getItems()) {
            inventory.reduceStock(item.getProduct().getId(), item.getQuantity());
        }

        // Receipt generation
        double subtotal = cart.calculateSubtotal();
        double tax = subtotal * TAX_RATE;
        double total = subtotal + tax;

        System.out.println("\n---------------- ORDER RECEIPT ----------------");
        for (CartItem item : cart.getItems()) {
            System.out.printf("%-30s x%d  $%.2f\n", item.getProduct().getName(), item.getQuantity(), item.getTotalPrice());
        }
        System.out.println("----------------------------------------------");
        System.out.printf("Subtotal: $%.2f\n", subtotal);
        System.out.printf("Tax (8%%): $%.2f\n", tax);
        System.out.printf("Total:    $%.2f\n", total);
        System.out.println("----------------------------------------------");
        System.out.println("Order placed successfully! Thank you for shopping with us.");
    }
}

// Application Entry Point
public class Main {
    public static void main(String[] args) {
        // Setup inventory
        Inventory inventory = new Inventory();
        
        Product tv = new Electronic("TV-4K-65", "LG 65\" OLED 4K TV", 1499.99, "LG", 24);
        Product laptop = new Electronic("LAP-MBP-16", "MacBook Pro 16\"", 2499.99, "Apple", 12);
        Product fridge = new Appliance("APP-REF-01", "Samsung French Door Refrigerator", 1999.99, "EnergyStar A++");

        inventory.addProduct(tv, 5);
        inventory.addProduct(laptop, 10);
        inventory.addProduct(fridge, 2);

        // Display catalog
        inventory.displayCatalog();

        // Customer behavior simulation
        System.out.println("\n--- Customer Action ---");
        ShoppingCart userCart = new ShoppingCart();
        userCart.addItem(tv, 1);
        userCart.addItem(laptop, 2);

        // Process order
        OrderEngine.checkout(userCart, inventory);

        // Show remaining inventory stock
        System.out.println();
        inventory.displayCatalog();
    }
}
