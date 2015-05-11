package android.support.v4.app;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Build.VERSION;
import android.os.Parcelable;
import android.text.Html;
import android.text.Spanned;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import dalvik.annotation.Signature;
import java.util.ArrayList;

public class ShareCompat
{
  public static final String EXTRA_CALLING_ACTIVITY = "android.support.v4.app.EXTRA_CALLING_ACTIVITY";
  public static final String EXTRA_CALLING_PACKAGE = "android.support.v4.app.EXTRA_CALLING_PACKAGE";
  private static ShareCompatImpl IMPL;

  static
  {
    if (Build.VERSION.SDK_INT >= 16)
      IMPL = new ShareCompatImplJB();
    while (true)
    {
      return;
      if (Build.VERSION.SDK_INT >= 14)
      {
        IMPL = new ShareCompatImplICS();
        continue;
      }
      IMPL = new ShareCompatImplBase();
    }
  }

  public static void configureMenuItem(Menu paramMenu, int paramInt, IntentBuilder paramIntentBuilder)
  {
    MenuItem localMenuItem = paramMenu.findItem(paramInt);
    if (localMenuItem == null)
    {
      String str = "Could not find menu item with id " + paramInt + " in the supplied menu";
      throw new IllegalArgumentException(str);
    }
    configureMenuItem(localMenuItem, paramIntentBuilder);
  }

  public static void configureMenuItem(MenuItem paramMenuItem, IntentBuilder paramIntentBuilder)
  {
    IMPL.configureMenuItem(paramMenuItem, paramIntentBuilder);
  }

  public static ComponentName getCallingActivity(Activity paramActivity)
  {
    ComponentName localComponentName = paramActivity.getCallingActivity();
    if (localComponentName == null)
      localComponentName = (ComponentName)paramActivity.getIntent().getParcelableExtra("android.support.v4.app.EXTRA_CALLING_ACTIVITY");
    return localComponentName;
  }

  public static String getCallingPackage(Activity paramActivity)
  {
    String str = paramActivity.getCallingPackage();
    if (str == null)
      str = paramActivity.getIntent().getStringExtra("android.support.v4.app.EXTRA_CALLING_PACKAGE");
    return str;
  }

  public class IntentReader
  {
    private static final String TAG = "IntentReader";
    private ComponentName mCallingActivity;
    private String mCallingPackage;
    private Intent mIntent;

    @Signature({"Ljava/util/ArrayList", "<", "Landroid/net/Uri;", ">;"})
    private ArrayList mStreams;

    private IntentReader()
    {
      Intent localIntent = ShareCompat.this.getIntent();
      this.mIntent = localIntent;
      String str = ShareCompat.getCallingPackage(ShareCompat.this);
      this.mCallingPackage = str;
      ComponentName localComponentName = ShareCompat.getCallingActivity(ShareCompat.this);
      this.mCallingActivity = localComponentName;
    }

    public static IntentReader from(Activity paramActivity)
    {
      return new IntentReader(paramActivity);
    }

    public ComponentName getCallingActivity()
    {
      return this.mCallingActivity;
    }

    public Drawable getCallingActivityIcon()
    {
      int i = 0;
      if (this.mCallingActivity == null);
      while (true)
      {
        return i;
        PackageManager localPackageManager = ShareCompat.this.getPackageManager();
        try
        {
          ComponentName localComponentName = this.mCallingActivity;
          Drawable localDrawable = localPackageManager.getActivityIcon(localComponentName);
        }
        catch (PackageManager.NameNotFoundException localNameNotFoundException)
        {
          Log.e("IntentReader", "Could not retrieve icon for calling activity", localNameNotFoundException);
        }
      }
    }

    public Drawable getCallingApplicationIcon()
    {
      int i = 0;
      if (this.mCallingPackage == null);
      while (true)
      {
        return i;
        PackageManager localPackageManager = ShareCompat.this.getPackageManager();
        try
        {
          String str = this.mCallingPackage;
          Drawable localDrawable = localPackageManager.getApplicationIcon(str);
        }
        catch (PackageManager.NameNotFoundException localNameNotFoundException)
        {
          Log.e("IntentReader", "Could not retrieve icon for calling application", localNameNotFoundException);
        }
      }
    }

    public CharSequence getCallingApplicationLabel()
    {
      int i = 0;
      if (this.mCallingPackage == null);
      while (true)
      {
        return i;
        PackageManager localPackageManager = ShareCompat.this.getPackageManager();
        try
        {
          String str = this.mCallingPackage;
          ApplicationInfo localApplicationInfo = localPackageManager.getApplicationInfo(str, 0);
          CharSequence localCharSequence = localPackageManager.getApplicationLabel(localApplicationInfo);
        }
        catch (PackageManager.NameNotFoundException localNameNotFoundException)
        {
          Log.e("IntentReader", "Could not retrieve label for calling application", localNameNotFoundException);
        }
      }
    }

    public String getCallingPackage()
    {
      return this.mCallingPackage;
    }

    public String[] getEmailBcc()
    {
      return this.mIntent.getStringArrayExtra("android.intent.extra.BCC");
    }

    public String[] getEmailCc()
    {
      return this.mIntent.getStringArrayExtra("android.intent.extra.CC");
    }

    public String[] getEmailTo()
    {
      return this.mIntent.getStringArrayExtra("android.intent.extra.EMAIL");
    }

    public String getHtmlText()
    {
      String str = this.mIntent.getStringExtra("android.intent.extra.HTML_TEXT");
      CharSequence localCharSequence;
      if (this.mIntent == null)
      {
        localCharSequence = getText();
        if (!(localCharSequence instanceof Spanned))
          break label39;
        str = Html.toHtml((Spanned)localCharSequence);
      }
      while (true)
      {
        return str;
        label39: if (localCharSequence == null)
          continue;
        str = ShareCompat.IMPL.escapeHtml(localCharSequence);
      }
    }

    public Uri getStream()
    {
      return (Uri)this.mIntent.getParcelableExtra("android.intent.extra.STREAM");
    }

    public Uri getStream(int paramInt)
    {
      Object localObject = this.mStreams;
      if (localObject == null)
      {
        localObject = isMultipleShare();
        if (localObject != 0)
        {
          localObject = this.mIntent.getParcelableArrayListExtra("android.intent.extra.STREAM");
          this.mStreams = ((ArrayList)localObject);
        }
      }
      localObject = this.mStreams;
      if (localObject != null);
      for (localObject = (Uri)this.mStreams.get(paramInt); ; localObject = (Uri)this.mIntent.getParcelableExtra("android.intent.extra.STREAM"))
      {
        return localObject;
        if (paramInt != 0)
          break;
      }
      StringBuilder localStringBuilder = new StringBuilder().append("Stream items available: ");
      int i = getStreamCount();
      String str = i + " index requested: " + paramInt;
      throw new IndexOutOfBoundsException(str);
    }

    public int getStreamCount()
    {
      Object localObject1 = this.mStreams;
      if (localObject1 == null)
      {
        localObject1 = isMultipleShare();
        if (localObject1 != 0)
        {
          localObject1 = this.mIntent.getParcelableArrayListExtra("android.intent.extra.STREAM");
          this.mStreams = ((ArrayList)localObject1);
        }
      }
      localObject1 = this.mStreams;
      if (localObject1 != null)
        localObject1 = this.mStreams.size();
      while (true)
      {
        return localObject1;
        localObject1 = this.mIntent.hasExtra("android.intent.extra.STREAM");
        if (localObject1 != 0)
        {
          int i = 1;
          continue;
        }
        Object localObject2 = null;
      }
    }

    public String getSubject()
    {
      return this.mIntent.getStringExtra("android.intent.extra.SUBJECT");
    }

    public CharSequence getText()
    {
      return this.mIntent.getCharSequenceExtra("android.intent.extra.TEXT");
    }

    public String getType()
    {
      return this.mIntent.getType();
    }

    public boolean isMultipleShare()
    {
      return this.mIntent.getAction().equals("android.intent.action.SEND_MULTIPLE");
    }

    public boolean isShareIntent()
    {
      String str = this.mIntent.getAction();
      boolean bool = str.equals("android.intent.action.SEND");
      if (!bool)
      {
        bool = str.equals("android.intent.action.SEND_MULTIPLE");
        if (!bool);
      }
      else
      {
        bool = true;
      }
      while (true)
      {
        return bool;
        Object localObject = null;
      }
    }

    public boolean isSingleShare()
    {
      return this.mIntent.getAction().equals("android.intent.action.SEND");
    }
  }

  public class IntentBuilder
  {

    @Signature({"Ljava/util/ArrayList", "<", "Ljava/lang/String;", ">;"})
    private ArrayList mBccAddresses;

    @Signature({"Ljava/util/ArrayList", "<", "Ljava/lang/String;", ">;"})
    private ArrayList mCcAddresses;
    private CharSequence mChooserTitle;
    private Intent mIntent;

    @Signature({"Ljava/util/ArrayList", "<", "Landroid/net/Uri;", ">;"})
    private ArrayList mStreams;

    @Signature({"Ljava/util/ArrayList", "<", "Ljava/lang/String;", ">;"})
    private ArrayList mToAddresses;

    private IntentBuilder()
    {
      Intent localIntent1 = new Intent().setAction("android.intent.action.SEND");
      this.mIntent = localIntent1;
      Intent localIntent2 = this.mIntent;
      String str = ShareCompat.this.getPackageName();
      localIntent2.putExtra("android.support.v4.app.EXTRA_CALLING_PACKAGE", str);
      Intent localIntent3 = this.mIntent;
      ComponentName localComponentName = ShareCompat.this.getComponentName();
      localIntent3.putExtra("android.support.v4.app.EXTRA_CALLING_ACTIVITY", localComponentName);
      this.mIntent.addFlags(524288);
    }

    @Signature({"(", "Ljava/lang/String;", "Ljava/util/ArrayList", "<", "Ljava/lang/String;", ">;)V"})
    private void combineArrayExtra(String paramString, ArrayList paramArrayList)
    {
      int i = 0;
      String[] arrayOfString1 = this.mIntent.getStringArrayExtra(paramString);
      if (arrayOfString1 != null);
      for (int j = arrayOfString1.length; ; j = i)
      {
        String[] arrayOfString2 = new String[paramArrayList.size() + j];
        paramArrayList.toArray(arrayOfString2);
        if (arrayOfString1 != null)
        {
          int k = paramArrayList.size();
          System.arraycopy(arrayOfString1, i, arrayOfString2, k, j);
        }
        this.mIntent.putExtra(paramString, arrayOfString2);
        return;
      }
    }

    private void combineArrayExtra(String paramString, String[] paramArrayOfString)
    {
      int i = 0;
      Intent localIntent = getIntent();
      String[] arrayOfString1 = localIntent.getStringArrayExtra(paramString);
      if (arrayOfString1 != null);
      for (int j = arrayOfString1.length; ; j = i)
      {
        String[] arrayOfString2 = new String[paramArrayOfString.length + j];
        if (arrayOfString1 != null)
          System.arraycopy(arrayOfString1, i, arrayOfString2, i, j);
        int k = paramArrayOfString.length;
        System.arraycopy(paramArrayOfString, i, arrayOfString2, j, k);
        localIntent.putExtra(paramString, arrayOfString2);
        return;
      }
    }

    public static IntentBuilder from(Activity paramActivity)
    {
      return new IntentBuilder(paramActivity);
    }

    public IntentBuilder addEmailBcc(String paramString)
    {
      if (this.mBccAddresses == null)
      {
        ArrayList localArrayList = new ArrayList();
        this.mBccAddresses = localArrayList;
      }
      this.mBccAddresses.add(paramString);
      return this;
    }

    public IntentBuilder addEmailBcc(String[] paramArrayOfString)
    {
      combineArrayExtra("android.intent.extra.BCC", paramArrayOfString);
      return this;
    }

    public IntentBuilder addEmailCc(String paramString)
    {
      if (this.mCcAddresses == null)
      {
        ArrayList localArrayList = new ArrayList();
        this.mCcAddresses = localArrayList;
      }
      this.mCcAddresses.add(paramString);
      return this;
    }

    public IntentBuilder addEmailCc(String[] paramArrayOfString)
    {
      combineArrayExtra("android.intent.extra.CC", paramArrayOfString);
      return this;
    }

    public IntentBuilder addEmailTo(String paramString)
    {
      if (this.mToAddresses == null)
      {
        ArrayList localArrayList = new ArrayList();
        this.mToAddresses = localArrayList;
      }
      this.mToAddresses.add(paramString);
      return this;
    }

    public IntentBuilder addEmailTo(String[] paramArrayOfString)
    {
      combineArrayExtra("android.intent.extra.EMAIL", paramArrayOfString);
      return this;
    }

    public IntentBuilder addStream(Uri paramUri)
    {
      Uri localUri = (Uri)this.mIntent.getParcelableExtra("android.intent.extra.STREAM");
      if (localUri == null)
        this = setStream(paramUri);
      while (true)
      {
        return this;
        if (this.mStreams == null)
        {
          ArrayList localArrayList = new ArrayList();
          this.mStreams = localArrayList;
        }
        if (localUri != null)
        {
          this.mIntent.removeExtra("android.intent.extra.STREAM");
          this.mStreams.add(localUri);
        }
        this.mStreams.add(paramUri);
      }
    }

    public Intent createChooserIntent()
    {
      Intent localIntent = getIntent();
      CharSequence localCharSequence = this.mChooserTitle;
      return Intent.createChooser(localIntent, localCharSequence);
    }

    Activity getActivity()
    {
      return ShareCompat.this;
    }

    public Intent getIntent()
    {
      int i = 1;
      int j = null;
      int k = 0;
      if (this.mToAddresses != null)
      {
        ArrayList localArrayList1 = this.mToAddresses;
        combineArrayExtra("android.intent.extra.EMAIL", localArrayList1);
        this.mToAddresses = k;
      }
      if (this.mCcAddresses != null)
      {
        ArrayList localArrayList2 = this.mCcAddresses;
        combineArrayExtra("android.intent.extra.CC", localArrayList2);
        this.mCcAddresses = k;
      }
      if (this.mBccAddresses != null)
      {
        ArrayList localArrayList3 = this.mBccAddresses;
        combineArrayExtra("android.intent.extra.BCC", localArrayList3);
        this.mBccAddresses = k;
      }
      if ((this.mStreams != null) && (this.mStreams.size() > i))
      {
        boolean bool = this.mIntent.getAction().equals("android.intent.action.SEND_MULTIPLE");
        if ((i == null) && (bool))
        {
          this.mIntent.setAction("android.intent.action.SEND");
          if ((this.mStreams == null) || (this.mStreams.isEmpty()))
            break label253;
          Intent localIntent1 = this.mIntent;
          Parcelable localParcelable = (Parcelable)this.mStreams.get(j);
          localIntent1.putExtra("android.intent.extra.STREAM", j);
          label180: this.mStreams = k;
        }
        if ((i != null) && (!bool))
        {
          this.mIntent.setAction("android.intent.action.SEND_MULTIPLE");
          if ((this.mStreams == null) || (this.mStreams.isEmpty()))
            break label265;
          Intent localIntent2 = this.mIntent;
          ArrayList localArrayList4 = this.mStreams;
          localIntent2.putParcelableArrayListExtra("android.intent.extra.STREAM", localArrayList4);
        }
      }
      while (true)
      {
        return this.mIntent;
        Object localObject = j;
        break;
        label253: this.mIntent.removeExtra("android.intent.extra.STREAM");
        break label180;
        label265: this.mIntent.removeExtra("android.intent.extra.STREAM");
      }
    }

    public IntentBuilder setChooserTitle(int paramInt)
    {
      CharSequence localCharSequence = ShareCompat.this.getText(paramInt);
      return setChooserTitle(localCharSequence);
    }

    public IntentBuilder setChooserTitle(CharSequence paramCharSequence)
    {
      this.mChooserTitle = paramCharSequence;
      return this;
    }

    public IntentBuilder setEmailBcc(String[] paramArrayOfString)
    {
      this.mIntent.putExtra("android.intent.extra.BCC", paramArrayOfString);
      return this;
    }

    public IntentBuilder setEmailCc(String[] paramArrayOfString)
    {
      this.mIntent.putExtra("android.intent.extra.CC", paramArrayOfString);
      return this;
    }

    public IntentBuilder setEmailTo(String[] paramArrayOfString)
    {
      if (this.mToAddresses != null)
        this.mToAddresses = null;
      this.mIntent.putExtra("android.intent.extra.EMAIL", paramArrayOfString);
      return this;
    }

    public IntentBuilder setHtmlText(String paramString)
    {
      this.mIntent.putExtra("android.intent.extra.HTML_TEXT", paramString);
      if (!this.mIntent.hasExtra("android.intent.extra.TEXT"))
      {
        Spanned localSpanned = Html.fromHtml(paramString);
        setText(localSpanned);
      }
      return this;
    }

    public IntentBuilder setStream(Uri paramUri)
    {
      if (!this.mIntent.getAction().equals("android.intent.action.SEND"))
        this.mIntent.setAction("android.intent.action.SEND");
      this.mStreams = null;
      this.mIntent.putExtra("android.intent.extra.STREAM", paramUri);
      return this;
    }

    public IntentBuilder setSubject(String paramString)
    {
      this.mIntent.putExtra("android.intent.extra.SUBJECT", paramString);
      return this;
    }

    public IntentBuilder setText(CharSequence paramCharSequence)
    {
      this.mIntent.putExtra("android.intent.extra.TEXT", paramCharSequence);
      return this;
    }

    public IntentBuilder setType(String paramString)
    {
      this.mIntent.setType(paramString);
      return this;
    }

    public void startChooser()
    {
      Activity localActivity = ShareCompat.this;
      Intent localIntent = createChooserIntent();
      localActivity.startActivity(localIntent);
    }
  }

  class ShareCompatImplJB extends ShareCompat.ShareCompatImplICS
  {
    public String escapeHtml(CharSequence paramCharSequence)
    {
      return ShareCompatJB.escapeHtml(paramCharSequence);
    }

    boolean shouldAddChooserIntent(MenuItem paramMenuItem)
    {
      return null;
    }
  }

  class ShareCompatImplICS extends ShareCompat.ShareCompatImplBase
  {
    public void configureMenuItem(MenuItem paramMenuItem, ShareCompat.IntentBuilder paramIntentBuilder)
    {
      Activity localActivity = paramIntentBuilder.getActivity();
      Intent localIntent1 = paramIntentBuilder.getIntent();
      ShareCompatICS.configureMenuItem(paramMenuItem, localActivity, localIntent1);
      if (shouldAddChooserIntent(paramMenuItem))
      {
        Intent localIntent2 = paramIntentBuilder.createChooserIntent();
        paramMenuItem.setIntent(localIntent2);
      }
    }

    boolean shouldAddChooserIntent(MenuItem paramMenuItem)
    {
      boolean bool = paramMenuItem.hasSubMenu();
      if (!bool)
        bool = true;
      while (true)
      {
        return bool;
        Object localObject = null;
      }
    }
  }

  class ShareCompatImplBase
    implements ShareCompat.ShareCompatImpl
  {
    private static void withinStyle(StringBuilder paramStringBuilder, CharSequence paramCharSequence, int paramInt1, int paramInt2)
    {
      char c1 = ' ';
      int i = paramInt1;
      if (i < paramInt2)
      {
        char c2 = paramCharSequence.charAt(i);
        if (c2 == '<')
          paramStringBuilder.append("&lt;");
        while (true)
        {
          i++;
          break;
          if (c2 == '>')
          {
            paramStringBuilder.append("&gt;");
            continue;
          }
          if (c2 == '&')
          {
            paramStringBuilder.append("&amp;");
            continue;
          }
          if ((c2 > '~') || (c2 < c1))
          {
            String str = "&#" + c2 + ";";
            paramStringBuilder.append(str);
            continue;
          }
          if (c2 == c1)
          {
            while (i + 1 < paramInt2)
            {
              int j = i + 1;
              if (paramCharSequence.charAt(j) != c1)
                break;
              paramStringBuilder.append("&nbsp;");
              i++;
            }
            paramStringBuilder.append(c1);
            continue;
          }
          paramStringBuilder.append(c2);
        }
      }
    }

    public void configureMenuItem(MenuItem paramMenuItem, ShareCompat.IntentBuilder paramIntentBuilder)
    {
      Intent localIntent = paramIntentBuilder.createChooserIntent();
      paramMenuItem.setIntent(localIntent);
    }

    public String escapeHtml(CharSequence paramCharSequence)
    {
      StringBuilder localStringBuilder = new StringBuilder();
      int i = paramCharSequence.length();
      withinStyle(localStringBuilder, paramCharSequence, 0, i);
      return localStringBuilder.toString();
    }
  }

  abstract interface ShareCompatImpl
  {
    public abstract void configureMenuItem(MenuItem paramMenuItem, ShareCompat.IntentBuilder paramIntentBuilder);

    public abstract String escapeHtml(CharSequence paramCharSequence);
  }
}