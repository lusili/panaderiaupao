package pe.upao.panaderia.models;

public class Product {
    private int id;
    private String name;
    private String photo_url;
    private int quantity;
    private boolean featured;
    private float price;

    public Product(int id, String name, String photo_url, int quantity, boolean featured) {
        this.id = id;
        this.name = name;
        this.photo_url = photo_url;
        this.quantity = quantity;
        this.featured = featured;
    }

    public Product(int id, String name, String photo_url, int quantity, boolean featured, float price) {
        this.id = id;
        this.name = name;
        this.photo_url = photo_url;
        this.quantity = quantity;
        this.featured = featured;
        this.price = price;
    }

    public Product() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoto_url() {
        return photo_url;
    }

    public void setPhoto_url(String photo_url) {
        this.photo_url = photo_url;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public boolean isFeatured() {
        return featured;
    }

    public void setFeatured(boolean featured) {
        this.featured = featured;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return this.name;
    }
}
