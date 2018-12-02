package pe.upao.panaderia.db;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import pe.upao.panaderia.db.tables.ProductTable;

public class CarritoDBHelper extends SQLiteOpenHelper {
    public static final int DATABASE_VERSION = 1;
    public static final String DATABASE_NAME = "Carrito.db";

    public CarritoDBHelper(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }
    public void onCreate(SQLiteDatabase db) {
        db.execSQL(
                "CREATE TABLE " + ProductTable.TABLE_NAME + " (" +
                        ProductTable.COLUMN_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " +
                        ProductTable.COLUMN_NAME + " TEXT NOT NULL, " +
                        ProductTable.COLUMN_PHOTO_URL + " TEXT NOT NULL, " +
                        ProductTable.COLUMN_QUANTITY + " TEXT NOT NULL, " +
                        ProductTable.COLUMN_FEATURED + " INTEGER NOT NULL " +
                        ");");

    }
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE " + ProductTable.TABLE_NAME);
        this.onCreate(db);
    }
    public void onDowngrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        onUpgrade(db, oldVersion, newVersion);
    }
}