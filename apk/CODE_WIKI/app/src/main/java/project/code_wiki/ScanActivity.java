package project.code_wiki;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.media.AudioManager;
import android.net.Uri;
import android.os.Bundle;
import android.os.Vibrator;
import android.preference.PreferenceManager;
import android.support.v7.app.AppCompatActivity;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.ResultPoint;
import com.journeyapps.barcodescanner.BarcodeCallback;
import com.journeyapps.barcodescanner.BarcodeResult;
import com.journeyapps.barcodescanner.DecoratedBarcodeView;
import com.journeyapps.barcodescanner.DefaultDecoderFactory;

import java.util.Arrays;
import java.util.Collection;
import java.util.List;

public class ScanActivity extends AppCompatActivity {
    private DecoratedBarcodeView barcodeView;
    private BackPressCloseHandler backPressCloseHandler;
    private Boolean isFlashOn=false;
    private BarcodeCallback callback = new BarcodeCallback() {
        @Override
        public void barcodeResult(BarcodeResult result) {
            /*
            if (result.getText() == null || result.getText().equals(lastText)) {
                // Prevent duplicate scans
                return;
            }
            lastText = result.getText();

            barcodeView.setStatusText(result.getText());
            */

            ResultScan resultScan = getBarcodeInfo(result);
            Intent intent;
            if(checkCodeIDisURL(resultScan.getCodeID()) && isUrlQuickView()) {
                startVibrate(100);
                printToast();
                intent = new Intent(Intent.ACTION_VIEW, Uri.parse(resultScan.getCodeID()));
            } else {
                intent = new Intent(ScanActivity.this, PopupResult.class);
                intent.putExtra("result", resultScan);
            }
            startActivity(intent);

            //Added preview of scanned barcode
            /*ImageView imageView = (ImageView) findViewById(R.id.barcodePreview);
            imageView.setImageBitmap(result.getBitmapWithResultPoints(Color.YELLOW));*/
        }

        @Override
        public void possibleResultPoints(List<ResultPoint> resultPoints) {
        }
    };

    private boolean checkCodeIDisURL (String codeID) {
        String checkStr=codeID.substring(0,4);
        if (checkStr.equals("http") || checkStr.equals("www.")) {
            return true;
        }
        return false;
    }

    private ResultScan getBarcodeInfo(BarcodeResult result) {
        String codeID=result.getText();
        BarcodeFormat type=result.getBarcodeFormat();
        Bitmap scanImg=result.getBitmapWithResultPoints(Color.YELLOW);
        ResultScan resultScan=new ResultScan(codeID, type, scanImg);

        return resultScan;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_scan);
        backPressCloseHandler = new BackPressCloseHandler(this);
        initBarcodeView();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_scan, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();

        if(id == R.id.menuFlashOn) {
            barcodeView.setTorchOn();
            isFlashOn=true;
            invalidateOptionsMenu();
        } else if(id == R.id.menuFlashOFF) {
            barcodeView.setTorchOff();
            isFlashOn=false;
            invalidateOptionsMenu();
        } else if(id == R.id.menuSetting) {
            Intent intent = new Intent(ScanActivity.this, SettingsActivity.class);
            startActivity(intent);
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    public boolean onPrepareOptionsMenu(Menu menu) {
        if(!isFlashOn) {
            menu.findItem(R.id.menuFlashOn).setVisible(true);
            menu.findItem(R.id.menuFlashOFF).setVisible(false);
        } else {
            menu.findItem(R.id.menuFlashOn).setVisible(false);
            menu.findItem(R.id.menuFlashOFF).setVisible(true);
        }
        return super.onPrepareOptionsMenu(menu);
    }

    private void initBarcodeView() {
        barcodeView = findViewById(R.id.barcode_scanner);
        Collection<BarcodeFormat> formats = Arrays.asList(BarcodeFormat.QR_CODE, BarcodeFormat.CODE_39);
        barcodeView.getBarcodeView().setDecoderFactory(new DefaultDecoderFactory(formats));
        barcodeView.initializeFromIntent(getIntent());
        barcodeView.setTorchOff();
        barcodeView.decodeContinuous(callback);
    }

    @Override
    protected void onPause() {
        super.onPause();

        barcodeView.pause();
    }

    @Override
    protected void onResume() {
        super.onResume();

        barcodeView.resume();
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        //return barcodeView.onKeyDown(keyCode, event) || super.onKeyDown(keyCode, event);
        //return super.onKeyDown(keyCode, event);
        switch (keyCode) {
            case KeyEvent.KEYCODE_FOCUS:
            case KeyEvent.KEYCODE_CAMERA:
                // Handle these events so they don't launch the Camera app
                return true;
            // Use volume up/down to turn on light
            case KeyEvent.KEYCODE_VOLUME_DOWN:
            case KeyEvent.KEYCODE_VOLUME_UP:
                if(!isFlashOn) { barcodeView.setTorchOn(); } else {barcodeView.setTorchOff();}
                isFlashOn=!isFlashOn;
                invalidateOptionsMenu();
                setVolumeControlStream(AudioManager.AUDIOFOCUS_NONE);
                return true;
        }
        return super.onKeyDown(keyCode, event);
    }

    @Override
    public void onBackPressed() {
        backPressCloseHandler.onBackPressed();
    }

    private boolean isUrlQuickView() {
        SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(this);
        return sharedPreferences.getBoolean("url_quick_view",false);
    }

    private void startVibrate(int msec) {
        final Vibrator vibrator = (Vibrator)getSystemService(Context.VIBRATOR_SERVICE);
        vibrator.vibrate(msec);
    }

    private void printToast() {
        Toast.makeText(getApplicationContext(),
                "스캔한 URL로 바로 연결됩니다.",Toast.LENGTH_SHORT).show();
    }
}
