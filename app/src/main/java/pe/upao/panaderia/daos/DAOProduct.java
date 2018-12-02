package pe.upao.panaderia.daos;

import java.util.ArrayList;
import java.util.List;

import pe.upao.panaderia.models.Product;

public class DAOProduct {

    // https://pastebin.com/DABd3870
    private static ArrayList<Product> products = new ArrayList<>();
    private static int INDEX = 0;

    public DAOProduct() {
    }

    public void save(Product product){
        if(product.getId()==-1) {
            product.setId(INDEX++);
            products.add(product);
        }else{
            delete(product.getId());
            products.add(product);
        }
    }

    public List<Product> all(){
        return products;
    }

    public void delete(int id){
        for(int i=0;i<products.size();i++){
            if(products.get(i).getId()==id){
                products.remove(i);
            }
        }
    }

    public Product get(int id){
        for(int i=0;i<products.size();i++){
            if(products.get(i).getId()==id){
                return products.get(i);
            }
        }
        return null;
    }
}
