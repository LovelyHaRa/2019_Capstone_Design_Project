package project.code_wiki;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Vibrator;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

public class PopupResult extends AppCompatActivity {
    private ResultScan resultScan;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        startVibrate(100);
        setContentView(R.layout.activity_popup_result);
        setResultInfo();
        addPopupLayoutListener();
        addtxtCodeIDListener();
    }

    private void setResultInfo() {
        resultScan = getIntent().getParcelableExtra("result");
        TextView txtCodeID = findViewById(R.id.txtCodeID);
        txtCodeID.setText(resultScan.getCodeID());
        TextView txtCodeType = findViewById(R.id.txtCodeType);
        txtCodeType.setText(resultScan.getCodeType());
        TextView txtInfoType = findViewById(R.id.txtInfoType);
        if (checkCodeIDisURL(resultScan.getCodeID())) { txtInfoType.setText("URL"); }
        else { txtInfoType.setText("Normal"); }
        ImageView imageView = findViewById(R.id.imageViewScan);
        imageView.setImageBitmap(resultScan.getScanImg());
    }

    private void addPopupLayoutListener () {
        View view = findViewById(R.id.PopupLayout);
        view.setOnClickListener(new OnSingleClickListener() {
            @Override
            public void onSingleClick(View v) {
                Intent intent;
                if(!checkCodeIDisURL(resultScan.getCodeID())) {
                    intent = new Intent(PopupResult.this, ResultInfo.class);
                    intent.putExtra("codeID", resultScan.getCodeID());
                } else {
                    intent = new Intent(Intent.ACTION_VIEW, Uri.parse(resultScan.getCodeID()));
                }
                startActivity(intent);
                finish();
            }
        });
    }

    private void addtxtCodeIDListener () {
        View view = findViewById(R.id.txtCodeID);
        view.setOnClickListener(new OnSingleClickListener() {
            @Override
            public void onSingleClick(View v) {
                String title = "코드 내용";
                String content = resultScan.getCodeID();
                buildOKAlertDialog(title, content);
            }
        });
    }

    private void buildOKAlertDialog(String title, String content) {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(title);
        builder.setMessage(content);
        builder.setPositiveButton(R.string.ok,
            new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int which) { }
            });
        builder.show();
    }

    private boolean checkCodeIDisURL (String codeID) {
        String checkStr=codeID.substring(0,4);
        if (checkStr.equals("http") || checkStr.equals("www.")) {
            return true;
        }
        return false;
    }

    private void startVibrate(int msec) {
        final Vibrator vibrator = (Vibrator)getSystemService(Context.VIBRATOR_SERVICE);
        vibrator.vibrate(msec);
    }
}

