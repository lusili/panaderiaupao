package pe.upao.panaderia.adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.List;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import pe.upao.panaderia.R;
import pe.upao.panaderia.models.Product;

import static android.view.View.GONE;

/**
 * Created by  on 23/09/18.
 */

public class ProductGridAdapter extends ArrayAdapter{

    public ProductGridAdapter(@NonNull Context context, List<Product> products) {
        super(context, R.layout.grid_product_item, R.id.txtProduct, products);
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        View view = convertView;
        if(convertView== null)
            view = LayoutInflater.from(this.getContext()).inflate(R.layout.grid_product_item,parent,false);

        TextView txtProduct = view.findViewById(R.id.txtProduct);
        TextView txtQuantity = view.findViewById(R.id.txtQuantity);
        ImageView imgStar = view.findViewById(R.id.imgStar);

        Product product = (Product) getItem(position);


        txtProduct.setText(product.getName());
        txtQuantity.setText(product.getQuantity());
        if(product.isFeatured()) {
            imgStar.setVisibility(View.VISIBLE);
        }else{
            imgStar.setVisibility(GONE);
        }
        return view;
    }
}
