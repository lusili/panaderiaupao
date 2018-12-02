package pe.upao.panaderia.daos;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import java.util.ArrayList;
import java.util.List;

import pe.upao.panaderia.db.CarritoDBHelper;
import pe.upao.panaderia.db.tables.ProductTable;
import pe.upao.panaderia.models.Product;

public class DAOSQLProduct {

    // https://pastebin.com/JFPqazvk
    private CarritoDBHelper dbHelper;

    public DAOSQLProduct(Context context) {
        this.dbHelper = new CarritoDBHelper(context);
    }

    public void save(Product product) {
        SQLiteDatabase db = this.dbHelper.getWritableDatabase();
        // writableDatabase.execSQL("INSERT INTO PRODUCT VALUES('NOMBRE', 'url', '0', '0')");

        ContentValues values = new ContentValues();
        values.put(ProductTable.COLUMN_NAME, product.getName());
        values.put(ProductTable.COLUMN_PHOTO_URL, product.getPhoto_url());
        values.put(ProductTable.COLUMN_QUANTITY, product.getQuantity());
        values.put(ProductTable.COLUMN_FEATURED, product.isFeatured());
        values.put(ProductTable.COLUMN_PRICE, product.getPrice());

        if (product.getId() == -1) {
            db.insert(ProductTable.TABLE_NAME, null, values);
        } else {
            db.update(ProductTable.TABLE_NAME, values,
                    ProductTable.COLUMN_ID + " = ?",
                    new String[]{ String.valueOf(product.getId()) });
        }
        db.close();
    }

    public List<Product> all() {
        SQLiteDatabase db = this.dbHelper.getReadableDatabase();

        Cursor cursor = db.query(ProductTable.TABLE_NAME, new String[]{
                        ProductTable.COLUMN_ID,
                        ProductTable.COLUMN_NAME,
                        ProductTable.COLUMN_PHOTO_URL,
                        ProductTable.COLUMN_QUANTITY,
                        ProductTable.COLUMN_FEATURED,
                        ProductTable.COLUMN_PRICE

                },
                null, null, null, null, null);

        List<Product> products = new ArrayList<>();
        while (cursor.moveToNext()) {
            Product product = cursorToProduct(cursor);
            products.add(product);
        }
        cursor.close();
        db.close();

        return products;
    }

    public Product cursorToProduct(Cursor cursor) {
        Product product = new Product();
        product.setId(cursor.getInt(cursor.getColumnIndex(ProductTable.COLUMN_ID)));
        product.setName(cursor.getString(cursor.getColumnIndex(ProductTable.COLUMN_NAME)));
        product.setPhoto_url(cursor.getString(cursor.getColumnIndex(ProductTable.COLUMN_PHOTO_URL)));
        product.setQuantity(cursor.getInt(cursor.getColumnIndex(ProductTable.COLUMN_QUANTITY)));
        product.setFeatured(cursor.getInt(cursor.getColumnIndex(ProductTable.COLUMN_FEATURED)) == 1);
        product.setPrice(cursor.getFloat(cursor.getColumnIndex(ProductTable.COLUMN_PRICE)));
        return product;
    }

    public void delete(int id) {
        SQLiteDatabase db = this.dbHelper.getWritableDatabase();

        db.delete(ProductTable.TABLE_NAME,
                ProductTable.COLUMN_ID + " = ?",
                new String[]{String.valueOf(id)});
        db.close();
    }

    public Product get(int id) {
        SQLiteDatabase db = this.dbHelper.getReadableDatabase();

        Cursor cursor = db.query(ProductTable.TABLE_NAME, new String[]{
                        ProductTable.COLUMN_ID,
                        ProductTable.COLUMN_NAME,
                        ProductTable.COLUMN_PHOTO_URL,
                        ProductTable.COLUMN_QUANTITY,
                        ProductTable.COLUMN_FEATURED,
                        ProductTable.COLUMN_PRICE},
                ProductTable.COLUMN_ID + " = ?", new String[]{String.valueOf(id)}, null, null, null);

        while (cursor.moveToNext()) {
            return cursorToProduct(cursor);
        }
        cursor.close();
        db.close();
        return null;
    }
}