package pe.upao.panaderia.daos;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import java.util.ArrayList;
import java.util.List;

import pe.upao.panaderia.db.CarritoDBHelper;
import pe.upao.panaderia.db.tables.OrderTable;
import pe.upao.panaderia.models.Order;

public class DAOSQLOrder {

    private CarritoDBHelper dbHelper;

    public DAOSQLOrder(Context context) {
        this.dbHelper = new CarritoDBHelper(context);
    }

    public void save(Order order) {
        SQLiteDatabase db = this.dbHelper.getWritableDatabase();
        // writableDatabase.execSQL("INSERT INTO ORDER VALUES('', '', '', '')");

        ContentValues values = new ContentValues();
        values.putNull(OrderTable.COLUMN_ID_CLIENT);
        values.put(OrderTable.COLUMN_DATE, order.getDate());

        if (order.getId() == -1) {
            db.insert(OrderTable.TABLE_NAME, null, values);
        } else {
            db.update(OrderTable.TABLE_NAME, values,
                    OrderTable.COLUMN_ID + " = ?",
                    new String[]{ String.valueOf(order.getId()) });
        }
        db.close();
    }

    public List<Order> all() {
        SQLiteDatabase db = this.dbHelper.getReadableDatabase();

        Cursor cursor = db.query(OrderTable.TABLE_NAME, new String[]{
                        OrderTable.COLUMN_ID,
                        OrderTable.COLUMN_DATE
                },
                null, null, null, null, null);

        List<Order> orders = new ArrayList<>();
        while (cursor.moveToNext()) {
            Order order = cursorToOrder(cursor);
            orders.add(order);
        }
        cursor.close();
        db.close();

        return orders;
    }

    public Order cursorToOrder(Cursor cursor) {
        Order order = new Order();
        order.setId(cursor.getInt(cursor.getColumnIndex(OrderTable.COLUMN_ID)));
        //order.setId_client(cursor.getString(cursor.getColumnIndex(OrderTable.COLUM_ID_CLIENTE)));
        order.setDate(cursor.getString(cursor.getColumnIndex(OrderTable.COLUMN_DATE)));
        return order;
    }

    public void delete(int id) {
        SQLiteDatabase db = this.dbHelper.getWritableDatabase();

        db.delete(OrderTable.TABLE_NAME,
                OrderTable.COLUMN_ID + " = ?",
                new String[]{String.valueOf(id)});
        db.close();
    }

    public Order get(int id) {
        SQLiteDatabase db = this.dbHelper.getReadableDatabase();

        Cursor cursor = db.query(OrderTable.TABLE_NAME, new String[]{
                        OrderTable.COLUMN_ID,
                        OrderTable.COLUMN_DATE},
                OrderTable.COLUMN_ID + " = ?", new String[]{String.valueOf(id)}, null, null, null);

        while (cursor.moveToNext()) {
            return cursorToOrder(cursor);
        }
        cursor.close();
        db.close();
        return null;
    }

}
