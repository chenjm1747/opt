package android.support.v4.app;

import android.app.Activity;
import android.content.Intent;
import android.view.ActionProvider;
import android.view.MenuItem;
import android.widget.ShareActionProvider;

class ShareCompatICS
{
  private static final String HISTORY_FILENAME_PREFIX = ".sharecompat_";

  public static void configureMenuItem(MenuItem paramMenuItem, Activity paramActivity, Intent paramIntent)
  {
    ActionProvider localActionProvider = paramMenuItem.getActionProvider();
    ShareActionProvider localShareActionProvider = null;
    if (!(localActionProvider instanceof ShareActionProvider));
    for (localShareActionProvider = new ShareActionProvider(paramActivity); ; localShareActionProvider = (ShareActionProvider)localActionProvider)
    {
      StringBuilder localStringBuilder = new StringBuilder().append(".sharecompat_");
      String str1 = paramActivity.getClass().getName();
      String str2 = str1;
      localShareActionProvider.setShareHistoryFileName(str2);
      localShareActionProvider.setShareIntent(paramIntent);
      paramMenuItem.setActionProvider(localShareActionProvider);
      return;
    }
  }
}