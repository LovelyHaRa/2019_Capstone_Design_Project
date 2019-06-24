package project.code_wiki;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Parcel;
import android.os.Parcelable;

import com.google.zxing.BarcodeFormat;

import java.io.ByteArrayOutputStream;

public class ResultScan implements Parcelable {
    private String codeID;
    private BarcodeFormat type;
    private byte[] scanImg;
    public static final  Parcelable.Creator<ResultScan> CREATOR = new Parcelable.Creator<ResultScan>() {
        @Override
        public ResultScan createFromParcel(Parcel source) {
            return new ResultScan(source);
        }

        @Override
        public ResultScan[] newArray(int size) {
            return new ResultScan[size];
        }
    };

    public ResultScan(Parcel source) {
        readFromParcel(source);
    }

    private void readFromParcel(Parcel source) {
        codeID = source.readString();
        type = (BarcodeFormat) source.readValue(null);
        int length=source.readInt();
        byte[] bytes=new byte[length];
        source.readByteArray(bytes);
        scanImg=bytes.clone();
    }

    public ResultScan(String codeID, BarcodeFormat type, Bitmap scanImg) {
        this.codeID = codeID;
        this.type = type;
        this.scanImg=imageToByte(scanImg);
    }

    private byte[] imageToByte(Bitmap img) {
        ByteArrayOutputStream stream = new ByteArrayOutputStream();
        img.compress(Bitmap.CompressFormat.PNG,100, stream);
        return stream.toByteArray();
    }

    public String getCodeID() { return codeID; }

    public String getType() { return type.toString(); }

    public String getCodeType() {
        String codeType=type.toString();
        String result="";
        switch (codeType) {
            /* QR(2D) Code */
            case "QR_CODE":
                result+="QR CODE";
                break;
            case "AZTEC":
            case "DATA_MATRIX":
            case "MAXICODE":
            case "PDF_417":
                result+="QR CODE(";
                result+=codeType+")";
                break;
            /* 1D Code */
            case "CODABAR":
            case "CODE_39":
            case "CODE_93":
            case "CODE_128":
            case "EAN_8":
            case "EAN_13":
            case "ITF":
            case "RSS_14":
            case "RSS_EXPANDED":
            case "UPC_A":
            case "UPC_E":
            case "UPC_EAN_EXTENSION":
                result+="BarCode(";
                result+=codeType+")";
                break;
        }
        return result;
    }

    public Bitmap getScanImg() {
        return BitmapFactory.decodeByteArray(this.scanImg,0,this.scanImg.length);
    }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(codeID);
        dest.writeValue(type);
        dest.writeInt(scanImg.length);
        dest.writeByteArray(scanImg);
    }
}