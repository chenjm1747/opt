package android.support.v4.app;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.support.v4.content.IntentCompat;
import android.util.Log;
import dalvik.annotation.Signature;

public class NavUtils
{
  private static final NavUtilsImpl IMPL;
  public static final String PARENT_ACTIVITY = "android.support.PARENT_ACTIVITY";
  private static final String TAG = "NavUtils";

  static
  {
    if (Build.VERSION.SDK_INT >= 16)
      IMPL = new NavUtilsImplJB();
    while (true)
    {
      return;
      IMPL = new NavUtilsImplBase();
    }
  }

  public static Intent getParentActivityIntent(Activity paramActivity)
  {
    return IMPL.getParentActivityIntent(paramActivity);
  }

  public static Intent getParentActivityIntent(Context paramContext, ComponentName paramComponentName)
    throws PackageManager.NameNotFoundException
  {
    String str1 = getParentActivityName(paramContext, paramComponentName);
    if (str1 == null)
    {
      int i = 0;
      return i;
    }
    String str2 = paramComponentName.getPackageName();
    ComponentName localComponentName = new ComponentName(str2, str1);
    if (getParentActivityName(paramContext, localComponentName) == null);
    for (Intent localIntent = IntentCompat.makeMainActivity(localComponentName); ; localIntent = new Intent().setComponent(localComponentName))
      break;
  }

  @Signature({"(", "Landroid/content/Context;", "Ljava/lang/Class", "<*>;)", "Landroid/content/Intent;"})
  public static Intent getParentActivityIntent(Context paramContext, Class paramClass)
    throws PackageManager.NameNotFoundException
  {
    ComponentName localComponentName1 = new ComponentName(paramContext, paramClass);
    String str = getParentActivityName(paramContext, localComponentName1);
    if (str == null)
    {
      int i = 0;
      return i;
    }
    ComponentName localComponentName2 = new ComponentName(paramContext, str);
    if (getParentActivityName(paramContext, localComponentName2) == null);
    for (Intent localIntent = IntentCompat.makeMainActivity(localComponentName2); ; localIntent = new Intent().setComponent(localComponentName2))
      break;
  }

  public static String getParentActivityName(Activity paramActivity)
  {
    try
    {
      Object localObject = paramActivity.getComponentName();
      localObject = getParentActivityName(paramActivity, (ComponentName)localObject);
      return localObject;
    }
    catch (PackageManager.NameNotFoundException localNameNotFoundException)
    {
    }
    throw new IllegalArgumentException(localNameNotFoundException);
  }

  public static String getParentActivityName(Context paramContext, ComponentName paramComponentName)
    throws PackageManager.NameNotFoundException
  {
    ActivityInfo localActivityInfo = paramContext.getPackageManager().getActivityInfo(paramComponentName, 128);
    return IMPL.getParentActivityName(paramContext, localActivityInfo);
  }

  public static void navigateUpFromSameTask(Activity paramActivity)
  {
    Intent localIntent = getParentActivityIntent(paramActivity);
    if (localIntent == null)
    {
      StringBuilder localStringBuilder = new StringBuilder().append("Activity ");
      String str1 = paramActivity.getClass().getSimpleName();
      String str2 = str1 + " does not have a parent activity name specified." + " (Did you forget to add the android.support.PARENT_ACTIVITY <meta-data> " + " element in your manifest?)";
      throw new IllegalArgumentException(str2);
    }
    navigateUpTo(paramActivity, localIntent);
  }

  public static void navigateUpTo(Activity paramActivity, Intent paramIntent)
  {
    IMPL.navigateUpTo(paramActivity, paramIntent);
  }

  public static boolean shouldUpRecreateTask(Activity paramActivity, Intent paramIntent)
  {
    return IMPL.shouldUpRecreateTask(paramActivity, paramIntent);
  }

  class NavUtilsImplJB extends NavUtils.NavUtilsImplBase
  {
    public Intent getParentActivityIntent(Activity paramActivity)
    {
      Intent localIntent = NavUtilsJB.getParentActivityIntent(paramActivity);
      if (localIntent == null)
        localIntent = superGetParentActivityIntent(paramActivity);
      return localIntent;
    }

    public String getParentActivityName(Context paramContext, ActivityInfo paramActivityInfo)
    {
      String str = NavUtilsJB.getParentActivityName(paramActivityInfo);
      if (str == null)
        str = super.getParentActivityName(paramContext, paramActivityInfo);
      return str;
    }

    public void navigateUpTo(Activity paramActivity, Intent paramIntent)
    {
      NavUtilsJB.navigateUpTo(paramActivity, paramIntent);
    }

    public boolean shouldUpRecreateTask(Activity paramActivity, Intent paramIntent)
    {
      return NavUtilsJB.shouldUpRecreateTask(paramActivity, paramIntent);
    }

    Intent superGetParentActivityIntent(Activity paramActivity)
    {
      return super.getParentActivityIntent(paramActivity);
    }
  }

  class NavUtilsImplBase
    implements NavUtils.NavUtilsImpl
  {
    public Intent getParentActivityIntent(Activity paramActivity)
    {
      int i = 0;
      String str1 = NavUtils.getParentActivityName(paramActivity);
      if (str1 == null);
      while (true)
      {
        return i;
        ComponentName localComponentName = new ComponentName(paramActivity, str1);
        try
        {
          if (NavUtils.getParentActivityName(paramActivity, localComponentName) == null);
          for (Intent localIntent = IntentCompat.makeMainActivity(localComponentName); ; localIntent = new Intent().setComponent(localComponentName))
            break;
        }
        catch (PackageManager.NameNotFoundException localNameNotFoundException)
        {
          String str2 = "getParentActivityIntent: bad parentActivityName '" + str1 + "' in manifest";
          Log.e("NavUtils", str2);
        }
      }
    }

    public String getParentActivityName(Context paramContext, ActivityInfo paramActivityInfo)
    {
      int i = 0;
      Object localObject;
      if (paramActivityInfo.metaData == null)
        localObject = i;
      while (true)
      {
        return localObject;
        localObject = paramActivityInfo.metaData.getString("android.support.PARENT_ACTIVITY");
        if (localObject == null)
        {
          localObject = i;
          continue;
        }
        if (((String)localObject).charAt(0) != '.')
          continue;
        StringBuilder localStringBuilder = new StringBuilder();
        String str = paramContext.getPackageName();
        localObject = str + (String)localObject;
      }
    }

    public void navigateUpTo(Activity paramActivity, Intent paramIntent)
    {
      paramIntent.addFlags(67108864);
      paramActivity.startActivity(paramIntent);
      paramActivity.finish();
    }

    public boolean shouldUpRecreateTask(Activity paramActivity, Intent paramIntent)
    {
      Object localObject1 = paramActivity.getIntent();
      String str = ((Intent)localObject1).getAction();
      int i;
      if (str != null)
      {
        localObject1 = str.equals("android.intent.action.MAIN");
        if (localObject1 == 0)
          i = 1;
      }
      while (true)
      {
        return i;
        Object localObject2 = null;
      }
    }
  }

  abstract interface NavUtilsImpl
  {
    public abstract Intent getParentActivityIntent(Activity paramActivity);

    public abstract String getParentActivityName(Context paramContext, ActivityInfo paramActivityInfo);

    public abstract void navigateUpTo(Activity paramActivity, Intent paramIntent);

    public abstract boolean shouldUpRecreateTask(Activity paramActivity, Intent paramIntent);
  }
}