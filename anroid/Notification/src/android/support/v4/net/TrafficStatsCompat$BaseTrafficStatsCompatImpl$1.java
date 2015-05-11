package android.support.v4.net;

import dalvik.annotation.Signature;

@Signature({"Ljava/lang/ThreadLocal", "<", "Landroid/support/v4/net/TrafficStatsCompat$BaseTrafficStatsCompatImpl$SocketTags;", ">;"})
class TrafficStatsCompat$BaseTrafficStatsCompatImpl$1 extends ThreadLocal
{
  protected TrafficStatsCompat.BaseTrafficStatsCompatImpl.SocketTags initialValue()
  {
    return new TrafficStatsCompat.BaseTrafficStatsCompatImpl.SocketTags(null);
  }
}