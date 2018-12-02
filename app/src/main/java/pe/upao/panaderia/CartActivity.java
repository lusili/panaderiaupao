package pe.upao.panaderia;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.GridView;
import android.widget.Toast;

import java.text.SimpleDateFormat;
import java.util.Date;

import androidx.appcompat.app.AppCompatActivity;
import pe.upao.panaderia.adapters.ProductGridAdapter;
import pe.upao.panaderia.daos.DAOSQLDetailOrder;
import pe.upao.panaderia.daos.DAOSQLOrder;
import pe.upao.panaderia.models.Order;

public class CartActivity extends AppCompatActivity {

    private GridView lstProductsCart;
    private ProductGridAdapter adapter;
    private DAOSQLOrder dao_Order;
    private DAOSQLDetailOrder dao_DetOrder;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_cart);

        //configurar el botón Back (arriba)
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        dao_Order = new DAOSQLOrder(this);
        dao_DetOrder = new DAOSQLDetailOrder(this);
        lstProductsCart = findViewById(R.id.lstProductsCart);

        int ultimo = dao_Order.all().size() - 1;
        int id_order = dao_Order.all().get( ultimo ).getId();

        adapter = new ProductGridAdapter(this, dao_DetOrder.allProductsByOrder( id_order ));
        lstProductsCart.setAdapter(adapter); // agregamos el adapter a la grilla
        lstProductsCart.setEmptyView(findViewById(R.id.emptyElement));
    }

    public void abre_dialogo(View v) {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("Mi Carrito Delivery");
        builder.setMessage("Muchas Gracias por su compra!!!");
        builder.setPositiveButton("Ok", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                Intent intent = new Intent();
                intent.setClass(CartActivity.this, MainActivity.class);
                startActivity(intent);

                CartActivity.this.finish();
            }
        });
        //builder.setNegativeButton(android.R.string.cancel, null);
        Dialog dialog = builder.create();
        dialog.show();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.cart_menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch(item.getItemId()){
            case R.id.opt_comprar:
                comprarCarrito();
                return true;
            case R.id.opt_vaciar_carrito:
                limpiarCarrito();
                return true;
        }
        return false;
    }

    public void comprarCarrito(){
        dao_Order.save(new Order(-1,
                new SimpleDateFormat("yyyy-MM-dd").format( new Date() )));
        abre_dialogo(null);
    }

    public void limpiarCarrito(){
        int ultimo = dao_Order.all().size() - 1;
        int id_order = dao_Order.all().get( ultimo ).getId();

        if(dao_DetOrder.allProductsByOrder(id_order).size()>0){

            dao_DetOrder.deleteByOrder(id_order);
            Toast.makeText(this, "carrito vacío", Toast.LENGTH_SHORT).show();
            //Refresh adapter
            adapter.notifyDataSetChanged();
        }
        else
            Toast.makeText(this, "No hay productos", Toast.LENGTH_SHORT).show();
    }

    @Override
    public boolean onSupportNavigateUp() {
        onBackPressed();
        return true;
    }
}
