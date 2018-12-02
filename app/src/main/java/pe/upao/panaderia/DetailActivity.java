package pe.upao.panaderia;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import pe.upao.panaderia.daos.DAOSQLDetailOrder;
import pe.upao.panaderia.daos.DAOSQLOrder;
import pe.upao.panaderia.models.DetailOrder;

public class DetailActivity extends AppCompatActivity {

    private Button btnAgregarCarrito;
    private DAOSQLDetailOrder dao_DetOrder;
    private DAOSQLOrder dao_Order;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);

        //configurar el botón Back (arriba)
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        dao_Order = new DAOSQLOrder(this);
        dao_DetOrder = new DAOSQLDetailOrder(this);
        btnAgregarCarrito = findViewById(R.id.btnAgregarCarrito);

        ImageView imageView = (ImageView) findViewById(R.id.image);
        TextView nombreTV = (TextView) findViewById(R.id.nombre);
        //TextView descripcionTV = (TextView) findViewById(R.id.descripcion);
        TextView precioTV = (TextView) findViewById(R.id.precio);
        TextView cantidadTV = (TextView) findViewById(R.id.cantidad);

        //Recoger la intención y pintar la data en el diseño.
        Intent intent = getIntent();

        String name = intent.getStringExtra("name");
        String image = intent.getStringExtra("photo_url");
        float price = intent.getFloatExtra("price", 0);
        Integer quantity = intent.getIntExtra("quantity", 0);
        //Integer id = intent.getIntExtra("id", 0);

        Integer imageID = this.getResources().getIdentifier(image, "drawable", this.getPackageName());
        //set elements
        imageView.setImageResource(imageID);
        nombreTV.setText(name);
        //descripcionTV.setText(description);
        precioTV.setText("Precio: S/." +  String.valueOf(price));
        cantidadTV.setText("Cantidad: " + cantidadTV);
        //cantidadTV.setText("Cantidad: " + id);

        //set the title of this activity to be the street name
        getSupportActionBar().setTitle(name);

        btnAgregarCarrito.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = getIntent();

                int ultimo = dao_Order.all().size() - 1;
                int id_order = dao_Order.all().get( ultimo ).getId();
                int id_product = intent.getIntExtra("id", 0);
                float price_product = intent.getFloatExtra("price", 0);

                DetailOrder oDetOrder = new DetailOrder();
                oDetOrder = dao_DetOrder.existeProductInOrder(id_order, id_product);

                if( oDetOrder == null ){
                    // no existe el producto en esa Orden, agrega el producto al carrito
                    dao_DetOrder.save(new DetailOrder(-1, id_order, id_product, 1, price_product));
                }
                else{
                    // existe un producto igual, aumentar la cantidad en 1
                    oDetOrder.aumentarCant();
                    dao_DetOrder.save(oDetOrder);
                }

                abre_dialogo(view);
            }
        });

    }

    public void abre_dialogo(View v) {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("Mi Carrito Delivery");
        builder.setMessage("1 Producto agregado al carrito!");
        builder.setPositiveButton("Ir al carrito", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                Intent intent = new Intent();
                intent.setClass(DetailActivity.this, CartActivity.class);
                startActivity(intent);
                //DetailActivity.this.finish();
            }
        });
        builder.setNegativeButton("Seguir comprando", null);
        Dialog dialog = builder.create();
        dialog.show();
    }

    @Override
    public boolean onSupportNavigateUp() {
        onBackPressed();
        return true;
    }
}
