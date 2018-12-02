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

public class ProductGridAdapter extends ArrayAdapter {
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
        ImageView img = view.findViewById(R.id.imgStar);

        Product product = (Product) getItem(position);

        txtProduct.setText(product.getName());
        txtQuantity.setText(Integer.toString(product.getQuantity()));

        Integer imageID = this.getContext().getResources().getIdentifier(product.getPhoto_url(), "drawable", this.getContext().getPackageName());
        img.setImageResource(imageID);
        /*
        if(product.isFeatured()) {
            img.setVisibility(View.VISIBLE);
        }else{
            img.setVisibility(GONE);
        }
        view.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

            }
        });*/
        return view;
    }

}
