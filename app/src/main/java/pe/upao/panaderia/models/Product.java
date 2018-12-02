package pe.upao.panaderia.models;

/**
 * Created by on 23/09/18.
 */

public class Product {
    private int id;
    private String name;
    private String photo_url;
    private String quantity;
    private boolean featured;

    public Product() {
    }

    public Product(int id, String name, String photo_url, String quantity, boolean featured) {
        this.id = id;
        this.name = name;
        this.photo_url = photo_url;
        this.quantity = quantity;
        this.featured = featured;
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

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public boolean isFeatured() {
        return featured;
    }

    public void setFeatured(boolean featured) {
        this.featured = featured;
    }

    @Override
    public String toString() {
        return this.name;
    }
}
