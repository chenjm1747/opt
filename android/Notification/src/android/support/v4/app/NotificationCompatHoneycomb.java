package android.support.v4.app;

import android.app.Notification;
import android.app.Notification.Builder;
import android.app.PendingIntent;
import android.content.Context;
import android.graphics.Bitmap;
import android.net.Uri;
import android.widget.RemoteViews;

class NotificationCompatHoneycomb
{
  static Notification add(Context paramContext, Notification paramNotification, CharSequence paramCharSequence1, CharSequence paramCharSequence2, CharSequence paramCharSequence3, RemoteViews paramRemoteViews, int paramInt, PendingIntent paramPendingIntent1, PendingIntent paramPendingIntent2, Bitmap paramBitmap)
  {
    Notification.Builder localBuilder1 = new Notification.Builder(paramContext);
    long l = paramNotification.when;
    localBuilder1 = localBuilder1.setWhen(l);
    int k = paramNotification.icon;
    int i1 = paramNotification.iconLevel;
    localBuilder1 = localBuilder1.setSmallIcon(k, i1);
    Object localObject2 = paramNotification.contentView;
    localBuilder1 = localBuilder1.setContent((RemoteViews)localObject2);
    localObject2 = paramNotification.tickerText;
    localBuilder1 = localBuilder1.setTicker((CharSequence)localObject2, paramRemoteViews);
    localObject2 = paramNotification.sound;
    int i2 = paramNotification.audioStreamType;
    localBuilder1 = localBuilder1.setSound((Uri)localObject2, i2);
    localObject2 = paramNotification.vibrate;
    localBuilder1 = localBuilder1.setVibrate(localObject2);
    int m = paramNotification.ledARGB;
    int i3 = paramNotification.ledOnMS;
    int i4 = paramNotification.ledOffMS;
    Notification.Builder localBuilder3 = localBuilder1.setLights(m, i3, i4);
    int i = paramNotification.flags & 0x2;
    label191: label217: Object localObject3;
    int j;
    if (i != 0)
    {
      i = 1;
      localBuilder3 = localBuilder3.setOngoing(i);
      i = paramNotification.flags & 0x8;
      if (i == 0)
        break label321;
      i = 1;
      localBuilder3 = localBuilder3.setOnlyAlertOnce(i);
      i = paramNotification.flags & 0x10;
      if (i == 0)
        break label327;
      i = 1;
      Notification.Builder localBuilder2 = localBuilder3.setAutoCancel(i);
      int n = paramNotification.defaults;
      localBuilder2 = localBuilder2.setDefaults(n).setContentTitle(paramCharSequence1).setContentText(paramCharSequence2).setContentInfo(paramCharSequence3).setContentIntent(paramPendingIntent1);
      localObject3 = paramNotification.deleteIntent;
      localObject3 = localBuilder2.setDeleteIntent((PendingIntent)localObject3);
      j = paramNotification.flags & 0x80;
      if (j == 0)
        break label333;
      j = 1;
    }
    while (true)
    {
      return ((Notification.Builder)localObject3).setFullScreenIntent(paramPendingIntent2, j).setLargeIcon(paramBitmap).setNumber(paramInt).getNotification();
      Object localObject1 = null;
      break;
      label321: localObject1 = null;
      break label191;
      label327: localObject1 = null;
      break label217;
      label333: localObject1 = null;
    }
  }
}