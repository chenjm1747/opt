package com.example.notification;

import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.text.Editable;
import android.widget.EditText;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
class MainActivity$1
  implements DialogInterface.OnClickListener
{
  public void onClick(DialogInterface paramDialogInterface, int paramInt)
  {
    MainActivity localMainActivity = this.this$0;
    String str = this.val$userName.getText().toString();
    MainActivity.access$1(localMainActivity, str);
  }
}