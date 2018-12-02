package pe.upao.panaderia;

import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.GridView;
import android.widget.ImageButton;
import android.widget.SearchView;
import android.widget.Toast;

import java.text.SimpleDateFormat;
import java.util.Date;

import androidx.appcompat.app.AppCompatActivity;
import pe.upao.panaderia.adapters.ProductGridAdapter;
import pe.upao.panaderia.daos.DAOSQLDetailOrder;
import pe.upao.panaderia.daos.DAOSQLOrder;
import pe.upao.panaderia.daos.DAOSQLProduct;
import pe.upao.panaderia.models.Order;
import pe.upao.panaderia.models.Product;
import pe.upao.panaderia.utils.DeliverySharedPreferences;

public class MainActivity extends AppCompatActivity {
    private DeliverySharedPreferences prefs;

    private SearchView txtSearcher;
    private GridView lstProducts;
    private ImageButton btnRefresh;
    private DAOSQLProduct dao_Product;
    private DAOSQLOrder dao_Order;
    private DAOSQLDetailOrder        dao_DetOrder;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        //theme view splash
        setTheme(R.style.AppTheme);

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        prefs = new DeliverySharedPreferences(this); // creo mis preferencias

        txtSearcher = (SearchView) findViewById(R.id.Searcher);
        lstProducts = findViewById(R.id.lstProducts);
        btnRefresh = findViewById(R.id.btnBuscaActulz);

        dao_Product = new DAOSQLProduct(this);
        if(dao_Product.all().size()==0) {
            dao_Product.save(new Product(-1, "Leche Gloria", "property_image_1", 50, false, (float)11.5 ));
            dao_Product.save(new Product(-1, "Queso Gloria", "property_image_2", 45,true, (float)2.99 ));
            dao_Product.save(new Product(-1, "Mantequilla Gloria", "property_image_3", 35,true, (float)10.99 ));
            dao_Product.save(new Product(-1, "Yogur Gloria", "property_image_4", 40,true, (float)8.89 ));
            dao_Product.save(new Product(-1, "Mermelada Gloria", "property_image_5", 20,true, (float)5.39 ));
            dao_Product.save(new Product(-1, "Refresco Gloria", "property_image_6", 55,true, (float)4.75 ));
            dao_Product.save(new Product(-1, "Marjarblanco Gloria", "property_image_7", 25,true, (float)3.5 ));
        }

        dao_Order = new DAOSQLOrder(this);
        if(dao_Order.all().size()==0) {

            dao_Order.save(new Order(-1,
                    new SimpleDateFormat("yyyy-MM-dd").format( new Date() )));
        }

        dao_DetOrder = new DAOSQLDetailOrder(this);

        /* ArrayAdapter adapter = new ArrayAdapter(this,
                R.layout.grid_product_item, // el layout por elemento
                R.id.txtProduct, // el id del elemento donde pondrá cada uno de los elementos
                new DAOProduct().all()); // la lista de productos
                */
        final ProductGridAdapter adapter = new ProductGridAdapter(this, dao_Product.all());
        lstProducts.setAdapter(adapter); // agregamos el adapter a la grilla

        //Añadir evento listener para que podamos manejar los clicks
        AdapterView.OnItemClickListener adapterViewListener =  new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                Product product = dao_Product.all().get(i);

                Intent intent = new Intent(MainActivity.this, DetailActivity.class);

                intent.putExtra("id", product.getId());
                intent.putExtra("name", product.getName());
                intent.putExtra("photo_url", product.getPhoto_url());
                intent.putExtra("quantity", product.getQuantity());
                intent.putExtra("featured", product.isFeatured());
                intent.putExtra("price", product.getPrice());

                startActivity(intent);
            }
        };

        //configurar el listener a la vista de lista
        lstProducts.setOnItemClickListener(adapterViewListener);

        txtSearcher.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
            @Override
            public boolean onQueryTextSubmit(String s) {
                return false;
            }

            @Override
            public boolean onQueryTextChange(String query) {
                adapter.getFilter().filter(query);
                return false;
            }
        });

        btnRefresh.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                adapter.getFilter().filter("");
            }
        });
    }

    @Override
    protected void onResume() {
        super.onResume();
        String usuario = prefs.getString(DeliverySharedPreferences.SHARED_PREFERENCES_NAME, null);
        if(usuario == null){
            Intent intent = new Intent(this, LoginActivity.class);
            startActivity(intent);
            this.finish();
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.main_menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch(item.getItemId()){
            case R.id.opt_ver_carrito:
                verCarrito();
                return true;
            case R.id.opt_limpiar_carrito:
                limpiarCarrito(true);
                return true;
            case R.id.opt_ver_perfil:
                return true;
            case R.id.opt_cerrar_sesion:
                limpiarCarrito(false);
                cerrarSesion();
                return true;
        }
        return false;
    }

    public void verCarrito(){
        Intent intent = new Intent(this, CartActivity.class);
        startActivity(intent);
    }

    public void cerrarSesion(){
        this.prefs.putString(DeliverySharedPreferences.SHARED_PREFERENCES_NAME, null);
        Intent intent = new Intent(this, LoginActivity.class);
        startActivity(intent);
        this.finish();
    }

    public void limpiarCarrito(boolean flag){
        int ultimo = dao_Order.all().size() - 1;
        int id_order = dao_Order.all().get( ultimo ).getId();

        if(dao_DetOrder.allProductsByOrder(id_order).size()>0){

            dao_DetOrder.deleteByOrder(id_order);
            if(flag)
                Toast.makeText(this, "El carrito está vacío", Toast.LENGTH_SHORT).show();
        }
        else {
            if(flag)
                Toast.makeText(this, "No hay productos en el carrito", Toast.LENGTH_LONG).show();
        }
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        this.finish();
    }
}
