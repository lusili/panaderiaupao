package pe.upao.panaderia.models;

public class Client {

    private int id_client;
    private String name;
    private String mail;
    private String phone;
    private String user;
    private String password;

    public Client() {

    }

    public Client(int id_client, String name, String mail, String phone, String user, String password) {
        this.id_client = id_client;
        this.name = name;
        this.mail = mail;
        this.phone = phone;
        this.user = user;
        this.password = password;
    }

    public int getId_client() {
        return id_client;
    }

    public void setId_client(int id_client) {
        this.id_client = id_client;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return super.toString();
    }
}
