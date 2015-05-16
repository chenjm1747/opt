package android.support.v4.view;

import android.content.Context;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.text.method.SingleLineTransformationMethod;
import android.view.View;
import android.widget.TextView;
import java.util.Locale;

class PagerTitleStripIcs
{
  public static void setSingleLineAllCaps(TextView paramTextView)
  {
    Context localContext = paramTextView.getContext();
    SingleLineAllCapsTransform localSingleLineAllCapsTransform = new SingleLineAllCapsTransform();
    paramTextView.setTransformationMethod(localSingleLineAllCapsTransform);
  }

  class SingleLineAllCapsTransform extends SingleLineTransformationMethod
  {
    private static final String TAG = "SingleLineAllCapsTransform";
    private Locale mLocale;

    public SingleLineAllCapsTransform()
    {
      Locale localLocale = this$1.getResources().getConfiguration().locale;
      this.mLocale = localLocale;
    }

    public CharSequence getTransformation(CharSequence paramCharSequence, View paramView)
    {
      paramCharSequence = super.getTransformation(paramCharSequence, paramView);
      String str;
      if (paramCharSequence != null)
      {
        str = paramCharSequence.toString();
        Locale localLocale = this.mLocale;
        str = str.toUpperCase(localLocale);
      }
      while (true)
      {
        return str;
        int i = 0;
      }
    }
  }
}