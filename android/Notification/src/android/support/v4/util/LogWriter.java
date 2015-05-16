package android.support.v4.util;

import android.util.Log;
import java.io.Writer;

public class LogWriter extends Writer
{
  private StringBuilder mBuilder;
  private final String mTag;

  public LogWriter(String paramString)
  {
    StringBuilder localStringBuilder = new StringBuilder(128);
    this.mBuilder = localStringBuilder;
    this.mTag = paramString;
  }

  private void flushBuilder()
  {
    if (this.mBuilder.length() > 0)
    {
      String str1 = this.mTag;
      String str2 = this.mBuilder.toString();
      Log.d(str1, str2);
      StringBuilder localStringBuilder = this.mBuilder;
      int i = this.mBuilder.length();
      localStringBuilder.delete(0, i);
    }
  }

  public void close()
  {
    flushBuilder();
  }

  public void flush()
  {
    flushBuilder();
  }

  public void write(char[] paramArrayOfChar, int paramInt1, int paramInt2)
  {
    Object localObject = null;
    if (localObject < paramInt2)
    {
      int i = paramInt1 + localObject;
      char c = paramArrayOfChar[i];
      if (c == '\n')
        flushBuilder();
      while (true)
      {
        localObject++;
        break;
        this.mBuilder.append(c);
      }
    }
  }
}