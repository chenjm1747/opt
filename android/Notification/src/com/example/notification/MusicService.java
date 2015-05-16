package com.example.notification;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

public class MusicService extends BroadcastReceiver
{
  public void onReceive(Context paramContext, Intent paramIntent)
  {
    Intent localIntent = new Intent(paramContext, MainActivity.class);
    localIntent.addFlags(268435456);
    paramContext.startActivity(localIntent);
  }
}