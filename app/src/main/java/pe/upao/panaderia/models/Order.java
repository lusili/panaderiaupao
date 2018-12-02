package pe.upao.panaderia.models;

public class Order {

    private int id;
    private int id_client;
    private String date;
    private boolean status;

    public Order() {
    }

    public Order(int id, int id_client, String date) {
        this.id = id;
        this.id_client = id_client;
        this.date = date;
    }

    public Order(int id, String date) {
        this.id = id;
        this.date = date;
    }

    public Order(int id, int id_client, String date, boolean status) {
        this.id = id;
        this.id_client = id_client;
        this.date = date;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_client() {
        return id_client;
    }

    public void setId_client(int id_client) {
        this.id_client = id_client;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return super.toString();
    }
}
