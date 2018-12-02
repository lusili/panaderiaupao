package pe.upao.panaderia.daos;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import java.util.ArrayList;
import java.util.List;

import pe.upao.panaderia.db.CarritoDBHelper;
import pe.upao.panaderia.db.tables.DetailOrderTable;
import pe.upao.panaderia.db.tables.OrderTable;
import pe.upao.panaderia.db.tables.ProductTable;
import pe.upao.panaderia.models.DetailOrder;
import pe.upao.panaderia.models.Product;

public class DAOSQLDetailOrder {

    // https://pastebin.com/JFPqazvk
    private CarritoDBHelper dbHelper;
    private DAOSQLProduct oDAOSQLProduct;

    public DAOSQLDetailOrder(Context context) {
        this.dbHelper = new CarritoDBHelper(context);
        //this.oDAOSQLProduct = new DAOSQLProduct(context);
    }

    public void save(DetailOrder detOrder) {
        SQLiteDatabase db = this.dbHelper.getWritableDatabase();
        // writableDatabase.execSQL("INSERT INTO DETORDER VALUES('', 'url', '0', '0')");

        ContentValues values = new ContentValues();
        values.put(DetailOrderTable.COLUMN_ID_ORDER, detOrder.getId_order());
        values.put(DetailOrderTable.COLUMN_ID_PRODUCT, detOrder.getId_product());
        values.put(DetailOrderTable.COLUMN_QUANTITY, detOrder.getQuantity());
        values.put(DetailOrderTable.COLUMN_PRICE, detOrder.getPrice());

        if (detOrder.getId() == -1) {
            db.insert(DetailOrderTable.TABLE_NAME, null, values);
        } else {
            db.update(DetailOrderTable.TABLE_NAME, values,
                    DetailOrderTable.COLUMN_ID + " = ?",
                    new String[]{ String.valueOf(detOrder.getId()) });
        }
        db.close();
    }

    public List<DetailOrder> all() {
        SQLiteDatabase db = this.dbHelper.getReadableDatabase();

        Cursor cursor = db.query(DetailOrderTable.TABLE_NAME, new String[]{
                        DetailOrderTable.COLUMN_ID,
                        DetailOrderTable.COLUMN_ID_ORDER,
                        DetailOrderTable.COLUMN_ID_PRODUCT,
                        DetailOrderTable.COLUMN_QUANTITY,
                        DetailOrderTable.COLUMN_PRICE
                },
                null, null, null, null, null);

        List<DetailOrder> detOrders = new ArrayList<>();
        while (cursor.moveToNext()) {
            DetailOrder detOrder = cursorToDetOrder(cursor);
            detOrders.add(detOrder);
        }
        cursor.close();
        db.close();

        return detOrders;
    }

    public List<DetailOrder> allByOrder(int id_order) {
        SQLiteDatabase db = this.dbHelper.getReadableDatabase();

        Cursor cursor = db.query(DetailOrderTable.TABLE_NAME, new String[]{
                        DetailOrderTable.COLUMN_ID,
                        DetailOrderTable.COLUMN_ID_ORDER,
                        DetailOrderTable.COLUMN_ID_PRODUCT,
                        DetailOrderTable.COLUMN_QUANTITY,
                        DetailOrderTable.COLUMN_PRICE
                },
                DetailOrderTable.COLUMN_ID_ORDER + " = ?", new String[]{String.valueOf(id_order)}, null, null, null);

        List<DetailOrder> detOrders = new ArrayList<>();
        while (cursor.moveToNext()) {
            DetailOrder detOrder = cursorToDetOrder(cursor);
            detOrders.add(detOrder);
        }
        cursor.close();
        db.close();

        return detOrders;
    }

    public DetailOrder cursorToDetOrder(Cursor cursor) {
        DetailOrder detOrder = new DetailOrder();
        detOrder.setId(cursor.getInt(cursor.getColumnIndex(DetailOrderTable.COLUMN_ID)));
        detOrder.setId_order(cursor.getInt(cursor.getColumnIndex(DetailOrderTable.COLUMN_ID_ORDER)));
        detOrder.setId_product(cursor.getInt(cursor.getColumnIndex(DetailOrderTable.COLUMN_ID_PRODUCT)));
        detOrder.setQuantity(cursor.getInt(cursor.getColumnIndex(DetailOrderTable.COLUMN_QUANTITY)));
        detOrder.setPrice(cursor.getFloat(cursor.getColumnIndex(DetailOrderTable.COLUMN_PRICE)));
        return detOrder;
    }

    public void delete(int id) {
        SQLiteDatabase db = this.dbHelper.getWritableDatabase();

        db.delete(DetailOrderTable.TABLE_NAME,
                DetailOrderTable.COLUMN_ID + " = ?",
                new String[]{String.valueOf(id)});
        db.close();
    }

    public void deleteAll() {
        SQLiteDatabase db = this.dbHelper.getWritableDatabase();

        db.delete(DetailOrderTable.TABLE_NAME,null,null);
        db.close();
    }

    public void deleteByOrder(int id_order) {
        SQLiteDatabase db = this.dbHelper.getWritableDatabase();

        db.delete(DetailOrderTable.TABLE_NAME,
                DetailOrderTable.COLUMN_ID_ORDER + " = ?",
                new String[]{String.valueOf(id_order)});
        db.close();
    }

    public DetailOrder get(int id) {
        SQLiteDatabase db = this.dbHelper.getReadableDatabase();

        Cursor cursor = db.query(DetailOrderTable.TABLE_NAME, new String[]{
                        DetailOrderTable.COLUMN_ID,
                        DetailOrderTable.COLUMN_ID_ORDER,
                        DetailOrderTable.COLUMN_ID_PRODUCT,
                        DetailOrderTable.COLUMN_QUANTITY,
                        DetailOrderTable.COLUMN_PRICE},
                DetailOrderTable.COLUMN_ID + " = ?", new String[]{String.valueOf(id)}, null, null, null);

        while (cursor.moveToNext()) {
            return cursorToDetOrder(cursor);
        }
        cursor.close();
        db.close();
        return null;
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

    public List<Product> allProductsByOrder(int id_order) {
        SQLiteDatabase db = this.dbHelper.getReadableDatabase();

        String t_product = ProductTable.TABLE_NAME;
        String t_detorder = DetailOrderTable.TABLE_NAME;

        String query = "SELECT "+
                t_product + "." + ProductTable.COLUMN_ID + ", "+
                t_product + "." + ProductTable.COLUMN_NAME + ", "+
                t_product + "." + ProductTable.COLUMN_PHOTO_URL + ", "+
                t_detorder + "." + DetailOrderTable.COLUMN_QUANTITY + " AS '" + ProductTable.COLUMN_QUANTITY+ "', "+
                t_product + "." + ProductTable.COLUMN_FEATURED + ", "+
                t_product + "." + ProductTable.COLUMN_PRICE + " * " + t_detorder + "." + DetailOrderTable.COLUMN_PRICE + " AS '" + ProductTable.COLUMN_PRICE+ "' "+
                " FROM " + t_product +
                " JOIN " + t_detorder + " ON " + t_product + "." + ProductTable.COLUMN_ID + "=" + t_detorder + "." + DetailOrderTable.COLUMN_ID_PRODUCT +
                " WHERE "+ t_detorder + "." + DetailOrderTable.COLUMN_ID_ORDER + "=" + id_order;

        Cursor cursor = db.rawQuery(query, null);

        List<Product> products = new ArrayList<>();
        while (cursor.moveToNext()) {
            Product product = cursorToProduct(cursor);
            products.add(product);
        }
        cursor.close();
        db.close();

        return products;
    }

    public DetailOrder existeProductInOrder(int id_order, int id_product) {
        SQLiteDatabase db = this.dbHelper.getReadableDatabase();

        String t_product = ProductTable.TABLE_NAME;
        String t_detorder = DetailOrderTable.TABLE_NAME;
        String t_order = OrderTable.TABLE_NAME;

        String query = "SELECT "+
                t_detorder + "." + DetailOrderTable.COLUMN_ID + ", "+
                t_detorder + "." + DetailOrderTable.COLUMN_ID_ORDER + ", "+
                t_detorder + "." + DetailOrderTable.COLUMN_ID_PRODUCT + ", "+
                t_detorder + "." + DetailOrderTable.COLUMN_QUANTITY + ", "+
                t_detorder + "." + DetailOrderTable.COLUMN_PRICE + " "+
                " FROM " + t_detorder +
                " JOIN " + t_product + " ON " +  t_detorder + "." + DetailOrderTable.COLUMN_ID_PRODUCT + "=" + t_product + "." + ProductTable.COLUMN_ID +
                " JOIN " + t_order + " ON " +  t_detorder + "." + DetailOrderTable.COLUMN_ID_ORDER + "=" + t_order + "." + OrderTable.COLUMN_ID +
                " WHERE "+ t_detorder + "." + DetailOrderTable.COLUMN_ID_ORDER + "=" + id_order +
                " AND "+ t_detorder + "." + DetailOrderTable.COLUMN_ID_PRODUCT + "=" + id_product;

        Cursor cursor = db.rawQuery(query, null);

        while (cursor.moveToNext()) {
            return cursorToDetOrder(cursor);
        }
        cursor.close();
        db.close();
        return null;
    }

}
