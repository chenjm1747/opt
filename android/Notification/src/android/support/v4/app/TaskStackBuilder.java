package android.support.v4.app;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.support.v4.content.ContextCompat;
import android.util.Log;
import dalvik.annotation.Signature;
import java.util.ArrayList;
import java.util.Iterator;

@Signature({"Ljava/lang/Object;", "Ljava/lang/Iterable", "<", "Landroid/content/Intent;", ">;"})
public class TaskStackBuilder
  implements Iterable
{
  private static final TaskStackBuilderImpl IMPL;
  private static final String TAG = "TaskStackBuilder";

  @Signature({"Ljava/util/ArrayList", "<", "Landroid/content/Intent;", ">;"})
  private final ArrayList mIntents;
  private final Context mSourceContext;

  static
  {
    if (Build.VERSION.SDK_INT >= 11)
      IMPL = new TaskStackBuilderImplHoneycomb();
    while (true)
    {
      return;
      IMPL = new TaskStackBuilderImplBase();
    }
  }

  private TaskStackBuilder(Context paramContext)
  {
    ArrayList localArrayList = new ArrayList();
    this.mIntents = localArrayList;
    this.mSourceContext = paramContext;
  }

  public static TaskStackBuilder create(Context paramContext)
  {
    return new TaskStackBuilder(paramContext);
  }

  public static TaskStackBuilder from(Context paramContext)
  {
    return create(paramContext);
  }

  public TaskStackBuilder addNextIntent(Intent paramIntent)
  {
    this.mIntents.add(paramIntent);
    return this;
  }

  public TaskStackBuilder addNextIntentWithParentStack(Intent paramIntent)
  {
    ComponentName localComponentName = paramIntent.getComponent();
    if (localComponentName == null)
    {
      PackageManager localPackageManager = this.mSourceContext.getPackageManager();
      localComponentName = paramIntent.resolveActivity(localPackageManager);
    }
    if (localComponentName != null)
      addParentStack(localComponentName);
    addNextIntent(paramIntent);
    return this;
  }

  public TaskStackBuilder addParentStack(Activity paramActivity)
  {
    Intent localIntent = NavUtils.getParentActivityIntent(paramActivity);
    if (localIntent != null)
    {
      ComponentName localComponentName = localIntent.getComponent();
      if (localComponentName == null)
      {
        PackageManager localPackageManager = this.mSourceContext.getPackageManager();
        localComponentName = localIntent.resolveActivity(localPackageManager);
      }
      addParentStack(localComponentName);
      addNextIntent(localIntent);
    }
    return this;
  }

  public TaskStackBuilder addParentStack(ComponentName paramComponentName)
  {
    int i = this.mIntents.size();
    try
    {
      Context localContext;
      ComponentName localComponentName;
      for (Intent localIntent = NavUtils.getParentActivityIntent(this.mSourceContext, paramComponentName); localIntent != null; localIntent = NavUtils.getParentActivityIntent(localContext, localComponentName))
      {
        this.mIntents.add(i, localIntent);
        localContext = this.mSourceContext;
        localComponentName = localIntent.getComponent();
      }
    }
    catch (PackageManager.NameNotFoundException localNameNotFoundException)
    {
      Log.e("TaskStackBuilder", "Bad ComponentName while traversing activity parent metadata");
      throw new IllegalArgumentException(localNameNotFoundException);
    }
    return this;
  }

  @Signature({"(", "Ljava/lang/Class", "<*>;)", "Landroid/support/v4/app/TaskStackBuilder;"})
  public TaskStackBuilder addParentStack(Class paramClass)
  {
    Context localContext = this.mSourceContext;
    ComponentName localComponentName = new ComponentName(localContext, paramClass);
    return addParentStack(localComponentName);
  }

  public Intent editIntentAt(int paramInt)
  {
    return (Intent)this.mIntents.get(paramInt);
  }

  public Intent getIntent(int paramInt)
  {
    return editIntentAt(paramInt);
  }

  public int getIntentCount()
  {
    return this.mIntents.size();
  }

  public Intent[] getIntents()
  {
    int i = 0;
    Intent[] arrayOfIntent = new Intent[this.mIntents.size()];
    if (arrayOfIntent.length == 0)
      return arrayOfIntent;
    Intent localIntent1 = (Intent)this.mIntents.get(i);
    Intent localIntent2 = new Intent(localIntent1).addFlags(268484608);
    arrayOfIntent[i] = localIntent2;
    for (int j = 1; ; j++)
    {
      int k = arrayOfIntent.length;
      if (j >= k)
        break;
      Intent localIntent3 = (Intent)this.mIntents.get(j);
      Intent localIntent4 = new Intent(localIntent3);
      arrayOfIntent[j] = localIntent4;
    }
  }

  public PendingIntent getPendingIntent(int paramInt1, int paramInt2)
  {
    return getPendingIntent(paramInt1, paramInt2, null);
  }

  public PendingIntent getPendingIntent(int paramInt1, int paramInt2, Bundle paramBundle)
  {
    int i = 0;
    if (this.mIntents.isEmpty())
      throw new IllegalStateException("No intents added to TaskStackBuilder; cannot getPendingIntent");
    ArrayList localArrayList = this.mIntents;
    Intent[] arrayOfIntent1 = new Intent[this.mIntents.size()];
    Intent[] arrayOfIntent2 = (Intent[])localArrayList.toArray(arrayOfIntent1);
    Intent localIntent1 = arrayOfIntent2[i];
    Intent localIntent2 = new Intent(localIntent1).addFlags(268484608);
    arrayOfIntent2[i] = localIntent2;
    TaskStackBuilderImpl localTaskStackBuilderImpl = IMPL;
    Context localContext = this.mSourceContext;
    int j = paramInt1;
    int k = paramInt2;
    Bundle localBundle = paramBundle;
    return localTaskStackBuilderImpl.getPendingIntent(localContext, arrayOfIntent2, i, k, localBundle);
  }

  @Signature({"()", "Ljava/util/Iterator", "<", "Landroid/content/Intent;", ">;"})
  public Iterator iterator()
  {
    return this.mIntents.iterator();
  }

  public void startActivities()
  {
    startActivities(null);
  }

  public void startActivities(Bundle paramBundle)
  {
    int i = 0;
    if (this.mIntents.isEmpty())
      throw new IllegalStateException("No intents added to TaskStackBuilder; cannot startActivities");
    ArrayList localArrayList = this.mIntents;
    Intent[] arrayOfIntent1 = new Intent[this.mIntents.size()];
    Intent[] arrayOfIntent2 = (Intent[])localArrayList.toArray(arrayOfIntent1);
    Intent localIntent1 = arrayOfIntent2[i];
    Intent localIntent2 = new Intent(localIntent1).addFlags(268484608);
    arrayOfIntent2[i] = localIntent2;
    if (!ContextCompat.startActivities(this.mSourceContext, arrayOfIntent2, paramBundle))
    {
      int j = arrayOfIntent2.length;
      int k;
      k--;
      Intent localIntent3 = arrayOfIntent2[j];
      Intent localIntent4 = new Intent(localIntent3);
      localIntent4.addFlags(268435456);
      this.mSourceContext.startActivity(localIntent4);
    }
  }

  class TaskStackBuilderImplJellybean
    implements TaskStackBuilder.TaskStackBuilderImpl
  {
    public PendingIntent getPendingIntent(Context paramContext, Intent[] paramArrayOfIntent, int paramInt1, int paramInt2, Bundle paramBundle)
    {
      Intent localIntent1 = paramArrayOfIntent[null];
      Intent localIntent2 = new Intent(localIntent1).addFlags(268484608);
      paramArrayOfIntent[0] = localIntent2;
      return TaskStackBuilderJellybean.getActivitiesPendingIntent(paramContext, paramInt1, paramArrayOfIntent, paramInt2, paramBundle);
    }
  }

  class TaskStackBuilderImplHoneycomb
    implements TaskStackBuilder.TaskStackBuilderImpl
  {
    public PendingIntent getPendingIntent(Context paramContext, Intent[] paramArrayOfIntent, int paramInt1, int paramInt2, Bundle paramBundle)
    {
      Intent localIntent1 = paramArrayOfIntent[null];
      Intent localIntent2 = new Intent(localIntent1).addFlags(268484608);
      paramArrayOfIntent[0] = localIntent2;
      return TaskStackBuilderHoneycomb.getActivitiesPendingIntent(paramContext, paramInt1, paramArrayOfIntent, paramInt2);
    }
  }

  class TaskStackBuilderImplBase
    implements TaskStackBuilder.TaskStackBuilderImpl
  {
    public PendingIntent getPendingIntent(Context paramContext, Intent[] paramArrayOfIntent, int paramInt1, int paramInt2, Bundle paramBundle)
    {
      int i = paramArrayOfIntent.length;
      int j;
      j--;
      Intent localIntent1 = paramArrayOfIntent[i];
      Intent localIntent2 = new Intent(localIntent1);
      localIntent2.addFlags(268435456);
      return PendingIntent.getActivity(paramContext, paramInt1, localIntent2, paramInt2);
    }
  }

  abstract interface TaskStackBuilderImpl
  {
    public abstract PendingIntent getPendingIntent(Context paramContext, Intent[] paramArrayOfIntent, int paramInt1, int paramInt2, Bundle paramBundle);
  }
}