package android.support.v4.widget;

import android.widget.SearchView.OnCloseListener;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
final class SearchViewCompatHoneycomb$2
  implements SearchView.OnCloseListener
{
  public boolean onClose()
  {
    return this.val$listener.onClose();
  }
}