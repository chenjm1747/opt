package android.support.v4.util;

import android.util.Log;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class AtomicFile
{
  private final File mBackupName;
  private final File mBaseName;

  public AtomicFile(File paramFile)
  {
    this.mBaseName = paramFile;
    StringBuilder localStringBuilder = new StringBuilder();
    String str1 = paramFile.getPath();
    String str2 = str1 + ".bak";
    File localFile = new File(str2);
    this.mBackupName = localFile;
  }

  static boolean sync(FileOutputStream paramFileOutputStream)
  {
    if (paramFileOutputStream != null);
    try
    {
      FileDescriptor localFileDescriptor = paramFileOutputStream.getFD();
      localFileDescriptor.sync();
      int i = 1;
      return i;
    }
    catch (IOException localObject)
    {
      while (true)
        Object localObject = null;
    }
  }

  public void delete()
  {
    this.mBaseName.delete();
    this.mBackupName.delete();
  }

  public void failWrite(FileOutputStream paramFileOutputStream)
  {
    if (paramFileOutputStream != null)
      sync(paramFileOutputStream);
    try
    {
      paramFileOutputStream.close();
      this.mBaseName.delete();
      File localFile1 = this.mBackupName;
      File localFile2 = this.mBaseName;
      localFile1.renameTo(localFile2);
      return;
    }
    catch (IOException localIOException)
    {
      while (true)
        Log.w("AtomicFile", "failWrite: Got exception:", localIOException);
    }
  }

  public void finishWrite(FileOutputStream paramFileOutputStream)
  {
    if (paramFileOutputStream != null)
      sync(paramFileOutputStream);
    try
    {
      paramFileOutputStream.close();
      this.mBackupName.delete();
      return;
    }
    catch (IOException localIOException)
    {
      while (true)
        Log.w("AtomicFile", "finishWrite: Got exception:", localIOException);
    }
  }

  public File getBaseFile()
  {
    return this.mBaseName;
  }

  public FileInputStream openRead()
    throws FileNotFoundException
  {
    if (this.mBackupName.exists())
    {
      this.mBaseName.delete();
      File localFile1 = this.mBackupName;
      File localFile2 = this.mBaseName;
      localFile1.renameTo(localFile2);
    }
    File localFile3 = this.mBaseName;
    return new FileInputStream(localFile3);
  }

  public byte[] readFully()
    throws IOException
  {
    FileInputStream localFileInputStream = openRead();
    int i = 0;
    try
    {
      int j = localFileInputStream.available();
      Object localObject1 = new byte[j];
      while (true)
      {
        int k = localObject1.length - i;
        int m = localFileInputStream.read(localObject1, i, k);
        if (m <= 0)
          return localObject1;
        i += m;
        j = localFileInputStream.available();
        int n = localObject1.length - i;
        if (j <= n)
          continue;
        byte[] arrayOfByte = new byte[i + j];
        System.arraycopy(localObject1, 0, arrayOfByte, 0, i);
        localObject1 = arrayOfByte;
      }
    }
    finally
    {
      localFileInputStream.close();
    }
    throw localObject2;
  }

  public FileOutputStream startWrite()
    throws IOException
  {
    if (this.mBaseName.exists())
    {
      if (this.mBackupName.exists())
        break label119;
      File localFile1 = this.mBaseName;
      File localFile2 = this.mBackupName;
      if (!localFile1.renameTo(localFile2))
      {
        StringBuilder localStringBuilder1 = new StringBuilder().append("Couldn't rename file ");
        File localFile3 = this.mBaseName;
        StringBuilder localStringBuilder2 = localStringBuilder1.append(localFile3).append(" to backup file ");
        File localFile4 = this.mBackupName;
        String str1 = localFile4;
        Log.w("AtomicFile", str1);
      }
    }
    label119: String str3;
    while (true)
    {
      FileOutputStream localFileOutputStream = null;
      try
      {
        File localFile5 = this.mBaseName;
        localFileOutputStream = new FileOutputStream(localFile5);
        return localFileOutputStream;
        this.mBaseName.delete();
      }
      catch (FileNotFoundException localFileNotFoundException1)
      {
        while (true)
        {
          if (!this.mBaseName.getParentFile().mkdir())
          {
            StringBuilder localStringBuilder3 = new StringBuilder().append("Couldn't create directory ");
            File localFile6 = this.mBaseName;
            String str2 = localFile6;
            throw new IOException(str2);
          }
          try
          {
            File localFile7 = this.mBaseName;
            localFileOutputStream = new FileOutputStream(localFile7);
          }
          catch (FileNotFoundException localFileNotFoundException2)
          {
            StringBuilder localStringBuilder4 = new StringBuilder().append("Couldn't create ");
            File localFile8 = this.mBaseName;
            str3 = localFile8;
          }
        }
      }
    }
    throw new IOException(str3);
  }
}