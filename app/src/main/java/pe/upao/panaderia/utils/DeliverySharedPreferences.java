package pe.upao.panaderia.utils;

import android.content.Context;
import android.content.SharedPreferences;

/**
 * Created by on 16/09/18.
 */

public class DeliverySharedPreferences {
    public static final String SHARED_PREFERENCES_NAME = "DELIVERY";
    public static final String PREF_USUARIO = "USUARIO";
    public static final String PREF_USUARIO_ANONIMUS = "USUARIO_ANONIMOS";

    private SharedPreferences preferences;
    public DeliverySharedPreferences(Context ctx) {
        // Construye y/u obtiene un share preferences
        // con nombre "DELIVERY" en modo privado(solo para este apk)
        preferences = ctx.getSharedPreferences(SHARED_PREFERENCES_NAME, Context.MODE_PRIVATE);
    }


    public void putString(String key, String value){
        SharedPreferences.Editor editor = preferences.edit(); // Pone las preferencias en modo edición
        editor.putString(key, value); // Agrega la preferencia
        editor.apply(); // Aplica cambios
    }
    public String getString(String key, String defaultValue){
        return preferences.getString(key, defaultValue); // Obtiene una preferencia
    }
}
