package android.support.v4.widget;

import android.widget.SearchView.OnQueryTextListener;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
final class SearchViewCompatHoneycomb$1
  implements SearchView.OnQueryTextListener
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