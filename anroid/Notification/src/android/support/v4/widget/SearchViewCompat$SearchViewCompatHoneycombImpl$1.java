package android.support.v4.widget;

import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
class SearchViewCompat$SearchViewCompatHoneycombImpl$1
  implements SearchViewCompatHoneycomb.OnQueryTextListenerCompatBridge
{
  public boolean onQueryTextChange(String paramString)
  {
    return this.val$listener.onQueryTextChange(paramString);
  }

  public boolean onQueryTextSubmit(String paramString)
  {
    return this.val$listener.onQueryTextSubmit(paramString);
  }
}