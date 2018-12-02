package pe.upao.panaderia.db;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import pe.upao.panaderia.db.tables.DetailOrderTable;
import pe.upao.panaderia.db.tables.OrderTable;
import pe.upao.panaderia.db.tables.ProductTable;

public class CarritoDBHelper extends SQLiteOpenHelper {

    public static final int DATABASE_VERSION=1;
    public static final String DATABASE_NAME  = "Carrito.db";

    private static final String SQL_CREATE_PRODUCT =
            "CREATE TABLE " + ProductTable.TABLE_NAME + " (" +
                    ProductTable.COLUMN_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    ProductTable.COLUMN_NAME + " TEXT NOT NULL, " +
                    ProductTable.COLUMN_PHOTO_URL + " TEXT NOT NULL, " +
                    ProductTable.COLUMN_FEATURED + " INTEGER NOT NULL, " +
                    ProductTable.COLUMN_QUANTITY + " INTEGER NOT NULL, " +
                    ProductTable.COLUMN_PRICE + " REAL NOT NULL )";

    private static final String SQL_CREATE_ORDER =
            "CREATE TABLE " + OrderTable.TABLE_NAME + " (" +
                    OrderTable.COLUMN_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    OrderTable.COLUMN_ID_CLIENT + " INTEGER, " +
                    OrderTable.COLUMN_DATE + " DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL )";

    private static final String SQL_CREATE_DET_ORDER =
            "CREATE TABLE " + DetailOrderTable.TABLE_NAME + " (" +
                    DetailOrderTable.COLUMN_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    DetailOrderTable.COLUMN_ID_ORDER + " INTEGER NOT NULL, " +
                    DetailOrderTable.COLUMN_ID_PRODUCT + " INTEGER NOT NULL, " +
                    DetailOrderTable.COLUMN_QUANTITY + " INTEGER DEFAULT 1 NOT NULL, " +
                    DetailOrderTable.COLUMN_PRICE + " REAL NOT NULL, " +
                    " FOREIGN KEY(" + DetailOrderTable.COLUMN_ID_ORDER + ") REFERENCES " + OrderTable.TABLE_NAME + "(" + OrderTable.COLUMN_ID + ")," +
                    " FOREIGN KEY(" + DetailOrderTable.COLUMN_ID_PRODUCT + ") REFERENCES " + ProductTable.TABLE_NAME + "(" + ProductTable.COLUMN_ID + "));";



    public CarritoDBHelper(Context context) {
        super(context, DATABASE_NAME,null, DATABASE_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {

        db.execSQL(SQL_CREATE_PRODUCT);
        db.execSQL(SQL_CREATE_ORDER);
        db.execSQL(SQL_CREATE_DET_ORDER);

    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

        db.execSQL("DROP TABLE " + ProductTable.TABLE_NAME);
        db.execSQL("DROP TABLE " + OrderTable.TABLE_NAME);
        db.execSQL("DROP TABLE " + DetailOrderTable.TABLE_NAME);
        this.onCreate(db);
    }

    @Override
    public void onDowngrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        onUpgrade(db, oldVersion, newVersion);
    }
}
