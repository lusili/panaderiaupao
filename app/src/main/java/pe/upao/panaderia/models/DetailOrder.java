package pe.upao.panaderia.models;

public class DetailOrder {

    private int id;
    private int id_order;
    private int id_product;
    private int quantity;
    private float price;

    public DetailOrder() {
    }

    public DetailOrder(int id, int id_order) {
        this.id = id;
        this.id_order = id_order;
    }

    public DetailOrder(int id, int id_order, int id_product, int quantity, float price) {
        this.id = id;
        this.id_order = id_order;
        this.id_product = id_product;
        this.quantity = quantity;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_order() {
        return id_order;
    }

    public void setId_order(int id_order) {
        this.id_order = id_order;
    }

    public int getId_product() {
        return id_product;
    }

    public void setId_product(int id_product) {
        this.id_product = id_product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public void aumentarCant(){
        this.quantity++;
    }
}
